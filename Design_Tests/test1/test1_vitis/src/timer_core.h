#ifndef _TIMER_H_INCLUDED
#define _TIMER_H_INCLUDED

#include "chu_io_rw.h"
#include "chu_io_map.h"

// TIMER CORE CLASS DEFINITION
class TimerCore {
 public:
  /*register map*/
  enum {
    COUNTER_LOWER_REG = 0,                  // lower 32-bits of counter
    COUNTER_UPPER_REG = 1,                  // upper 16-bits of counter
    CTRL_REG          = 2                   // control register; clr and go
  };

  /*field masks*/
  enum {
    GO_FIELD  = 0x00000001,                 // bit 0 of ctrl reg; enable bit 
    CLR_FIELD = 0x00000002                  // bit 1 of ctrl reg; clear bit 
  };

  TimerCore(uint32_t core_base_addr);       // constructor
  ~TimerCore();

  void pause();                             // pause counter 
  void go();                                // resume counter
  void clear();                             // clear counter
  uint64_t read_tick();                     // retrieve # clocks elapsed
  uint64_t read_time();                     // read time elapsed (in us)
  void sleep(uint64_t us);                  // ideal for us

 private:
  uint32_t base_addr;
  uint32_t ctrl;                            // current state of control register
};

#endif
