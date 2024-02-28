#include "pmm.h"
#include "process.h"
#include "util/functions.h"
#include "riscv.h"
#include "config.h"
#include "util/string.h"
#include "memlayout.h"
#include "spike_interface/spike_utils.h"

// _end is defined in kernel/kernel.lds, it marks the ending (virtual) address of PKE kernel
extern char _end[];
// g_mem_size is defined in spike_interface/spike_memory.c, it indicates the size of our
// (emulated) spike machine. g_mem_size's value is obtained when initializing HTIF. 
extern uint64 g_mem_size;

static uint64 free_mem_start_addr;  //beginning address of free memory
static uint64 free_mem_end_addr;    //end address of free memory (not included)

typedef struct node {
  struct node *next;
} list_node;

memory_descriptor memory_descriptor_pool[PGSIZE / sizeof(memory_descriptor)];

list_node free_md_list;

void free_memory_descriptor(memory_descriptor *md) {
  ((list_node *)md)->next = free_md_list.next;
  free_md_list.next = (list_node *)md;
}

memory_descriptor *alloc_memory_descriptor() {
  if(NULL == free_md_list.next) {
    panic("insufficient memory descriptor!");
  }
  memory_descriptor *ret = (memory_descriptor *)free_md_list.next;
  free_md_list.next = (free_md_list.next)->next;
  return ret;
}

void insert_into_md_list(memory_descriptor **head, memory_descriptor *md, int merge) {

  memory_descriptor *prev;

  // insert into list order by start_pa
  if(NULL == *head || (*head)->start_pa > md->start_pa) {
    md->next = *head;
    *head = md;
    prev = NULL;
  } else {
    memory_descriptor *now = *head;
    while(NULL != now->next && now->next->start_pa < md->start_pa) {
      now = now->next;
    }
    md->next = now->next;
    now->next = md;
    prev = now;
  }

  // try to merge continous areas
  // at most merge the md before and after the inserted one
  if(merge) {
    if(NULL != md->next && md->start_pa + md->size == md->next->start_pa 
      && md->page_start_pa == md->next->page_start_pa) { // must in the same page
        md->size += md->next->size;
        free_memory_descriptor(md->next);
        md->next = md->next->next;
      }

      if(NULL != prev && prev->start_pa + prev->size == md->start_pa
      && prev->page_start_pa == md->page_start_pa) {
        prev->size += md->size;
        free_memory_descriptor(md);
        prev->next = md->next;
      }
  }
}
void remove_from_md_list(memory_descriptor **head, memory_descriptor *md) {
  if(*head == md) {
    *head = (*head)->next;
  } else {
    memory_descriptor *now = *head;
    while(NULL != now->next && md != now->next) {
      now = now->next;
    }
    now->next = now->next->next;
  }
}

int get_page_id_by_start_pa(uint64 pa) {
  process *p = current;
  for(int i = 0; i < PROC_MAX_PAGE_NUM; i++) {
    if(p->page_cb[i].valid && p->page_cb[i].start_pa == pa) {
      return i;
    }
  }
  return -1;
}

// g_free_mem_list is the head of the list of free physical memory pages
static list_node g_free_mem_list;

//
// actually creates the freepage list. each page occupies 4KB (PGSIZE), i.e., small page.
// PGSIZE is defined in kernel/riscv.h, ROUNDUP is defined in util/functions.h.
//
static void create_freepage_list(uint64 start, uint64 end) {
  g_free_mem_list.next = 0;
  for (uint64 p = ROUNDUP(start, PGSIZE); p + PGSIZE < end; p += PGSIZE)
    free_page( (void *)p );
}

//
// place a physical page at *pa to the free list of g_free_mem_list (to reclaim the page)
//
void free_page(void *pa) {
  if (((uint64)pa % PGSIZE) != 0 || (uint64)pa < free_mem_start_addr || (uint64)pa >= free_mem_end_addr)
    panic("free_page 0x%lx \n", pa);

  // insert a physical page to g_free_mem_list
  list_node *n = (list_node *)pa;
  n->next = g_free_mem_list.next;
  g_free_mem_list.next = n;
}

//
// takes the first free page from g_free_mem_list, and returns (allocates) it.
// Allocates only ONE page!
//
void *alloc_page(void) {
  list_node *n = g_free_mem_list.next;
  if (n) g_free_mem_list.next = n->next;

  return (void *)n;
}

//
// pmm_init() establishes the list of free physical pages according to available
// physical memory space.
//
void pmm_init() {
  // start of kernel program segment
  uint64 g_kernel_start = KERN_BASE;
  uint64 g_kernel_end = (uint64)&_end;

  uint64 pke_kernel_size = g_kernel_end - g_kernel_start;
  sprint("PKE kernel start 0x%lx, PKE kernel end: 0x%lx, PKE kernel size: 0x%lx .\n",
    g_kernel_start, g_kernel_end, pke_kernel_size);

  // free memory starts from the end of PKE kernel and must be page-aligined
  free_mem_start_addr = ROUNDUP(g_kernel_end , PGSIZE);

  // recompute g_mem_size to limit the physical memory space that our riscv-pke kernel
  // needs to manage
  g_mem_size = MIN(PKE_MAX_ALLOWABLE_RAM, g_mem_size);
  if( g_mem_size < pke_kernel_size )
    panic( "Error when recomputing physical memory size (g_mem_size).\n" );

  free_mem_end_addr = g_mem_size + DRAM_BASE;
  sprint("free physical memory address: [0x%lx, 0x%lx] \n", free_mem_start_addr,
    free_mem_end_addr - 1);

  sprint("kernel memory manager is initializing ...\n");
  // create the list of free pages
  create_freepage_list(free_mem_start_addr, free_mem_end_addr);

  // init free_md_list
  free_md_list.next = NULL;
  for(int i = 0; i < PGSIZE / sizeof(memory_descriptor); i++) {
    free_memory_descriptor(memory_descriptor_pool + i);
  }

}
