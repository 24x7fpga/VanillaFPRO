//#define _DEBUG

#include "chu_init.h"
#include "gpio_core.h"

void timer_check(GpoCore *led_p){
	int i;

	for(i = 0; i < 5; i++) {
		led_p->write(0xffff);
		sleep_ms(500);
		led_p->write(0x0000);
		sleep_ms(500);
		debug("timer check - loop #)/now: ", i, now_ms());
	}
}


void led_check(GpoCore *led_p, int n) {
   int i;

//   led_p->write(1, 0);
//   led_p->write(1, 1);
//   led_p->write(1, 2);
//   led_p->write(1, 3);


   for (i = 0; i < n; i++) {
      led_p->write(1, i);
      sleep_ms(200);
      led_p->write(0, i);
      sleep_ms(200);
   }
}

void sw_check(GpoCore *led_p, GpiCore *sw_p) {
   int i, s;

   s = sw_p->read();
   led_p->write(s);
//   for (i = 0; i < 30; i++) {
//      led_p->write(s);
//      sleep_ms(50);
//      led_p->write(0);
//      sleep_ms(50);
//   }
}

//void uart_check() {
//   static int loop = 0;

//   uart.disp("uart test #");
//   uart.disp(loop);
//   uart.disp("\n\r");
//   loop++;
//}


GpoCore led(get_slot_addr(BRIDGE_BASE, S2_LED));
GpiCore  sw(get_slot_addr(BRIDGE_BASE, S3_SW));

int main() {


	while(1){
		//timer_check(&led);
		//led_check(&led, 4);
		sw_check(&led, &sw);

		//debug("main - switch value / up time : ", sw.read(), now_ms());
	}
}
