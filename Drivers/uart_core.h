//                 UART CLASS DEFINITION
//
// Register Structure:
//
//     ------------------------------------------------
//   0 |                | tx_full | rx_empty | r_data |  r
//     |                |    9    |    8     |   7-0  |
//     ------------------------------------------------
//   1 |              |              dvsr             |  w
//     |              |             10 - 0            |
//     ------------------------------------------------
//   2 |                                     | w_data |  w
//     |                                     |   7-0  |
//     ------------------------------------------------
//   3 |                data write                    |  w
//     |                                              |
//     ------------------------------------------------
//
//
//
#ifndef _UART_CORE_H_INLCUDED
#define _UART_CORE_H_INCLUDED

#include "chu_io_rw.h"
#include "chu_io_map.h"

class UartCore {
  /* register map*/
  enum {
    RD_DATA_REG    = 0,
    DVSR_REG       = 1,
    WR_DATA_REG    = 2,
    RM_RD_DATA_REG = 3    // remove read data
  };
  /* masks */
  enum {
    TX_FULL_FIELD = 0x00000200,
    RX_EMPT_FIELD = 0x00000100,
    RX_DATA_FIELD = 0x000000ff
  };
public:
  /* masks */
  UartCore (uint32_t core_base_addr);
  ~UartCore();
  // basic I/O access
  int rx_fifo_empty();
  int tx_fifo_full();
  int rx_byte();
  void set_baud_rate(int baud);
  void tx_byte(uint8_t byte);
  // display methods
  void disp(char ch);
  void disp(const char *str);
  void disp(int n, int base, int len);
  void disp(int n, int base);
  void disp(int n);
  void disp(double f, int digit);
  void disp(double f);
private:
  uint32_t base_addr;
  int baud_rate;
  void disp_str(const char *str);
};

#endif  // _UART_CORE_H_INCLUDED
