/*
 * contains the implementation of all syscalls.
 */

#include <stdint.h>
#include <errno.h>

#include "elf.h"
#include "riscv.h"
#include "util/types.h"
#include "syscall.h"
#include "string.h"
#include "process.h"
#include "util/functions.h"
#include "pmm.h"
#include "vmm.h"
#include "sched.h"
#include "proc_file.h"

#include "spike_interface/spike_utils.h"

//
// implement the SYS_user_print syscall
//
ssize_t sys_user_print(const char* buf, size_t n) {
  // buf is now an address in user space of the given app's user stack,
  // so we have to transfer it into phisical address (kernel is running in direct mapping).
  assert( current );
  char* pa = (char*)user_va_to_pa((pagetable_t)(current->pagetable), (void*)buf);
  sprint(pa);
  return 0;
}

//
// implement the SYS_user_exit syscall
//
ssize_t sys_user_exit(uint64 code) {
  sprint("User exit with code:%d.\n", code);
  // reclaim the current process, and reschedule. added @lab3_1
  free_process( current );
  // added @lab3_challenge_1
  wakeup_exit_waiting_process(current);
  schedule();
  return 0;
}

//
// maybe, the simplest implementation of malloc in the world ... added @lab2_2
//
uint64 sys_user_allocate_page(uint64 nb) {
  uint64 va;
  // first search for allocated page
  memory_descriptor *md = current->free_md_list_head;
  while(NULL != md && md->size < nb) {
    md = md->next;
  }
  if(NULL == md) { // no single satisfying memory_descriptor

    // try to use the last page and a new page (if any last md available)
    md = current->free_md_list_head;
    while(NULL != md && (md->page_start_va != current->user_free_va - PGSIZE || md->start_pa + md->size - md->page_start_pa != PGSIZE)) {
      md = md->next;
    }
    if(NULL == md) { // no last md available, need to allocate new page
      // sprint("new page\n");
      void* pa = alloc_page();
      va = current->user_free_va;
      // sprint("new page alloc pa = 0x%lx, va = 0x%lx\n", (uint64)pa, va);
      current->user_free_va += PGSIZE;
      user_vm_map((pagetable_t)current->pagetable, va, PGSIZE, (uint64)pa,
          prot_to_type(PROT_WRITE | PROT_READ, 1));

      for(int i = 0; i < PROC_MAX_PAGE_NUM; i++) {
        if(0 == current->page_cb[i].valid) {

          current->page_cb[i].valid = 1;
          current->page_cb[i].start_pa = (uint64)pa;
          current->page_cb[i].start_va = va;

          memory_descriptor *allocated_md = alloc_memory_descriptor();
          allocated_md->page_start_pa = (uint64)pa;
          allocated_md->page_start_va = va;
          allocated_md->start_pa = (uint64)pa;
          allocated_md->size = nb;
          allocated_md->succ = NULL;
          insert_into_md_list(&(current->allocated_md_list_head), allocated_md, 0);
          current->page_cb[i].allocated_md_num = 1;
          if(nb < PGSIZE) {
            memory_descriptor *free_md = alloc_memory_descriptor();
            free_md->page_start_pa = (uint64)pa;
            free_md->page_start_va = va;
            free_md->start_pa = (uint64)pa + nb;
            free_md->size = PGSIZE - nb;
            insert_into_md_list(&(current->free_md_list_head), free_md, 1);
          }
          break;
        }
      }
    } else { // now "md" is the last md

      remove_from_md_list(&(current->free_md_list_head), md);
      insert_into_md_list(&(current->allocated_md_list_head), md, 0);
      nb -= md->size;
      va = md->page_start_va + md->start_pa - md->page_start_pa;
      current->page_cb[get_page_id_by_start_pa(md->page_start_pa)].allocated_md_num++;
      // sprint("last md alloc pa = 0x%lx, va = 0x%lx\n", md->start_pa, va);

      // allocate a new page
      void *pa = alloc_page();
      user_vm_map((pagetable_t)current->pagetable, current->user_free_va, PGSIZE, (uint64)pa,
        prot_to_type(PROT_WRITE | PROT_READ, 1));
      for(int i = 0; i < PROC_MAX_PAGE_NUM; i++) {
        if(0 == current->page_cb[i].valid) {

          current->page_cb[i].valid = 1;
          current->page_cb[i].start_pa = (uint64)pa;
          current->page_cb[i].start_va = current->user_free_va;

          memory_descriptor *allocated_md = alloc_memory_descriptor();
          allocated_md->page_start_pa = (uint64)pa;
          allocated_md->page_start_va = current->user_free_va;
          allocated_md->start_pa = (uint64)pa;
          allocated_md->size = nb;
          allocated_md->succ = NULL;
          // do not insert allocated_md into allocated list
          md->succ = allocated_md; // record the succ of md
          // sprint("new page with last md alloc pa = 0x%lx, va = 0x%lx\n", allocated_md->start_pa, allocated_md->page_start_va);
          current->page_cb[i].allocated_md_num = 1;
          if(nb < PGSIZE) {
            memory_descriptor *free_md = alloc_memory_descriptor();
            free_md->page_start_pa = (uint64)pa;
            free_md->page_start_va = current->user_free_va;
            free_md->start_pa = (uint64)pa + nb;
            free_md->size = PGSIZE - nb;
            insert_into_md_list(&(current->free_md_list_head), free_md, 1);
          }
          break;
        }
      }
      current->user_free_va += PGSIZE;
    }
  } else {
    // sprint("existing page\n");
    uint64 allocated_start_pa;
    for(int i = 0; i < PROC_MAX_PAGE_NUM; i++) {
      if(current->page_cb[i].valid && current->page_cb[i].start_pa == md->page_start_pa) {
        current->page_cb[i].allocated_md_num++;
        break;
      }
    }
    // sprint("existing md pa = 0x%lx, va = 0x%lx\n", md->start_pa, md->page_start_va + md->start_pa - md->page_start_pa);
    if(md->size == nb) { // exactly the same size
      remove_from_md_list(&(current->free_md_list_head), md);
      insert_into_md_list(&(current->allocated_md_list_head), md, 0);
      md->succ = NULL;
      allocated_start_pa = md->start_pa;
      va = md->start_pa - md->page_start_pa + md->page_start_va;
    } else { // split the memory
      memory_descriptor *allocated_md = alloc_memory_descriptor();
      allocated_md->page_start_pa = md->page_start_pa;
      allocated_md->page_start_va = md->page_start_va;
      allocated_md->start_pa = md->start_pa;
      allocated_md->size = nb;
      allocated_md->succ = NULL;
      allocated_start_pa = allocated_md->start_pa;
      insert_into_md_list(&(current->allocated_md_list_head), allocated_md, 0);
      md->start_pa += nb;
      md->size -= nb;
      va = allocated_md->start_pa - allocated_md->page_start_pa + allocated_md->page_start_va;
    }
  }
  // sprint("va = 0x%lx\n", va);
  return va;
}

