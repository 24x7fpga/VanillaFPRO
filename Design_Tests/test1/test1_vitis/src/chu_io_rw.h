#ifndef _CHU_IO_RW_H_INCLUDED
#define _CHU_IO_RW_H_INCLUDED

#include <inttypes.h> // to use unitN_t type
#ifdef __cplusplus
extern "C"{
#endif

//slot address
#define get_slot_addr(mmio_base, slot) ((uint32_t) (mmio_base + slot*32*4))

// read macro
#define io_read(base_addr, offset) (*(volatile uint32_t *)(base_addr + 4 * offset))

//write macro
#define io_write(base_addr, offset, data) (*(volatile uint32_t *) ((base_addr + 4 * offset)) = (data))

#ifdef __cplusplus
}
#endif

#endif
