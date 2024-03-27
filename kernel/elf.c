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

elf_ctx elf_for_pid[NPROC];
elf_info elf_info_for_pid[NPROC];

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
      //sprint( "CODE_SEGMENT added at mapped info offset:%d\n", j );
    }else if ( ph_addr.flags == (SEGMENT_READABLE|SEGMENT_WRITABLE) ){
      ((process*)(((elf_info*)(ctx->info))->p))->mapped_info[j].seg_type = DATA_SEGMENT;
      //sprint( "DATA_SEGMENT added at mapped info offset:%d\n", j );
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
  //sprint("Application: %s\n", filename);

  if(shell_process == NULL) {
    shell_process = p;
    //sprint("set shell process\n");
  }

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
  elf_for_pid[p->pid] = elfloader;
  elf_info_for_pid[p->pid] = info;
  elf_for_pid[p->pid].info = &elf_info_for_pid[p->pid];

  // do not close the vfs file, for backtrace
  // vfs_close( info.f );

  //sprint("Application program entry point (virtual address): 0x%lx\n", p->trapframe->epc);
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
          //sprint( "CODE_SEGMENT added at mapped info offset:%d\n", j );
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
          //sprint( "DATA_SEGMENT added at mapped info offset:%d\n", j );
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
            //sprint( "DATA_SEGMENT added at mapped info offset:%d\n", j );
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

  elf_info info;
  info.f = vfs_open(path, O_RDONLY);
  info.p = p;
  elf_info_for_pid[p->pid] = info;
  if(info.f == NULL) {
    panic("failed to open file.");
  }
  //sprint("Application: %s\n", path); 
  struct file *elf_file = info.f;
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
  elf_for_pid[p->pid] = elfloader;
  elf_for_pid[p->pid].info = &elf_info_for_pid[p->pid];
  //sprint("Application program entry point (virtual address): 0x%lx\n", p->trapframe->epc);
}

elf_ctx *get_elf() {
  return &elf_for_pid[current->pid];
}

elf_section_header read_elf_section_header(elf_ctx *ctx, int idx) {
  elf_section_header sh;
  elf_fpread(ctx, &sh, sizeof(elf_section_header), ctx->ehdr.shoff + sizeof(elf_section_header) * idx);
  return sh;
}

elf_section_header read_elf_section_header_with_name(elf_ctx *ctx, const char *name) {

  elf_section_header shstrtab;
  char *buf = alloc_page();

  shstrtab = read_elf_section_header(ctx, ctx->ehdr.shstrndx);
  read_elf_into_buffer(ctx, buf, shstrtab.sh_offset, shstrtab.sh_size);

  elf_section_header header;
  for(int i = 0; i < ctx->ehdr.shnum; i++) {
    header = read_elf_section_header(ctx, i);
    if(0 == strcmp(buf + header.sh_name, name)) {
      free_page(buf);
      return header;
    }
  }
  panic("no corresponding section name");
  return header;
}

void read_elf_into_buffer(elf_ctx *ctx, void *dst, int offset, int size) {
  elf_fpread(ctx, dst, size, offset);
}

int symcmp(const void *a, const void *b) {
  const elf_sym *sym1 = a;
  const elf_sym *sym2 = b;
  return sym1->st_value - sym2->st_value;
}

const char *get_symbol_name(elf_ctx *ctx, uint64 addr) {
  elf_section_header symtab;
  elf_section_header strtab;
  elf_sym *symbols = alloc_page();
  char *strs = alloc_page();
  int symnum = 0;
  symtab = read_elf_section_header_with_name(ctx, ".symtab");
  strtab = read_elf_section_header_with_name(ctx, ".strtab");
  int now = 0;
  while(now < symtab.sh_size) {
    read_elf_into_buffer(ctx, symbols + symnum, symtab.sh_offset + symnum * sizeof(elf_sym), sizeof(elf_sym));
    symnum++;
    now += sizeof(elf_sym);
  }
  read_elf_into_buffer(ctx, strs, strtab.sh_offset, strtab.sh_size);
  
  for(int i = 0; i < symnum; i++) {
    if(addr >= symbols[i].st_value && addr < symbols[i].st_value + symbols[i].st_size) {
      free_page(symbols);
      free_page(strs);
      return strs + symbols[i].st_name;
    }
  }
  panic("no such symbol");
  return NULL;
}


