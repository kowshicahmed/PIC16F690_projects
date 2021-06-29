
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
{   TRISA=0x00;
    TRISB=0x00;
    TRISC=0x00;
	ANSEL=0;
	ANSELH=0;


PEIE_bit=1; // ENABLE PERIPHERAL INTERRUPT
GIE_bit=1;   // ENABLE GLOBAL INTERRUPT

TMR1GE_bit=0;  // IF TMR1ON IS HIGH,TIMER1 IS ON,

T1CKPS1_bit=0;//  T1CON(BIT 5,T1CKPS1 AND BIT4,T1CKPS0) IS SET TO 0 FOR A PRESCALAR 1:1
T1CKPS0_bit=0;//

TMR1IF_bit=0;   // TIMER1 INTERRUPT FLAG BIT INITIALLY SET TO 0 BEFORE ACTIVATING TIMER1 INTTERUPT ON NEXT LINE
TMR1IE_bit=1;  // ENABLE TIMER1 INTERRUPT ON OVERFLOW

TMR1CS_bit=0;  // INTERNAL CLOCK (FOSC/4)

TMR1H=0x3C;  // REGISTER VALUE OF TIMER1
TMR1L=0xAF;

PORTB=0X00;
PORTA=0X00;
PORTC=0X00;
RA5_bit=0    ;



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









