#ifndef _SCHED_H_
#define _SCHED_H_

#include "process.h"

//length of a time slice, in number of ticks
#define TIME_SLICE_LEN  2

void insert_to_ready_queue( process* proc );
void insert_into_exit_wait_queue(process *proc, int pid);
void schedule();
void wakeup_exit_waiting_process(process *proc);

#endif
