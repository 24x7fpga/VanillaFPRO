
#include "chu_init.h"
#include "gpio_core.h"

void timer_check(GpoCore *led_p){
	int i;

	for(i = 0; i < 5; i++) {
		led_p->write(0xffff);
		sleep_ms(500);
		led_p->write(0x0000);
		sleep_ms(500);
	}
}


void led_check(GpoCore *led_p, int n) {

   led_p->write(1, 1);
   led_p->write(0, 2);
   led_p->write(1, 3);
   led_p->write(0, 4);

}


void sw_check(GpoCore *led_p, GpiCore *sw_p) {
   int s;

   s = sw_p->read();
   led_p->write(s);

}

void btn_check(GpoCore *led_p, GpiCore *btn_p) {
   int b;

   b = btn_p->read();
   led_p->write(b);

}



GpoCore led(get_slot_addr(BRIDGE_BASE, S2_LED));
GpiCore  sw(get_slot_addr(BRIDGE_BASE, S3_SW));
GpiCore btn(get_slot_addr(BRIDGE_BASE, S4_BTN));

int main() {

	while(1){

		// UNCOMMENT TO TEST

		// test for time -> leds blinks for 1/2 second
		timer_check(&led);

		// test for led -> leds turn on with the set pattern
		//led_check(&led, 4);

		// test for switches -> leds turn on based on the switches are turn on (up)
		//sw_check(&led, &sw);

		// test for push buttons -> leds turn on based on which push button is pressed
		//btn_check(&led, &btn);
	}
}
