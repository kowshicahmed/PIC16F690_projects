sbit LCD_RS at RA0_bit;
sbit LCD_EN at RA1_bit;
sbit LCD_D7 at RC3_bit;
sbit LCD_D6 at RC2_bit;
sbit LCD_D5 at RC1_bit;
sbit LCD_D4 at RC0_bit;

// Pin direction
sbit LCD_RS_Direction at TRISA0_bit;
sbit LCD_EN_Direction at TRISA1_bit;
sbit LCD_D7_Direction at TRISC3_bit;
sbit LCD_D6_Direction at TRISC2_bit;
sbit LCD_D5_Direction at TRISC1_bit;
sbit LCD_D4_Direction at TRISC0_bit;

int count=0;


void interrupt (void)
{if (TMR2IE_bit=1 && TMR2IF_bit==1)
 {
count++;



TMR2IF_bit=0;

        }
}


void main()
{   TRISA=0x00;
    TRISB=0x00;
    TRISC=0x00;
ANSEL=0;
ANSELH=0;

PORTA=0X00;
PORTB=0X00;
PORTC=0X00;


  Lcd_Init();
  Lcd_Cmd(_LCD_CLEAR);               // Clear display
  Lcd_Cmd(_LCD_CURSOR_OFF);


PEIE_bit=1; // ENABLE PERIPHERAL INTERRUPT
GIE_bit=1;   // ENABLE GLOBAL INTERRUPT



T2CKPS1_bit=0;//  T2CON(BIT 1-T1CKPS1 AND BIT 0-T1CKPS0) IS SET TO 0 FOR A PRESCALAR 1:1
T2CKPS0_bit=0;//

 TOUTPS3_bit=0;
 TOUTPS2_bit=0;   //  T2CON(BIT6 ,BIT 5,BIT 4, BIT3)  IS SET TO 0 FOR A POSTSCALAR 1:1
 TOUTPS1_bit=0;
 TOUTPS0_bit=0;

TMR2IF_bit=0;   // TIMER1 INTERRUPT FLAG BIT INITIALLY SET TO 0 BEFORE ACTIVATING TIMER1 INTTERUPT ON NEXT LINE
TMR2IE_bit=1;  // ENABLE TIMER1 INTERRUPT ON OVERFLOW



PR2=200;      // SETTING VALUE OF PR2, THAT IS WHEN TIMER 2
//MATCHED THE VALUE OF PR2 REGISTER WHILE INCREMENTING ,INTERRUPT WILL OCCUR AS INTERRUPT TMR2IE, IS ENABLED.



    TMR2ON_bit =1;


while (1)
 {


    if(count==25)
    {   RC7_bit=~RC7_bit;


     count=0;
    }
    else{}


  }}