`ifndef _CHU_IO_MAP_INCLUDED
`define _CHU_IO_MAP_INCLUDED

// system clock in MHz
 `define SYS_CLK_FREQ 125

// IO base address for microblaze MCS
 `define BRIDGE_BASE 0xc0000000

//slot module definition
//format: S#_ModuleType_Name
 `define S0_SYS_TIMER 0
 `define S1_UART1     1
 `define S2_LED       2
 `define S3_SW        3

`endif //  `ifndef _CHU_IO_MAP_INCLUDED
