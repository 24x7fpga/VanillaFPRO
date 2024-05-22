#include "timer_core.h"
// TIMER CORE CLASS IMPLEMENTATION
TimerCore::TimerCore(uint32_t core_base_addr) {
  base_addr = core_base_addr;
  ctrl = 0x01;
  io_write(base_addr, CTRL_REG, ctrl);                      // enable timer 
}

TimerCore::~TimerCore() {

}

void TimerCore::pause() {
  ctrl = ctrl & ~GO_FIELD;                                 // reset enable bit to 0
  io_write(base_addr, CTRL_REG, ctrl);
}

void TimerCore::go() {
  ctrl = ctrl | GO_FIELD;                                 // set enable bit to 1
  io_write(base_addr, CTRL_REG, ctrl);
}

void TimerCore::clear() {
  uint32_t wdata;
  wdata = ctrl | CLR_FIELD;                               // write clear_bit to generate a 1-clock pulse
  io_write(base_addr, CTRL_REG, wdata);                  // cleat bit does not effect ctrl
}

uint64_t TimerCore::read_tick() {
  uint64_t upper, lower;
  
  lower = (uint64_t) io_read(base_addr, COUNTER_LOWER_REG);
  upper = (uint64_t) io_read(base_addr, COUNTER_UPPER_REG);

  return((upper << 32) | lower);
}

uint64_t TimerCore::read_time(){
  return(read_tick() / SYS_CLK_FREQ);
}

void TimerCore::sleep(uint64_t us) {
  uint64_t start_time, now;

  start_time = read_time();
  do {                                                  // busy waiting
    now = read_time();
  } while ((now - start_time) < us);
}


