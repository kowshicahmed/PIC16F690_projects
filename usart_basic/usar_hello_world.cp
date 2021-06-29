#line 1 "F:/pic project/mikroc_projects/MCU_pic16f690_projects/USART/usar_hello_world.c"

char rcv;
void InitUART(void)
{ ANSEL=0;
 ANSELH=0;
 ANS11_bit =0;

 SPBRG = 25 ;
 BRGH_bit = 1;

 SYNC_bit =0;

 SPEN_bit = 1;
 CREN_bit = 1;
 SREN_bit = 0;
 TXIE_bit = 0;
 RCIE_bit = 1;
 TX9_bit = 0;
 RX9_bit = 0;
 TXEN_bit = 0;
 TXEN_bit = 1;
}

void SendByteSerially(unsigned char Byte)
{
 while(!TXIF_bit );
 TXREG = Byte;
}
unsigned char ReceiveByteSerially(void)
{
 if(OERR_bit )
 {
 CREN_bit = 0;
 CREN_bit = 1;
 }

 while(!RCIF_bit );

 return RCREG;
}
void SendStringSerially(const unsigned char* st)
{
 while(*st)
 SendByteSerially(*st++);
}

void interrupt(void)
{
 if(RCIF_bit )
 {
 if(OERR_bit )
 {
 CREN_bit = 0;
 CREN_bit = 1;
 }
 rcv=RCREG;

 }
}

void main(void)
{TRISB=0B00100000;
TRISA=0X00;
TRISC=0X00;
PORTC=0X00;
PORTB=0X00;

 InitUART();

 SendStringSerially("Hello World!");

 GIE_bit = 1;
 PEIE_bit = 1;
 rcv=0x00;
 while(1)
 {

 if(rcv!=0x00 && rcv!=0x41)
 { SendByteSerially('\n');
 SendByteSerially('\r');
 SendByteSerially(rcv);
 rcv=0x00;
 }

 else if(rcv!=0x00 && rcv==0x41)
 { PORTC=0X41;
 rcv=0x00;}

}
}
