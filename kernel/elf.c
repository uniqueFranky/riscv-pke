/*
 * routines that scan and load a (host) Executable and Linkable Format (ELF) file
 * into the (emulated) memory.
 */

#include "elf.h"
#include "memlayout.h"
#include "process.h"
#include "string.h"
#include "riscv.h"
#include "vmm.h"
#include "pmm.h"
#include "vfs.h"
#include "spike_interface/spike_utils.h"

typedef struct elf_info_t {
  struct file *f;
  process *p;
} elf_info;

//
// the implementation of allocater. allocates memory space for later segment loading.
// this allocater is heavily modified @lab2_1, where we do NOT work in bare mode.
//
static void *elf_alloc_mb(elf_ctx *ctx, uint64 elf_pa, uint64 elf_va, uint64 size) {
  elf_info *msg = (elf_info *)ctx->info;
  // we assume that size of proram segment is smaller than a page.
  kassert(size < PGSIZE);
  void *pa = alloc_page();
  if (pa == 0) panic("uvmalloc mem alloc falied\n");

  memset((void *)pa, 0, PGSIZE);
  user_vm_map((pagetable_t)msg->p->pagetable, elf_va, PGSIZE, (uint64)pa,
         prot_to_type(PROT_WRITE | PROT_READ | PROT_EXEC, 1));

  return pa;
}

static void *elf_process_alloc_mb(process *p, uint64 elf_pa, uint64 elf_va, uint64 size) {
  // we assume that size of proram segment is smaller than a page.
  kassert(size < PGSIZE);
  void *pa = alloc_page();
  if (pa == 0) panic("uvmalloc mem alloc falied\n");

  // why !!!!!!!!!!
  // memset((void *)pa, 0, PGSIZE);
  user_vm_map(p->pagetable, elf_va, PGSIZE, (uint64)pa,
         prot_to_type(PROT_WRITE | PROT_READ | PROT_EXEC, 1));
  return pa;
}


//
// actual file reading, using the vfs file interface.
//
static uint64 elf_fpread(elf_ctx *ctx, void *dest, uint64 nb, uint64 offset) {
  elf_info *msg = (elf_info *)ctx->info;
  vfs_lseek(msg->f, offset, SEEK_SET);
  return vfs_read(msg->f, dest, nb);
}

//
// init elf_ctx, a data structure that loads the elf.
//
elf_status elf_init(elf_ctx *ctx, void *info) {
  ctx->info = info;

  // load the elf header
  if (elf_fpread(ctx, &ctx->ehdr, sizeof(ctx->ehdr), 0) != sizeof(ctx->ehdr)) return EL_EIO;

  // check the signature (magic value) of the elf
  if (ctx->ehdr.magic != ELF_MAGIC) return EL_NOTELF;

  return EL_OK;
}

//
// load the elf segments to memory regions.
//
elf_status elf_load(elf_ctx *ctx) {
  // elf_prog_header structure is defined in kernel/elf.h
  elf_prog_header ph_addr;
  int i, off;

  // traverse the elf program segment headers
  for (i = 0, off = ctx->ehdr.phoff; i < ctx->ehdr.phnum; i++, off += sizeof(ph_addr)) {
    // read segment headers
    if (elf_fpread(ctx, (void *)&ph_addr, sizeof(ph_addr), off) != sizeof(ph_addr)) return EL_EIO;

    if (ph_addr.type != ELF_PROG_LOAD) continue;
    if (ph_addr.memsz < ph_addr.filesz) return EL_ERR;
    if (ph_addr.vaddr + ph_addr.memsz < ph_addr.vaddr) return EL_ERR;

    // allocate memory block before elf loading
    void *dest = elf_alloc_mb(ctx, ph_addr.vaddr, ph_addr.vaddr, ph_addr.memsz);

    // actual loading
    if (elf_fpread(ctx, dest, ph_addr.memsz, ph_addr.off) != ph_addr.memsz)
      return EL_EIO;

    // record the vm region in proc->mapped_info. added @lab3_1
    int j;
    for( j=0; j<PGSIZE/sizeof(mapped_region); j++ ) //seek the last mapped region
      if( (process*)(((elf_info*)(ctx->info))->p)->mapped_info[j].va == 0x0 ) break;

    ((process*)(((elf_info*)(ctx->info))->p))->mapped_info[j].va = ph_addr.vaddr;
    ((process*)(((elf_info*)(ctx->info))->p))->mapped_info[j].npages = 1;

    // SEGMENT_READABLE, SEGMENT_EXECUTABLE, SEGMENT_WRITABLE are defined in kernel/elf.h
    if( ph_addr.flags == (SEGMENT_READABLE|SEGMENT_EXECUTABLE) ){
      ((process*)(((elf_info*)(ctx->info))->p))->mapped_info[j].seg_type = CODE_SEGMENT;
      sprint( "CODE_SEGMENT added at mapped info offset:%d\n", j );
    }else if ( ph_addr.flags == (SEGMENT_READABLE|SEGMENT_WRITABLE) ){
      ((process*)(((elf_info*)(ctx->info))->p))->mapped_info[j].seg_type = DATA_SEGMENT;
      sprint( "DATA_SEGMENT added at mapped info offset:%d\n", j );
    }else
      panic( "unknown program segment encountered, segment flag:%d.\n", ph_addr.flags );

    ((process*)(((elf_info*)(ctx->info))->p))->total_mapped_region ++;
  }

  return EL_OK;
}

