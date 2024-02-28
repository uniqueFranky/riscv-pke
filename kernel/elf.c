/*
 * routines that scan and load a (host) Executable and Linkable Format (ELF) file
 * into the (emulated) memory.
 */

#include "elf.h"
#include "process.h"
#include "string.h"
#include "riscv.h"
#include "vfs.h"
#include "vmm.h"
#include "pmm.h"
#include "spike_interface/spike_utils.h"

typedef struct elf_info_t {
  spike_file_t *f;
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

  memset((void *)pa, 0, PGSIZE);
  user_vm_map(p->pagetable, elf_va, PGSIZE, (uint64)pa,
         prot_to_type(PROT_WRITE | PROT_READ | PROT_EXEC, 1));
  return pa;
}

//
// actual file reading, using the spike file interface.
//
static uint64 elf_fpread(elf_ctx *ctx, void *dest, uint64 nb, uint64 offset) {
  elf_info *msg = (elf_info *)ctx->info;
  // call spike file utility to load the content of elf file into memory.
  // spike_file_pread will read the elf file (msg->f) from offset to memory (indicated by
  // *dest) for nb bytes.
  return spike_file_pread(msg->f, dest, nb, offset);
}

static uint64 elf_vfs_pread(struct file *elf_file, void *dest, uint64 nb, uint64 offset) {
  vfs_lseek(elf_file, offset, 0);
  return vfs_read(elf_file, dest, nb);
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

elf_status elf_vfs_init(elf_ctx *ctx, struct file *elf_file) {
  if(elf_vfs_pread(elf_file, &ctx->ehdr, sizeof(ctx->ehdr), 0)!= sizeof(ctx->ehdr)) {
    return EL_EIO;
  }
  if (ctx->ehdr.magic != ELF_MAGIC) {
    return EL_NOTELF;
  }
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

elf_status elf_vfs_load(process *p, elf_ctx *ctx, struct file *elf_file) {
  // elf_prog_header structure is defined in kernel/elf.h
  elf_prog_header ph_addr;
  int i, off;

  // traverse the elf program segment headers
  for (i = 0, off = ctx->ehdr.phoff; i < ctx->ehdr.phnum; i++, off += sizeof(ph_addr)) {
    // read segment headers
    if (elf_vfs_pread(elf_file, (void *)&ph_addr, sizeof(ph_addr), off) != sizeof(ph_addr)) return EL_EIO;
    
    if (ph_addr.type != ELF_PROG_LOAD) continue;
    if (ph_addr.memsz < ph_addr.filesz) return EL_ERR;
    if (ph_addr.vaddr + ph_addr.memsz < ph_addr.vaddr) return EL_ERR;

    // allocate memory block before elf loading
    void *dest = elf_process_alloc_mb(p, ph_addr.vaddr, ph_addr.vaddr, ph_addr.memsz);

    // actual loading
    if (elf_vfs_pread(elf_file, dest, ph_addr.memsz, ph_addr.off) != ph_addr.memsz)
      return EL_EIO;

    // record the vm region in proc->mapped_info. added @lab3_1
    int j;
    for( j=0; j<PGSIZE/sizeof(mapped_region); j++ ) //seek the last mapped region
      if( p->mapped_info[j].va == 0x0 ) break;

    p->mapped_info[j].va = ph_addr.vaddr;
    p->mapped_info[j].npages = 1;

    // SEGMENT_READABLE, SEGMENT_EXECUTABLE, SEGMENT_WRITABLE are defined in kernel/elf.h
    if( ph_addr.flags == (SEGMENT_READABLE|SEGMENT_EXECUTABLE) ){
      p->mapped_info[j].seg_type = CODE_SEGMENT;
      sprint( "CODE_SEGMENT added at mapped info offset:%d\n", j );
    }else if ( ph_addr.flags == (SEGMENT_READABLE|SEGMENT_WRITABLE) ){
      p->mapped_info[j].seg_type = DATA_SEGMENT;
      sprint( "DATA_SEGMENT added at mapped info offset:%d\n", j );
    }else
      panic( "unknown program segment encountered, segment flag:%d.\n", ph_addr.flags );

    p->total_mapped_region ++;
  }

  return EL_OK;
}

typedef union {
  uint64 buf[MAX_CMDLINE_ARGS];
  char *argv[MAX_CMDLINE_ARGS];
} arg_buf;

//
// returns the number (should be 1) of string(s) after PKE kernel in command line.
// and store the string(s) in arg_bug_msg.
//
static size_t parse_args(arg_buf *arg_bug_msg) {
  // HTIFSYS_getmainvars frontend call reads command arguments to (input) *arg_bug_msg
  long r = frontend_syscall(HTIFSYS_getmainvars, (uint64)arg_bug_msg,
      sizeof(*arg_bug_msg), 0, 0, 0, 0, 0);
  kassert(r == 0);

  size_t pk_argc = arg_bug_msg->buf[0];
  uint64 *pk_argv = &arg_bug_msg->buf[1];

  int arg = 1;  // skip the PKE OS kernel string, leave behind only the application name
  for (size_t i = 0; arg + i < pk_argc; i++)
    arg_bug_msg->argv[i] = (char *)(uintptr_t)pk_argv[arg + i];

  //returns the number of strings after PKE kernel in command line
  return pk_argc - arg;
}

//
// load the elf of user application, by using the spike file interface.
//
void load_bincode_from_host_elf(process *p) {
  arg_buf arg_bug_msg;

  // retrieve command line arguements
  size_t argc = parse_args(&arg_bug_msg);
  if (!argc) panic("You need to specify the application program!\n");

  sprint("Application: %s\n", arg_bug_msg.argv[0]);

  //elf loading. elf_ctx is defined in kernel/elf.h, used to track the loading process.
  elf_ctx elfloader;
  // elf_info is defined above, used to tie the elf file and its corresponding process.
  elf_info info;

  info.f = spike_file_open(arg_bug_msg.argv[0], O_RDONLY, 0);
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

  // close the host spike file
  spike_file_close( info.f );

  sprint("Application program entry point (virtual address): 0x%lx\n", p->trapframe->epc);
}

void load_bincode_from_vfs_elf(process *p) {
  arg_buf arg_bug_msg;

  // retrieve command line arguements
  size_t argc = parse_args(&arg_bug_msg);
  if (!argc) panic("You need to specify the application program!\n");

  sprint("Application: %s\n", arg_bug_msg.argv[0]);

  //elf loading. elf_ctx is defined in kernel/elf.h, used to track the loading process.
  elf_ctx elfloader;

  struct file *elf_file = vfs_open(arg_bug_msg.argv[0], O_RDONLY);

  // init elfloader context. elf_init() is defined above.
  if (elf_vfs_init(&elfloader, elf_file) != EL_OK)
    panic("fail to init elfloader.\n");

  // load elf. elf_load() is defined above.
  if (elf_vfs_load(p, &elfloader, elf_file) != EL_OK) panic("Fail on loading elf.\n");

  // entry (virtual, also physical in lab1_x) address
  p->trapframe->epc = elfloader.ehdr.entry;

  // close the host spike file
  vfs_close(elf_file);

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
          // free the original page
          user_vm_unmap(p->pagetable, p->mapped_info[j].va, PGSIZE, 1); 
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
    } else
      panic( "unknown program segment encountered, segment flag:%d.\n", ph_addr.flags );
  }

  // clear the heap segment
  for(int j = 0; j < PGSIZE / sizeof(mapped_region); j++) {
    if(p->mapped_info[j].seg_type == HEAP_SEGMENT) {
      for(uint64 va = p->user_heap.heap_bottom; va < p->user_heap.heap_top; va += PGSIZE) {
        user_vm_unmap(p->pagetable, va, PGSIZE, 1); // free the page at the same time
      }
      p->mapped_info[j].npages = 0;
      p->user_heap.heap_top = p->user_heap.heap_bottom;
    }
  }
}

//
// load the elf of user application, by using the vfs file interface.
//
void substitute_bincode_from_vfs_elf(process *p, const char *path) {
  
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