// leb128 (little-endian base 128) is a variable-length
// compression algoritm in DWARF
void read_uleb128(uint64 *out, char **off) {
    uint64 value = 0; int shift = 0; uint8 b;
    for (;;) {
        b = *(uint8 *)(*off); (*off)++;
        value |= ((uint64)b & 0x7F) << shift;
        shift += 7;
        if ((b & 0x80) == 0) break;
    }
    if (out) *out = value;
}
void read_sleb128(int64 *out, char **off) {
    int64 value = 0; int shift = 0; uint8 b;
    for (;;) {
        b = *(uint8 *)(*off); (*off)++;
        value |= ((uint64_t)b & 0x7F) << shift;
        shift += 7;
        if ((b & 0x80) == 0) break;
    }
    if (shift < 64 && (b & 0x40)) value |= -(1 << shift);
    if (out) *out = value;
}
// Since reading below types through pointer cast requires aligned address,
// so we can only read them byte by byte
void read_uint64(uint64 *out, char **off) {
    *out = 0;
    for (int i = 0; i < 8; i++) {
        *out |= (uint64)(**off) << (i << 3); (*off)++;
    }
}
void read_uint32(uint32 *out, char **off) {
    *out = 0;
    for (int i = 0; i < 4; i++) {
        *out |= (uint32)(**off) << (i << 3); (*off)++;
    }
}
void read_uint16(uint16 *out, char **off) {
    *out = 0;
    for (int i = 0; i < 2; i++) {
        *out |= (uint16)(**off) << (i << 3); (*off)++;
    }
}

/*
* analyzis the data in the debug_line section
*
* the function needs 3 parameters: elf context, data in the debug_line section
* and length of debug_line section
*
* make 3 arrays:
* "process->dir" stores all directory paths of code files
* "process->file" stores all code file names of code files and their directory path index of array "dir"
* "process->line" stores all relationships map instruction addresses to code line numbers
* and their code file name index of array "file"
*/
void make_addr_line(elf_ctx *ctx, char *debug_line, uint64 length) {
   process *p = ((elf_info *)ctx->info)->p;
    p->debugline = debug_line;
    // directory name char pointer array
    p->dir = (char **)((((uint64)debug_line + length + 7) >> 3) << 3); int dir_ind = 0, dir_base;
    // file name char pointer array
    p->file = (code_file *)(p->dir + 64); int file_ind = 0, file_base;
    // table array
    p->line = (addr_line *)(p->file + 64); p->line_ind = 0;
    char *off = debug_line;
    while (off < debug_line + length) { // iterate each compilation unit(CU)
        debug_header *dh = (debug_header *)off; off += sizeof(debug_header);
        dir_base = dir_ind; file_base = file_ind;
        // get directory name char pointer in this CU
        while (*off != 0) {
            p->dir[dir_ind++] = off; while (*off != 0) off++; off++;
        }
        off++;
        // get file name char pointer in this CU
        while (*off != 0) {
            p->file[file_ind].file = off; while (*off != 0) off++; off++;
            uint64 dir; read_uleb128(&dir, &off);
            p->file[file_ind++].dir = dir - 1 + dir_base;
            read_uleb128(NULL, &off); read_uleb128(NULL, &off);
        }
        off++; addr_line regs; regs.addr = 0; regs.file = 1; regs.line = 1;
        // simulate the state machine op code
        for (;;) {
            uint8 op = *(off++);
            switch (op) {
                case 0: // Extended Opcodes
                    read_uleb128(NULL, &off); op = *(off++);
                    switch (op) {
                        case 1: // DW_LNE_end_sequence
                            if (p->line_ind > 0 && p->line[p->line_ind - 1].addr == regs.addr) p->line_ind--;
                            p->line[p->line_ind] = regs; p->line[p->line_ind].file += file_base - 1;
                            p->line_ind++; goto endop;
                        case 2: // DW_LNE_set_address
                            read_uint64(&regs.addr, &off); break;
                        // ignore DW_LNE_define_file
                        case 4: // DW_LNE_set_discriminator
                            read_uleb128(NULL, &off); break;
                    }
                    break;
                case 1: // DW_LNS_copy
                    if (p->line_ind > 0 && p->line[p->line_ind - 1].addr == regs.addr) p->line_ind--;
                    p->line[p->line_ind] = regs; p->line[p->line_ind].file += file_base - 1;
                    p->line_ind++; break;
                case 2: { // DW_LNS_advance_pc
                            uint64 delta; read_uleb128(&delta, &off);
                            regs.addr += delta * dh->min_instruction_length;
                            break;
                        }
                case 3: { // DW_LNS_advance_line
                            int64 delta; read_sleb128(&delta, &off);
                            regs.line += delta; break; } case 4: // DW_LNS_set_file
                        read_uleb128(&regs.file, &off); break;
                case 5: // DW_LNS_set_column
                        read_uleb128(NULL, &off); break;
                case 6: // DW_LNS_negate_stmt
                case 7: // DW_LNS_set_basic_block
                        break;
                case 8: { // DW_LNS_const_add_pc
                            int adjust = 255 - dh->opcode_base;
                            int delta = (adjust / dh->line_range) * dh->min_instruction_length;
                            regs.addr += delta; break;
                        }
                case 9: { // DW_LNS_fixed_advanced_pc
                            uint16 delta; read_uint16(&delta, &off);
                            regs.addr += delta;
                            break;
                        }
                        // ignore 10, 11 and 12
                default: { // Special Opcodes
                             int adjust = op - dh->opcode_base;
                             int addr_delta = (adjust / dh->line_range) * dh->min_instruction_length;
                             int line_delta = dh->line_base + (adjust % dh->line_range);
                             regs.addr += addr_delta;
                             regs.line += line_delta;
                             if (p->line_ind > 0 && p->line[p->line_ind - 1].addr == regs.addr) p->line_ind--;
                             p->line[p->line_ind] = regs; p->line[p->line_ind].file += file_base - 1;
                             p->line_ind++; break;
                         }
            }
        }
endop:;
    }
}

