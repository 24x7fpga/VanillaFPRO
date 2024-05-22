#ifndef _CHU_INIT_H_INCLUDED
#define _CHU_INIT_H_INCLUDED

// library
#include "chu_io_rw.h"
#include "chu_io_map.h"
#include "timer_core.h"

// define timer and UART slots
#define TIMER_SLOT 0
#define UART_SLOT  1

// time in microseconds
unsigned long now_us();

// time in milliseconds
unsigned long now_ms();

// idle for t microseconds
void sleep_us(unsigned long int t);

// idle for t milliseconds
void sleep_ms(unsigned long int t);


// timing functions
void debug_off();
void debug_on(const char *str, int n1, int n2);

#ifndef _DEBUG 
#define debug(str,n1,n2) debug_off()
#endif

// Macros for Single Bit Manipulation in C
#define bit_set(data,n) (data |= (1UL << n))
#define bit_clear(data,n) (data &= ~(1UL << n))
#define bit_toggle(data,n) (data ^= (1UL << n))
#define bit_read(data,n) ((data >> n) & 0x01)
#define bit_write(data,n, bitvalue) (bitvalue ? bit_set(data,n) : bit_clear(data,n))
#define bit(n) (1UL << n) 

#endif
