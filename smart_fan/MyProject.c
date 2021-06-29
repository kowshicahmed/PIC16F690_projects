int reg_value=0;
float analog=0.0;
int analog_h;
int analog_l=0;
int value=0;
char temp_c=0x00;

// Lcd pinout settings
sbit LCD_RS at RC0_bit;
sbit LCD_EN at RC1_bit;
sbit LCD_D7 at RC6_bit;
sbit LCD_D6 at RC4_bit;
sbit LCD_D5 at RC3_bit;
sbit LCD_D4 at RC2_bit;

// Pin direction
sbit LCD_RS_Direction at TRISC0_bit;
sbit LCD_EN_Direction at TRISC1_bit;
sbit LCD_D7_Direction at TRISC6_bit;
sbit LCD_D6_Direction at TRISC4_bit;
sbit LCD_D5_Direction at TRISC3_bit;
sbit LCD_D4_Direction at TRISC2_bit;


void main() {
TRISA=0b00000001;  // defining RA0 as input
TRISB=0X00;
TRISC=0X00;
ANSEL=0x01;
ANSELH=0;
PORTB=0X00;
C1ON_bit = 0;               // Disable comparators
C2ON_bit = 0;

    Lcd_Init();
    PWM1_Init(5000);                    // Initialize PWM1 module at 5KHz
  
    Lcd_Cmd(_LCD_CLEAR);               // Clear display
    Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
    Lcd_Out(1, 1, "TEMPERATURE= ");
while(1)
{   PWM1_Start();                       // start PWM1
    reg_value=ADC_read(0);
    analog=(reg_value* 5.00)/1023;
    value=analog*100;
    analog_h=(value/10);
    analog_l=(value%10);
    temp_c= (analog_h<<4) + analog_l ;


   Lcd_Chr(1,13,analog_h+48);
   Lcd_Chr(1,14,analog_l+48);
   Lcd_Chr(1,15,0xDF);
   Lcd_Out(1,16,"C");


 if(temp_c<=0x20)
{

       LCD_Out(2,3,"MOTOR AT 20% ");
       PWM1_Set_Duty(77);        // Set current duty 30%
       Delay_ms(500);
 }
  else if(temp_c>0x20 && temp_c<=0x30)
 {
       LCD_Out(2,3,"MOTOR AT 40% ");
       PWM1_Set_Duty(127);        // Set current duty 50%
       Delay_ms(500);
 }

 else if(temp_c>0x30 && temp_c<0x40) {

       LCD_Out(2,3,"MOTOR AT 75% ");
       PWM1_Set_Duty(192);        // Set current duty 75%
       Delay_ms(500);
}
else{
       LCD_Out(2,3, "MOTOR AT 100%");
       PWM1_Set_Duty(255);        // Set current duty 100%
       Delay_ms(500);
       }

}

}