void read_runtime_error_source_code() {
  elf_ctx *elf = get_elf();
  elf_section_header debug_line_header = read_elf_section_header_with_name(elf, ".debug_line");
  char *content = alloc_page();
  read_elf_into_buffer(elf, content, debug_line_header.sh_offset, debug_line_header.sh_size);

  make_addr_line(elf, content, debug_line_header.sh_size);
  // why not tf->epc?
  uint64 epc = read_csr(mepc);
  process *p = ((elf_info *)elf->info)->p;
  int line_idx = 0;
  while(p->line[line_idx].addr != epc && line_idx < p->line_ind) {
    line_idx++;
  }
  const char *file_name = p->file[p->line[line_idx].file].file;
  const char *dir_name = p->dir[p->file[p->line[line_idx].file].dir];

  //sprint("Runtime error at %s/%s:%d\n", dir_name, file_name, p->line[line_idx].line);
  char *path = alloc_page();
  int path_len = 0;
  for(int i = 0; i < strlen(dir_name); i++) {
    path[path_len++] = dir_name[i];
  }
  path[path_len++] = '/';
  for(int i = 0; i < strlen(file_name); i++) {
    path[path_len++] = file_name[i];
  }
  path[path_len] = '\0';
  spike_file_t *file = spike_file_open(path, O_RDONLY, 0);

  int cur_line_no = 1;
  ssize_t cur_offset = 0;
  char *line_content = alloc_page();
  int line_len = 0;
  while(cur_line_no < p->line[line_idx].line) {
    char c;
    while(spike_file_pread(file, &c, 1, cur_offset)) {
      cur_offset++;
      if(c == '\n') {
        cur_line_no++;
        break;
      }
    }
  }

  char c;
  while(spike_file_pread(file, &c, 1, cur_offset) && c != '\n') {
    cur_offset++;
    line_content[line_len++] = c;
  }
  line_content[line_len] = '\0';
  //sprint("%s\n", line_content);

  spike_file_close(file);
  free_page(path);
  free_page(line_content);
  free_page(content);
}