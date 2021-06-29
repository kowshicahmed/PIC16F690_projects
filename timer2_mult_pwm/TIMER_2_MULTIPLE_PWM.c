

int count=0;

int pwm_value=0;






void pwm_select(int a)
{

  if(count==a)
           {
             pwm_value=1;
           }
         else if(count==50)
           {  pwm_value=2;
              count=0;
           }
         else{}

        if (pwm_value==2)
          {
            RC7_bit=1;
          }
        else if (pwm_value==1)
          {
            RC7_bit=0;
          }
        else {}




}

void interrupt (void)
{if (TMR2IE_bit=1 && TMR2IF_bit==1)
 {
count++;



TMR2IF_bit=0;

        }
}


void main()
{   TRISA=0x07;
    TRISB=0x10;
    TRISC=0x00;
ANSEL=0;
ANSELH=0;
CM1CON0=0;
CM2CON0=0;

C1ON_bit=0;
C2ON_bit=0;

RA4_bit=0;
RA5_bit=0;
RB7_bit==0;
RB6_bit==0;
RB5_bit==0;

PORTC=0X00;




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

    if(RA0_bit==1 && RA1_bit==0 && RA2_bit==0 && RB4_bit==0)
       {
           pwm_select(38);
       }

    else if(RA0_bit==0 && RA1_bit==1 && RA2_bit==0 && RB4_bit==0)
       {

         pwm_select(25);

       }


    else if(RA0_bit==0 && RA1_bit==0 && RA2_bit==1 && RB4_bit==0)
       {

        pwm_select(13);

       }


        else{count=0;RC7_bit=0;}





  }}









