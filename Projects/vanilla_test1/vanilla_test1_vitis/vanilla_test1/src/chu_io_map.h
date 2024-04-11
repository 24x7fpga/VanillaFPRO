#ifndef _CHU_IO_MAP_INCLUDED
#define _CHU_IO_MAP_INCLUDED

#include <inttypes.h>

#ifdef __cplusplus
extern "C" {
#endif

#define SYS_CLK_FREQ 125

// io base address for microblaze MCS (FRPO bridge address)
#define BRIDGE_BASE 0xc0000000

// slot machine definition
// format: SLOT#_ModuleType_Name
#define SO_SYS_TIME 0
#define S1_UART1    1
#define S2_LED      2
#define S3_SW       3

#ifdef __cplusplus
}
#endif

#endif