//
// load the elf of user application, by using the spike file interface.
//
void load_bincode_from_host_elf(process *p, char *filename) {
  sprint("Application: %s\n", filename);

  //elf loading. elf_ctx is defined in kernel/elf.h, used to track the loading process.
  elf_ctx elfloader;
  // elf_info is defined above, used to tie the elf file and its corresponding process.
  elf_info info;

  info.f = vfs_open(filename, O_RDONLY);
  info.p = p;
  // IS_ERR_VALUE is a macro defined in spike_interface/spike_htif.h
  if (IS_ERR_VALUE(info.f)) panic("Fail on openning the input application program.\n");

  // init elfloader context. elf_init() is defined above.
  if (elf_init(&elfloader, &info) != EL_OK)
    panic("fail to init elfloader.\n");

  // load elf. elf_load() is defined above.
  if (elf_load(&elfloader) != EL_OK) panic("Fail on loading elf.\n");

  // entry (virtual, also physical in lab1_x) address
  p->trapframe->epc = elfloader.ehdr.entry;

  // close the vfs file
  vfs_close( info.f );

  sprint("Application program entry point (virtual address): 0x%lx\n", p->trapframe->epc);
}

void elf_substitute(process *p, elf_ctx *ctx, struct file *elf_file) {
  elf_prog_header ph_addr;
  int i, off;
  
  // traverse the elf program segment headers
  // and substitute code/data segment
  for (i = 0, off = ctx->ehdr.phoff; i < ctx->ehdr.phnum; i++, off += sizeof(ph_addr)) {
    // read segment headers
    // elf_file->offset = off;
    vfs_lseek(elf_file, off, 0);
    uint64 bytes_read = vfs_read(elf_file, (char *)&ph_addr, sizeof(ph_addr));
    if(bytes_read != sizeof(ph_addr)) {
      panic("error when reading segment header!");
    }
    if (ph_addr.type != ELF_PROG_LOAD) continue;
    if (ph_addr.memsz < ph_addr.filesz) panic("elf ph memsz error!");
    if (ph_addr.vaddr + ph_addr.memsz < ph_addr.vaddr) panic("elf ph memsz error!");
    // SEGMENT_READABLE, SEGMENT_EXECUTABLE, SEGMENT_WRITABLE are defined in kernel/elf.h
    if( ph_addr.flags == (SEGMENT_READABLE|SEGMENT_EXECUTABLE) ){ // code segment
      for(int j = 0; j < PGSIZE/sizeof(mapped_region); j++) {
        if(p->mapped_info[j].seg_type == CODE_SEGMENT) {
          sprint( "CODE_SEGMENT added at mapped info offset:%d\n", j );
          // do NOT free the original page, father process needs code segment
          user_vm_unmap(p->pagetable, p->mapped_info[j].va, PGSIZE, 0); 
          // alloc new page
          void *dest = elf_process_alloc_mb(p, ph_addr.vaddr, ph_addr.vaddr, ph_addr.memsz);
          p->mapped_info[j].va = ph_addr.vaddr;
          // elf_file->offset = ph_addr.off;
          vfs_lseek(elf_file, ph_addr.off, 0);
          bytes_read = vfs_read(elf_file, dest, ph_addr.memsz);
          if(bytes_read != ph_addr.memsz) {
            panic("error when substituting code segment!");
          }
          break;
        }
      }
    } else if ( ph_addr.flags == (SEGMENT_READABLE|SEGMENT_WRITABLE) ){ // data segment
      int found = 0; // maybe there's no existing data segment
      for(int j = 0; j < PGSIZE/sizeof(mapped_region); j++) {
        if(p->mapped_info[j].seg_type == DATA_SEGMENT) {
          sprint( "DATA_SEGMENT added at mapped info offset:%d\n", j );
          // free the original page
          user_vm_unmap(p->pagetable, p->mapped_info[j].va, PGSIZE, 1); 
          // alloc new page
          void *dest = elf_process_alloc_mb(p, ph_addr.vaddr, ph_addr.vaddr, ph_addr.memsz);
          // elf_file->offset = ph_addr.off;
          vfs_lseek(elf_file, ph_addr.off, 0);
          p->mapped_info[j].va = ph_addr.vaddr;
          bytes_read = vfs_read(elf_file, dest, ph_addr.memsz);
          if(bytes_read != ph_addr.memsz) {
            panic("error when substituting data segment!");
          }
          found = 1;
          break;
        }
      }
      if(!found) { // no existing data segment
        // alloc new page
        void *dest = elf_process_alloc_mb(p, ph_addr.vaddr, ph_addr.vaddr, ph_addr.memsz);
        // elf_file->offset = ph_addr.off;
        vfs_lseek(elf_file, ph_addr.off, 0);
        bytes_read = vfs_read(elf_file, dest, ph_addr.memsz);
        if(bytes_read != ph_addr.memsz) {
          panic("error when substituting data segment!");
        }
        for(int j = 0; j < PGSIZE / sizeof(mapped_region); j++) {
          if(p->mapped_info[j].va == 0) {
            sprint( "DATA_SEGMENT added at mapped info offset:%d\n", j );
            p->mapped_info[j].npages = 1;
            p->mapped_info[j].va = ph_addr.vaddr;
            p->mapped_info[j].seg_type = DATA_SEGMENT;
            p->total_mapped_region++;
            break;
          }
        }
      }
    } else {
      panic( "unknown program segment encountered, segment flag:%d.\n", ph_addr.flags );
    }
  }
  // clear the heap segment
  for(int j = 0; j < PGSIZE / sizeof(mapped_region); j++) {
    if(p->mapped_info[j].seg_type == HEAP_SEGMENT) {
      p->mapped_info[j].npages = 0;
    }
    p->user_free_va = USER_FREE_ADDRESS_START;
    for(int k = 0; k < PROC_MAX_PAGE_NUM; k++) {
      if(p->page_cb[k].valid) {
        p->page_cb[k].valid = 0;
        user_vm_unmap(p->pagetable, p->page_cb[k].start_va, PGSIZE, 1);
      }
    }
    memory_descriptor *md = p->free_md_list_head;
    while(NULL != md) {
      memory_descriptor *nxt = md->next;
      free_memory_descriptor(md);
      md = nxt;
    }
    md = p->allocated_md_list_head;
    while(NULL != md) {
      memory_descriptor *nxt = md->next;
      memory_descriptor *suc = md->succ;
      while(NULL != suc) {
        free_memory_descriptor(suc);
        suc = suc->succ;
      }
      free_memory_descriptor(md);
      md = nxt;
    }
  }
}

void substitute_bincode_from_vfs_elf(process *p, const char *path, const char *param) {
  
  //elf loading. elf_ctx is defined in kernel/elf.h, used to track the loading process.
  elf_ctx elfloader;
  elf_ctx *ctx = &elfloader;
  sprint("Application: %s\n", path); 
  struct file *elf_file = vfs_open(path, O_RDONLY);

  // read the elf header
  uint64 bytes_read = vfs_read(elf_file, (char *)&ctx->ehdr, sizeof(ctx->ehdr));
  if (bytes_read != sizeof(ctx->ehdr)) {
    panic("error when reading elf header");
  }

  // check the signature (magic value) of the elf
  if (ctx->ehdr.magic != ELF_MAGIC) {
    panic("error when checking elf magic number");
  }

  elf_substitute(p, ctx, elf_file);
  // entry (virtual, also physical in lab1_x) address
  p->trapframe->epc = elfloader.ehdr.entry;

  // close the vfs file
  vfs_close(elf_file);

  sprint("Application program entry point (virtual address): 0x%lx\n", p->trapframe->epc);
}