/*
 * implementing the scheduler
 */

#include "sched.h"
#include "process.h"
#include "spike_interface/spike_utils.h"

process* ready_queue_head = NULL;

// queue where processes in it are wating for the index process to exit
process* wait_for_pid_exit_queue_head[NPROC + 1] = {NULL};
process* wait_for_sub_exit_queue_head = {NULL};
//
// insert a process, proc, into the END of ready queue.
//
void insert_to_ready_queue( process* proc ) {
  sprint( "going to insert process %d to ready queue.\n", proc->pid );
  // if the queue is empty in the beginning
  if( ready_queue_head == NULL ){
    proc->status = READY;
    proc->queue_next = NULL;
    ready_queue_head = proc;
    return;
  }

  // ready queue is not empty
  process *p;
  // browse the ready queue to see if proc is already in-queue
  for( p=ready_queue_head; p->queue_next!=NULL; p=p->queue_next )
    if( p == proc ) return;  //already in queue

  // p points to the last element of the ready queue
  if( p==proc ) return;
  p->queue_next = proc;
  proc->status = READY;
  proc->queue_next = NULL;

  return;
}

void insert_into_queue(process **queue_head, process *proc) {
  if(NULL == *queue_head) { // queue is empty
    *queue_head = proc;
    proc->queue_next = NULL;
    return;
  }
  
  process *p = *queue_head;
  while(NULL != p->queue_next) {
    if(p == proc) { // already in queue
      return;
    }
    p = p->queue_next;
  }
  // now p is the last proc in queue
  if(p == proc) {
    return;
  }
  p->queue_next = proc;
  proc->queue_next = NULL;
}

void insert_into_exit_wait_queue(process *proc, int pid) {
  if(pid >= NPROC) {
    panic("invalid pid!");
  }
  if(pid > 0) {
    insert_into_queue(&wait_for_pid_exit_queue_head[pid], proc);
  } else {
    insert_into_queue(&wait_for_sub_exit_queue_head, proc);
  }
  proc->status = BLOCKED;
}

void remove_from_waiting_queue(process **queue_head, process *trigger, int (*should_remove)(process *fa, process *son)) {
  if(NULL == *queue_head) { // waiting queue is empty
    return;
  }
  process *p;
  // remove from head until head cannot be removed
  // we first do this because head has no prev
  while(NULL != *queue_head && should_remove(*queue_head, trigger)) {
    p = *queue_head;
    p->trapframe->regs.a0 = trigger->pid;
    // cannot say 'insert_to_ready_queue(*queue_head)' here
    // because insert_to_ready_queue changes the next ptr of head
    // instead, use p to stash queue_head
    *queue_head = (*queue_head)->queue_next;
    insert_to_ready_queue(p);
  }
  if(NULL != *queue_head) { // queue is still not empty
    p = (*queue_head)->queue_next;
    process *prev = *queue_head;
    while(NULL != p) {
      if(should_remove(p, trigger)) { // should remove p from queue
        // return wakeup_by id
        p->trapframe->regs.a0 = trigger->pid;
        // set the next node of prev to be the next node of p
        prev->queue_next = p->queue_next;
        // insert the process which is pointed by p into ready queue
        insert_to_ready_queue(p);
        // set p to be the next node
        p = prev->queue_next;
      } else {
        prev = p;
        p = p->queue_next;
      } 
    }
  }
}

int should_remove_from_sub_wait_queue(process *fa, process *son) {
  return son->parent == fa;
}

int should_remove_from_pid_wait_queue(process *fa, process *son) {
  // always return true because all the processes in queue are waiting for the corresponding son
  return 1;
}

void wakeup_exit_waiting_process(process *proc) {
  remove_from_waiting_queue(&wait_for_pid_exit_queue_head[proc->pid], proc, should_remove_from_pid_wait_queue);
  remove_from_waiting_queue(&wait_for_sub_exit_queue_head, proc, should_remove_from_sub_wait_queue);
}

//
// choose a proc from the ready queue, and put it to run.
// note: schedule() does not take care of previous current process. If the current
// process is still runnable, you should place it into the ready queue (by calling
// ready_queue_insert), and then call schedule().
//
extern process procs[NPROC];
void schedule() {
  if ( !ready_queue_head ){
    // by default, if there are no ready process, and all processes are in the status of
    // FREE and ZOMBIE, we should shutdown the emulated RISC-V machine.
    int should_shutdown = 1;

    for( int i=0; i<NPROC; i++ )
      if( (procs[i].status != FREE) && (procs[i].status != ZOMBIE) ){
        should_shutdown = 0;
        sprint( "ready queue empty, but process %d is not in free/zombie state:%d\n", 
          i, procs[i].status );
      }

    if( should_shutdown ){
      sprint( "no more ready processes, system shutdown now.\n" );
      shutdown( 0 );
    }else{
      panic( "Not handled: we should let system wait for unfinished processes.\n" );
    }
  }

  current = ready_queue_head;
  assert( current->status == READY );
  ready_queue_head = ready_queue_head->queue_next;

  current->status = RUNNING;
  sprint( "going to schedule process %d to run.\n", current->pid );
  switch_to( current );
}
