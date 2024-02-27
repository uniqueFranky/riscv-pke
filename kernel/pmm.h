#ifndef _PMM_H_
#define _PMM_H_
#include "util/types.h"
// Initialize phisical memeory manager
void pmm_init();
// Allocate a free phisical page
void* alloc_page();
// Free an allocated page
void free_page(void* pa);

typedef struct memory_descriptor_t {
    uint64 start_pa;
    uint64 start_va;
    uint64 size;
    uint64 page_start_pa;
    uint64 page_start_va;
    struct memory_descriptor_t *next;
} memory_descriptor;

memory_descriptor *alloc_memory_descriptor();
void free_memory_descriptor(memory_descriptor *md);


void insert_into_md_list(memory_descriptor **head, memory_descriptor *md, int merge);
void remove_from_md_list(memory_descriptor **head, memory_descriptor *md);

#endif