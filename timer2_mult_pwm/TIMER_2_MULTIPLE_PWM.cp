#line 1 "F:/pic project/mikroc_projects/MCU_pic16f690_projects/TIMER/TIMER_2/TIMER_2_MULTIPLE_PWM/TIMER_2_MULTIPLE_PWM.c"


int count=0;

int pwm_value=0;






void pwm_select(int a)
{

 if(count==a)
 {
 pwm_value=1;
 }
 else if(count==50)
 { pwm_value=2;
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
{ TRISA=0x07;
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




PEIE_bit=1;
GIE_bit=1;



T2CKPS1_bit=0;
T2CKPS0_bit=0;

 TOUTPS3_bit=0;
 TOUTPS2_bit=0;
 TOUTPS1_bit=0;
 TOUTPS0_bit=0;

TMR2IF_bit=0;
TMR2IE_bit=1;



PR2=200;

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
