#line 1 "D:/pilabs/MCU_pic_class/MCU_pic16f690_projects/Servo_motor_controller/Servo_Motor_Control.c"


void main() {

 TRISA = 0x04;
 TRISB=0X00;
 TRISC=0X00;
 ANSEL = 0;
 ANSELH = 0;
 C1ON_bit = 0;
 C2ON_bit = 0;


 PORTB = 0;
 PORTC=0X00;


 while (1) {



 if (RA0_bit==1 && RA1_bit==0)
 {

 RC0_bit=1;
 Delay_us(1150);
 RC0_bit=0;
 Delay_us(18850);
 Delay_ms(2000);

 }


 else if( RA0_bit==0 && RA1_bit==1)
 {

 RC0_bit=1;
 Delay_us(700);
 RC0_bit=0;
 Delay_us(19300);
 }
 else RC0_bit=0;
}
}
