#include "chu_init.h"

// FPRO UTILITY ROUTINE IMPLEMENTATION
TimerCore _sys_timer(get_slot_addr(BRIDGE_BASE, TIMER_SLOT));

unsigned long now_us() {
  return ((unsigned long) _sys_timer.read_time());
}

unsigned long now_ms() {
  return ((unsigned long) _sys_timer.read_time() / 1000);
}

void sleep_us(unsigned long int t) {
  _sys_timer.sleep(uint64_t(t));
}

void sleep_ms(unsigned long int t) {
  _sys_timer.sleep(uint64_t(1000*t));
}