void free_single_md(memory_descriptor *md) {
  int page_id = get_page_id_by_start_pa(md->page_start_pa);
  remove_from_md_list(&(current->allocated_md_list_head), md);
  insert_into_md_list(&(current->free_md_list_head), md, 1);
  if(0 == --current->page_cb[page_id].allocated_md_num) { // free the whole page
    // sprint("free whole page pa = 0x%lx\n", current->page_cb[page_id].start_pa);
    md = current->free_md_list_head;
    while(NULL != md && md->page_start_pa != current->page_cb[page_id].start_pa) {
      md = md->next;
    }
    remove_from_md_list(&(current->free_md_list_head), md);
    free_memory_descriptor(md);
    user_vm_unmap((pagetable_t)current->pagetable, current->page_cb[page_id].start_va, PGSIZE, 1);
    current->page_cb[page_id].valid = 0;
  }
}

//
// reclaim a page, indicated by "va". added @lab2_2
//
uint64 sys_user_free_page(uint64 va) {

  memory_descriptor *now = current->allocated_md_list_head;
  while(NULL != now && now->start_pa - now->page_start_pa + now->page_start_va != va) {
    now = now->next;
  }
  free_single_md(now);
  if(NULL != now->succ) {
    free_single_md(now->succ);
    now->succ = NULL;
  }

  return 0;
}



//
// kerenl entry point of naive_fork
//
ssize_t sys_user_fork() {
  sprint("User call fork.\n");
  return do_fork( current );
}

//
// kerenl entry point of yield. added @lab3_2
//
ssize_t sys_user_yield() {
  // TODO (lab3_2): implment the syscall of yield.
  // hint: the functionality of yield is to give up the processor. therefore,
  // we should set the status of currently running process to READY, insert it in
  // the rear of ready queue, and finally, schedule a READY process to run.
  insert_to_ready_queue(current);
  schedule();
  return 0;
}

// added @lab3_challenge_1
uint64 sys_user_wait(int pid) {
  insert_into_exit_wait_queue(current, pid);
  schedule();
  return 0;
}

//
// open file
//
ssize_t sys_user_open(char *pathva, int flags) {
  char* pathpa = (char*)user_va_to_pa((pagetable_t)(current->pagetable), pathva);
  return do_open(pathpa, flags);
}

