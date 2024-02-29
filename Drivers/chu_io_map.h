#ifndef _CHU_IO_MAP_INCLUDED
#define _CHU_IO_MAP_INCLUDED

#ifdef __cplusplus
extern "C" {
#endif

#define SYS_CLK_FREQ 100

// io base address for microblaze MCS (FRPO bridge address)
#define BRIDGE_BASE 0xc0000000

// slot machine definition
// format: SLOT#_ModuleType_Name
#define SO_SYS_TIME 0
#define SO_UART1    1
#define SO_LED      2
#define SO_SW       3

#ifdef __cplusplus
}
#endif

#endif
