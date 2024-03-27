#include "kernel/riscv.h"
#include "kernel/process.h"
#include "spike_interface/spike_utils.h"
#include "kernel/elf.h"
#include "kernel/sched.h"
#include "kernel/vmm.h"
#include "util/functions.h"

extern ssize_t sys_user_exit(uint64 code);
void mpanic(const char *s) {
  if(current == shell_process) {
    shutdown(-1);
  }
  ssprint("%s\n", s);
  // set the previous mode to supervisor
  write_csr(mstatus, ((read_csr(mstatus) & ~MSTATUS_MPP_MASK) | MSTATUS_MPP_S));
  write_csr(mstatus, 0xa00000808L);
  write_csr(mepc, (uint64)sys_user_exit);
  asm volatile("mret");
}

static void handle_instruction_access_fault() { 
  read_runtime_error_source_code();
  mpanic("Instruction access fault!"); 
}

static void handle_load_access_fault() { 
  read_runtime_error_source_code();
  mpanic("Load access fault!"); 
}

static void handle_store_access_fault() { 
  read_runtime_error_source_code();
  mpanic("Store/AMO access fault!");
}

static void handle_illegal_instruction() { 
  read_runtime_error_source_code();
  mpanic("Illegal instruction!"); 
}

static void handle_misaligned_load() { 
  read_runtime_error_source_code();
  mpanic("Misaligned Load!"); 
}

static void handle_misaligned_store() { 
  read_runtime_error_source_code();
  mpanic("Misaligned AMO!"); 
}

// added @lab1_3
static void handle_timer() {
  int cpuid = 0;
  // setup the timer fired at next time (TIMER_INTERVAL from now)
  *(uint64*)CLINT_MTIMECMP(cpuid) = *(uint64*)CLINT_MTIMECMP(cpuid) + TIMER_INTERVAL;

  // setup a soft interrupt in sip (S-mode Interrupt Pending) to be handled in S-mode
  write_csr(sip, SIP_SSIP);
}

//
// handle_mtrap calls a handling function according to the type of a machine mode interrupt (trap).
//
void handle_mtrap() {
  uint64 mcause = read_csr(mcause);
  switch (mcause) {
    case CAUSE_MTIMER:
      handle_timer();
      break;
    case CAUSE_FETCH_ACCESS:
      handle_instruction_access_fault();
      break;
    case CAUSE_LOAD_ACCESS:
      handle_load_access_fault();
    case CAUSE_STORE_ACCESS:
      handle_store_access_fault();
      break;
    case CAUSE_ILLEGAL_INSTRUCTION:
      // TODO (lab1_2): call handle_illegal_instruction to implement illegal instruction
      // interception, and finish lab1_2.
      handle_illegal_instruction();
      break;
    case CAUSE_MISALIGNED_LOAD:
      handle_misaligned_load();
      break;
    case CAUSE_MISALIGNED_STORE:
      handle_misaligned_store();
      break;

    default:
      sprint("machine trap(): unexpected mscause %p\n", mcause);
      sprint("            mepc=%p mtval=%p\n", read_csr(mepc), read_csr(mtval));
      mpanic( "unexpected exception happened in M-mode.\n" );
      break;
  }
}
