/*
 * contains the implementation of all syscalls.
 */

#include <stdint.h>
#include <errno.h>

#include "riscv.h"
#include "util/types.h"
#include "syscall.h"
#include "string.h"
#include "process.h"
#include "util/functions.h"
#include "pmm.h"
#include "vmm.h"
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
  // in lab1, PKE considers only one app (one process). 
  // therefore, shutdown the system when the app calls exit()
  shutdown(code);
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
  if(NULL == md) { // no satisfying memory_descriptor, need new page
    // sprint("new page\n");
    void* pa = alloc_page();
    va = current->user_free_va;
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
        insert_into_md_list(&(current->allocated_md_list_head), allocated_md, 0);
        current->page_cb[i].allocated_md_num = 1;

        memory_descriptor *free_md = alloc_memory_descriptor();
        free_md->page_start_pa = (uint64)pa;
        free_md->page_start_va = va;
        free_md->start_pa = (uint64)pa + nb;
        free_md->size = PGSIZE - nb;
        insert_into_md_list(&(current->free_md_list_head), free_md, 1);
        break;
      }
    }
  } else {
    // sprint("existing page\n");
    uint64 allocated_start_pa;
    for(int i = 0; i < PROC_MAX_PAGE_NUM; i++) {
      if(current->page_cb[i].valid && current->page_cb[i].start_pa == md->page_start_pa) {
        current->page_cb[i].allocated_md_num++;
      }
    }
    if(md->size == nb) { // exactly the same size
      remove_from_md_list(&(current->free_md_list_head), md);
      insert_into_md_list(&(current->allocated_md_list_head), md, 0);
      allocated_start_pa = md->start_pa;
      va = md->start_pa - md->page_start_pa + md->page_start_va;
    } else { // split the memory
      memory_descriptor *allocated_md = alloc_memory_descriptor();
      allocated_md->page_start_pa = md->page_start_pa;
      allocated_md->page_start_va = md->page_start_va;
      allocated_md->start_pa = md->start_pa;
      allocated_md->size = nb;
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

//
// reclaim a page, indicated by "va". added @lab2_2
//
uint64 sys_user_free_page(uint64 va) {

  memory_descriptor *now = current->allocated_md_list_head;
  while(NULL != now && now->start_pa - now->page_start_pa + now->page_start_va != va) {
    now = now->next;
  }
  int page_id;
  for(page_id = 0; page_id < PROC_MAX_PAGE_NUM; page_id++) {
    if(current->page_cb[page_id].valid && current->page_cb[page_id].start_pa == now->page_start_pa) {
      break;
    }
  }
  remove_from_md_list(&(current->allocated_md_list_head), now);
  insert_into_md_list(&(current->free_md_list_head), now, 1);
  if(0 == --current->page_cb[page_id].allocated_md_num) { // free the whole page
    sprint("free whole page\n");
    now = current->free_md_list_head;
    while(NULL != now && now->page_start_pa != current->page_cb[page_id].start_pa) {
      now = now->next;
    }
    remove_from_md_list(&(current->free_md_list_head), now);
    free_memory_descriptor(now);
    user_vm_unmap((pagetable_t)current->pagetable, current->page_cb[page_id].start_va, PGSIZE, 1);
    current->page_cb[page_id].valid = 0;
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
    default:
      panic("Unknown syscall %ld \n", a0);
  }
}
