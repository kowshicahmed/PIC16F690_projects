#line 1 "F:/pic project/mikroc_projects/MCU_pic16f690_projects/TIMER/TIMER_1/TIMER_1_SIMPLE_SEC_MIN_LCD/TIMER_1_SIMPLE_SEC_MIN_LCD.c"
sbit LCD_RS at RC4_bit;
sbit LCD_EN at RC5_bit;
sbit LCD_D7 at RC3_bit;
sbit LCD_D6 at RC2_bit;
sbit LCD_D5 at RC1_bit;
sbit LCD_D4 at RC0_bit;


sbit LCD_RS_Direction at TRISC4_bit;
sbit LCD_EN_Direction at TRISC5_bit;
sbit LCD_D7_Direction at TRISC3_bit;
sbit LCD_D6_Direction at TRISC2_bit;
sbit LCD_D5_Direction at TRISC1_bit;
sbit LCD_D4_Direction at TRISC0_bit;

int sec=0;
int minute=0;

int hour=0;
int count=0;

int sec_7seg_MSB=0;
int sec_7seg_LSB=0;

char min_7seg_LSB_MSB []={0,0};
char hour_7seg_LSB_MSB []={0,0};

void interrupt (void)
{if (TMR1IE_bit=1 && TMR1IF_bit==1)
 { count++;
TMR1IF_bit=0;

TMR1H=0x3C;
TMR1L=0xAF;
 }
}


void main()
{ TRISA=0x00;
 TRISB=0x00;
 TRISC=0x00;
 ANSEL=0;
 ANSELH=0;


PORTB=0X00;
PORTA=0X00;
PORTC=0X00;
RA5_bit=0 ;

 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Out(1,4,"00:00:00");
 Lcd_Out(2,2,"24 HOUR CLOCK");



PEIE_bit=1;
GIE_bit=1;

TMR1GE_bit=0;

T1CKPS1_bit=0;
T1CKPS0_bit=0;

TMR1IF_bit=0;
TMR1IE_bit=1;

TMR1CS_bit=0;

TMR1H=0x3C;
TMR1L=0xAF;




while (1)
 {

 TMR1ON_bit =1;
 if (count==20)
 {
 sec=(sec+1);
 count=0;
 sec_7seg_MSB=sec/10;
 sec_7seg_LSB=sec%10;

 Lcd_Chr(1,10,(sec_7seg_MSB+48));
 Lcd_Chr_Cp((sec_7seg_LSB+48));



 if (sec==60)
 {
 sec=0;
 minute=( minute+1);

 min_7seg_LSB_MSB[1]= minute/10;
 min_7seg_LSB_MSB[0]= minute%10;

 Lcd_Chr(1,7,(min_7seg_LSB_MSB[1]+48));
 Lcd_Chr_Cp((min_7seg_LSB_MSB[0]+48));

 if(minute==60)
 {
 minute==0;
 hour=(hour+1);

 hour_7seg_LSB_MSB[1]= hour/10;
 hour_7seg_LSB_MSB[0]= hour%10;

 Lcd_Chr(1,4,(hour_7seg_LSB_MSB[1]+48));
 Lcd_Chr_Cp((hour_7seg_LSB_MSB[0]+48));

 if (hour==12)
 {
 hour=0;
 }
 }
 }
 }


 }
}
