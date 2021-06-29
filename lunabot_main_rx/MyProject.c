     char rcv=0x00;               //declared an 8bit character to take the received data
     char rcv1;                   //filters out the desired data
     int count;                   //variable for stepper control
     int count1;


void InitUART(void)
{   ANSEL=0;                 // disable analog input
    ANSELH=0;               // disable analog input
    ANS11_bit =0;

        SPBRG = 103  ;         // selected 2400 baud-rate
        BRGH_bit   = 1;        // RX Pin
        SYNC_bit =0;           // Asynchronous Operation
        SPEN_bit   = 1;        // Enable serial port pins
        CREN_bit   = 1;        // Enable reception
        SREN_bit   = 0;        // No effect
        TXIE_bit   = 0;        // Disable tx interrupts
        RCIE_bit   = 1;        // Enable rx interrupts
        TX9_bit    = 0;        // 8-bit transmission
        RX9_bit    = 0;        // 8-bit reception
        TXEN_bit   = 0;        // Reset transmitter
        TXEN_bit   = 1;        // Enable the transmitter
}
void interrupt(void)
{
        if(RCIF_bit==1 )  // If UART Rx Interrupt
        {
                if(OERR_bit ) // If over run error, then reset the receiver
                {
                        CREN_bit  = 0;
                        CREN_bit  = 1;
                }
  rcv=RCREG;             // save the data in rcv
  if(rcv==0x77)           //filtering process
        {rcv1=rcv;
        }
        else if (rcv==0x61)
        {rcv1=rcv;
        }
        else if (rcv==0x73)
        {rcv1=rcv;
        }
        else if (rcv==0x64)
        {rcv1=rcv;
        }
        else if (rcv==0x71)
        {rcv1=rcv;
        }
        else if (rcv==0x65)
        {rcv1=rcv;
        }
        else if (rcv==0x31)
        {rcv1=rcv;
        }
        else if (rcv==0x32)
        {rcv1=rcv;
        }
        else if (rcv==0x66)
        {rcv1=rcv;
        }

        }
}
void main(void)
{TRISB=0b00100000;        //declared RB5_bit as input which is the uart RX pin
TRISA=0X00;
TRISC=0X00;
PORTC=0X00;
PORTB=0X00;
count=0;
count1=0;

        InitUART();        // Intialize UART


        GIE_bit  = 1;       // Enable global interrupts
    PEIE_bit  = 1;         // Enable Peripheral Interrupts

        while(1)
        {
        while(rcv1==0x00){
        }
         if(rcv1==0x77){         //if rcv=w(0x77)
         PORTC=0b00000101;      //both motors will rotate in foreward direction

         }
         else if(rcv1==0x73){    //if rcv=s(0x73)
         PORTC=0b00001010;      //both motors will in backward direction
         }
          else if(rcv1==0x61){   //if rcv=a(0x61)
            PORTC=0b00000100;   //left motor will be stopped right motor will rotate foreward
          }
          else if(rcv1==0x64){   //if rcv=d(0x64)
          PORTC=0b00000001;     //right motor will be stopped left motor will rotate foreward
          }
          else if(rcv1==0x65){    //if rcv=e(0x65)
          PORTC=0b00100101;       //moving forward and digging
          }
          else if(rcv1==0x71){     //if rcv=q(0x671)
          PORTC=0b00100000;        //only digging
          }

         else if (rcv1==0x31 && count==0)     //if "1" is pressed the stepper will have half rotation in the front
       {



            PORTA=0b00000011;
            Delay_ms(1000);

            PORTA=0b00000010;
            Delay_ms(1000);
            PORTA=0b00000110;
            Delay_ms(1000);
            PORTA=0b00000100;
            Delay_ms(1000);
            rcv1=0x00;
            count=1;
            }
            else if(rcv1==0x31 && count==1)       //if "1" is pressed again the stepper will have another half rotation in the front
            {
            PORTA=0b00010100;
            Delay_ms(1000);

            PORTA=0b00010000;
            Delay_ms(1000);

            PORTA=0b00010001;
            Delay_ms(1000);
            PORTA=0b00000001;
            Delay_ms(1000);
            rcv1=0x00;
            count=0;

            }
            else if(rcv1==0x32 && count1==0)   //if "2" is pressed the stepper will have half rotation in the backward direction
            {
            PORTA=0b00010001;
            Delay_ms(1000);
            PORTA=0b00010000;
            Delay_ms(1000);
            PORTA=0b00010100;
            Delay_ms(1000);
            PORTA=0b00000100;
            Delay_ms(1000);
            rcv1=0x00;
            count1=1;

            }
            else if(rcv1==0x32 && count1==1)     //if "2" is pressed again the stepper will have another half rotation in the backward direction
            {
            PORTA=0b00000110;
            Delay_ms(1000);
            PORTA=0b00000010;
            Delay_ms(1000);
            PORTA=0b00000011;
            Delay_ms(1000);
            PORTA=0b00000001;
            Delay_ms(1000);
            rcv1=0x00;
            count1=0;
            }
            
            
             else
         {PORTC=0x00;           //brake for any other button
         PORTA=0x00;
         }
         rcv1=0x00;
         
         //Stepper_control();
 }



}