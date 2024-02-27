#ifndef _PROC_H_
#define _PROC_H_

#define PROC_MAX_PAGE_NUM 16

#include "riscv.h"
#include "pmm.h"

typedef struct trapframe_t {
  // space to store context (all common registers)
  /* offset:0   */ riscv_regs regs;

  // process's "user kernel" stack
  /* offset:248 */ uint64 kernel_sp;
  // pointer to smode_trap_handler
  /* offset:256 */ uint64 kernel_trap;
  // saved user process counter
  /* offset:264 */ uint64 epc;

  // kernel page table. added @lab2_1
  /* offset:272 */ uint64 kernel_satp;
}trapframe;

typedef struct page_control_block_t {
    int valid;
    int allocated_md_num;
    uint64 start_pa;
    uint64 start_va;
} page_control_block;

// the extremely simple definition of process, used for begining labs of PKE
typedef struct process_t {
  // pointing to the stack used in trap handling.
  uint64 kstack;
  // user page table
  pagetable_t pagetable;
  // trapframe storing the context of a (User mode) process.
  trapframe* trapframe;

  uint64 user_free_va;
  page_control_block page_cb[PROC_MAX_PAGE_NUM];
  memory_descriptor *free_md_list_head;
  memory_descriptor *allocated_md_list_head;
} process;


// switch to run user app
void switch_to(process*);

// current running process
extern process* current;

// address of the first free page in our simple heap. added @lab2_2
extern uint64 g_ufree_page;

#endif