//
// read file
//
ssize_t sys_user_read(int fd, char *bufva, uint64 count) {
  int i = 0;
  while (i < count) { // count can be greater than page size
    uint64 addr = (uint64)bufva + i;
    uint64 pa = lookup_pa((pagetable_t)current->pagetable, addr);
    uint64 off = addr - ROUNDDOWN(addr, PGSIZE);
    uint64 len = count - i < PGSIZE - off ? count - i : PGSIZE - off;
    uint64 r = do_read(fd, (char *)pa + off, len);
    i += r; if (r < len) return i;
  }
  return count;
}

//
// write file
//
ssize_t sys_user_write(int fd, char *bufva, uint64 count) {
  int i = 0;
  while (i < count) { // count can be greater than page size
    uint64 addr = (uint64)bufva + i;
    uint64 pa = lookup_pa((pagetable_t)current->pagetable, addr);
    uint64 off = addr - ROUNDDOWN(addr, PGSIZE);
    uint64 len = count - i < PGSIZE - off ? count - i : PGSIZE - off;
    uint64 r = do_write(fd, (char *)pa + off, len);
    i += r; if (r < len) return i;
  }
  return count;
}

//
// lseek file
//
ssize_t sys_user_lseek(int fd, int offset, int whence) {
  return do_lseek(fd, offset, whence);
}

//
// read vinode
//
ssize_t sys_user_stat(int fd, struct istat *istat) {
  struct istat * pistat = (struct istat *)user_va_to_pa((pagetable_t)(current->pagetable), istat);
  return do_stat(fd, pistat);
}

//
// read disk inode
//
ssize_t sys_user_disk_stat(int fd, struct istat *istat) {
  struct istat * pistat = (struct istat *)user_va_to_pa((pagetable_t)(current->pagetable), istat);
  return do_disk_stat(fd, pistat);
}

//
// close file
//
ssize_t sys_user_close(int fd) {
  return do_close(fd);
}

//
// lib call to opendir
//
ssize_t sys_user_opendir(char * pathva){
  char * pathpa = (char*)user_va_to_pa((pagetable_t)(current->pagetable), pathva);
  return do_opendir(pathpa);
}

//
// lib call to readdir
//
ssize_t sys_user_readdir(int fd, struct dir *vdir){
  struct dir * pdir = (struct dir *)user_va_to_pa((pagetable_t)(current->pagetable), vdir);
  return do_readdir(fd, pdir);
}

//
// lib call to mkdir
//
ssize_t sys_user_mkdir(char * pathva){
  char * pathpa = (char*)user_va_to_pa((pagetable_t)(current->pagetable), pathva);
  return do_mkdir(pathpa);
}

//
// lib call to closedir
//
ssize_t sys_user_closedir(int fd){
  return do_closedir(fd);
}

//
// lib call to link
//
ssize_t sys_user_link(char * vfn1, char * vfn2){
  char * pfn1 = (char*)user_va_to_pa((pagetable_t)(current->pagetable), (void*)vfn1);
  char * pfn2 = (char*)user_va_to_pa((pagetable_t)(current->pagetable), (void*)vfn2);
  return do_link(pfn1, pfn2);
}

//
// lib call to unlink
//
ssize_t sys_user_unlink(char * vfn){
  char * pfn = (char*)user_va_to_pa((pagetable_t)(current->pagetable), (void*)vfn);
  return do_unlink(pfn);
}

ssize_t sys_user_exec(char *path, char *param) {
  char *path_pa = (char *)user_va_to_pa(current->pagetable, (void *)path);
  char *param_pa = (char *)user_va_to_pa(current->pagetable, (void *)param);
  char *param_new = alloc_page();
  // char param_new[100];
  strcpy(param_new, param_pa);
  substitute_bincode_from_vfs_elf(current, path_pa, param_pa);
  // sprint("pa for code exec before = 0x%lx\n", user_va_to_pa(current->pagetable, (void *)(0x0000000000010000)));

  
  // write exec parameter
  char **argv_va = (char **)sys_user_allocate_page(PGSIZE);
  char *argv_0_va = (char *)sys_user_allocate_page(PGSIZE);

  char **argv_pa = user_va_to_pa(current->pagetable, (void *)argv_va);
  // argv[0] stores the va of parameter string
  argv_pa[0] = argv_0_va;

  char *argv_0_pa = (char *)user_va_to_pa(current->pagetable, (void *)argv_0_va);
  // cannot use param_pa, because the original data segment has been substituted
  strcpy(argv_0_pa, param_new);
  // sprint("pa for code exec after = 0x%lx\n", user_va_to_pa(current->pagetable, (void *)(0x0000000000010000)));
  free_page((void *)param_new);
  current->trapframe->regs.a0 = 1;
  current->trapframe->regs.a1 = (uint64)argv_va;

  return 0;
}

