/*
 * contains the implementation of all syscalls.
 */

#include <stdint.h>
#include <errno.h>

#include "elf.h"
#include "util/types.h"
#include "syscall.h"
#include "string.h"
#include "process.h"
#include "util/functions.h"
#include "kernel/elf.h"

#include "spike_interface/spike_utils.h"

//
// implement the SYS_user_print syscall
//
ssize_t sys_user_print(const char* buf, size_t n) {
  sprint(buf);
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

uint64 *get_raw_ptr(uint64 addr) {
  return (uint64 *)(addr);
}

ssize_t sys_user_backtrace(long depth) {
  riscv_regs regs = current->trapframe->regs;
  elf_ctx *ctx = get_elf();
  uint64 fp = regs.s0;

  
  fp = *get_raw_ptr(fp - 8); // 跳过 do_user_call的栈帧，do_user_call是叶子函数，fp-8为之前保存的fp值

  while(depth--) {
    const char *name = get_symbol_name(ctx, *get_raw_ptr(fp - 8)); // 非叶子函数，fp-8为ra的保存值
    fp = *get_raw_ptr(fp - 16); // 非叶子函数，fp-16为fp的保存值
    sprint("%s\n", name);
    if(0 == strcmp("main", name)) {
      return 0;
    }
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
    case SYS_user_backtrace:
      return sys_user_backtrace(a1);
    default:
      panic("Unknown syscall %ld \n", a0);
  }
}
