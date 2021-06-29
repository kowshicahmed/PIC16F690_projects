#line 1 "D:/Lunabot/lunabot_main/MikroC_transmission/rf_module_tx.c"
 char rcv=0x00;
 char rcv1;



void InitUART(void)
{ ANSEL=0;
 ANSELH=0;
 ANS11_bit =0;

 SPBRG = 103 ;
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
void interrupt(void)
{
 if(RCIF_bit==1 )
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
{TRISB=0b00100000;
TRISA=0X00;
TRISC=0X00;
PORTC=0X00;
PORTB=0X00;

 InitUART();


 GIE_bit = 1;
 PEIE_bit = 1;

 while(1)
 { if(rcv==0x77)
 {rcv1=rcv;
 TXREG=rcv1;

 }
 else if (rcv==0x61)
 {rcv1=rcv;
 TXREG=rcv1;

 }
 else if (rcv==0x73)
 {rcv1=rcv;
 TXREG=rcv1;

 }
 else if (rcv==0x64)
 {rcv1=rcv;
 TXREG=rcv1;

 }
 else if (rcv==0x71)
 {rcv1=rcv;
 TXREG=rcv1;

 }
 else if (rcv==0x65)
 {rcv1=rcv;
 TXREG=rcv1;

 }
 else if (rcv==0x31)
 {rcv1=rcv;
 TXREG=rcv1;

 }
 else if (rcv==0x32)
 {rcv1=rcv;
 TXREG=rcv1;

 }
 else if (rcv==0x66)
 {rcv1=rcv;
 TXREG=rcv1;

 }

 }



}