ssize_t sys_user_read_cwd(char *dst) {
  char *pa = (char *)user_va_to_pa((pagetable_t)(current->pagetable), (void *)dst);
  return do_rcwd(pa);
}

ssize_t sys_user_change_cwd(char *dst) {
  char *pa = (char *)user_va_to_pa((pagetable_t)(current->pagetable), (void *)dst);
  return do_ccwd(pa);
}

ssize_t sys_user_scan(char *dst) {
  char *pa = (char *)user_va_to_pa((pagetable_t)(current->pagetable), (void *)dst);
  spike_file_read(stdin, pa, PGSIZE);
  return 0;
}

uint64 sys_user_sem_new(int iv) {
  if(iv < 0) {
    panic("negative inital sem value!");
  }
  semaphore *sem = alloc_semaphore();
  sem->value = iv;
  for(int i = 0; i < PROC_MAX_SEM_NUM; i++) {
    if(NULL == sem_array[i]) {
      sem_array[i] = sem;
      return i;
    }
  }
  return -1;
}

uint64 sys_user_sem_P(int semid) {
  semaphore *sem = sem_array[semid];
  if(--sem->value < 0) {
    current->status = BLOCKED;
    current->queue_next = sem->waiting_queue;
    sem->waiting_queue = current;
    schedule();
  }
  return 0;
}

uint64 sys_user_sem_V(int semid) {
  semaphore *sem = sem_array[semid];
  if(++sem->value <= 0) { // wakeup a waiting process
    if(NULL == sem->waiting_queue) {
      panic("waiting queue is empty!");
    }
    process *p = sem->waiting_queue;
    sem->waiting_queue = sem->waiting_queue->queue_next;
    insert_to_ready_queue(p);
  }
  return 0;
}


//
// [a0]: the syscall number; [a1] ... [a7]: arguments to the syscalls.
// returns the code of success, (e.g., 0 means success, fail for otherwise)
//
long do_syscall(long a0, long a1, long a2, long a3, long a4, long a5, long a6, long a7) {
  switch (a0) {
    case SYS_user_print:
      return sys_user_print((const char*)a1, a2);
    case SYS_user_exit:
      return sys_user_exit(a1);
    // added @lab2_2
    case SYS_user_allocate_page:
      return sys_user_allocate_page(a1);
    case SYS_user_free_page:
      return sys_user_free_page(a1);
    case SYS_user_fork:
      return sys_user_fork();
    case SYS_user_yield:
      return sys_user_yield();
    // added @lab4_1
    case SYS_user_open:
      return sys_user_open((char *)a1, a2);
    case SYS_user_read:
      return sys_user_read(a1, (char *)a2, a3);
    case SYS_user_write:
      return sys_user_write(a1, (char *)a2, a3);
    case SYS_user_lseek:
      return sys_user_lseek(a1, a2, a3);
    case SYS_user_stat:
      return sys_user_stat(a1, (struct istat *)a2);
    case SYS_user_disk_stat:
      return sys_user_disk_stat(a1, (struct istat *)a2);
    case SYS_user_close:
      return sys_user_close(a1);
    // added @lab4_2
    case SYS_user_opendir:
      return sys_user_opendir((char *)a1);
    case SYS_user_readdir:
      return sys_user_readdir(a1, (struct dir *)a2);
    case SYS_user_mkdir:
      return sys_user_mkdir((char *)a1);
    case SYS_user_closedir:
      return sys_user_closedir(a1);
    // added @lab4_3
    case SYS_user_link:
      return sys_user_link((char *)a1, (char *)a2);
    case SYS_user_unlink:
      return sys_user_unlink((char *)a1);
    case SYS_user_wait:
      return sys_user_wait(a1);
    case SYS_user_exec:
      return sys_user_exec((char *)a1, (char *)a2);
    case SYS_user_rcwd:
      return sys_user_read_cwd((char *)a1);
    case SYS_user_ccwd:
      return sys_user_change_cwd((char *)a1);
    case SYS_user_scan:
      return sys_user_scan((char *)a1);
    case SYS_user_sem_new:
      return sys_user_sem_new(a1);
    case SYS_user_sem_P:
      return sys_user_sem_P(a1);
    case SYS_user_sem_V:
      return sys_user_sem_V(a1);
    default:
      panic("Unknown syscall %ld \n", a0);
  }
}
