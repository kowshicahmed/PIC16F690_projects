#line 1 "F:/pic project/mikroc_projects/MCU_pic16f690_projects/TIMER/TIMER_1/TIMER_1_SIMPLE_SEC_MIN_7SEG/TIMER_1_SEC_MIN_7SEG.c"

int sec=0;
int minute=0;

int hour=0;
int count=0;

int sec_7seg_MSB=0;
int sec_7seg_LSB=0;

char min_7seg_LSB_MSB []={0,0};

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

PORTB=0X00;
PORTA=0X00;
PORTC=0X00;
RA5_bit=0 ;



while (1)
 {

 TMR1ON_bit =1;
 if (count==20)
 {
 sec=(sec+1);
 count=0;
 sec_7seg_MSB=sec/10;
 sec_7seg_LSB=sec%10;
 PORTC= (sec_7seg_MSB<<4)+ sec_7seg_LSB;

 if (sec==60)
 {
 sec=0;
 minute=( minute+1);

 min_7seg_LSB_MSB[0]= minute/10;
 min_7seg_LSB_MSB[1]= minute%10;

 PORTB=(min_7seg_LSB_MSB[0]<<4) +0 ;

 RA0_bit= min_7seg_LSB_MSB[1];
 RA1_bit= min_7seg_LSB_MSB[1]>>1;
 RA2_bit= min_7seg_LSB_MSB[1]>>2;
 RA5_bit= min_7seg_LSB_MSB[1]>>3;


 if(minute==60)
 {
 minute==0;
 hour=(hour+1);

 if (hour==12)
 {
 hour=0;
 }
 }
 }
 }


 }
}
