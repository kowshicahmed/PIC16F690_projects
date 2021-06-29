#line 1 "D:/Lunabot/lunabot_main/MikroC_code_main/MyProject.c"
 char rcv=0x00;
 char rcv1;
 int count;
 int count1;


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
 if(rcv==0x77)
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
{TRISB=0b00100000;
TRISA=0X00;
TRISC=0X00;
PORTC=0X00;
PORTB=0X00;
count=0;
count1=0;

 InitUART();


 GIE_bit = 1;
 PEIE_bit = 1;

 while(1)
 {
 while(rcv1==0x00){
 }
 if(rcv1==0x77){
 PORTC=0b00000101;

 }
 else if(rcv1==0x73){
 PORTC=0b00001010;
 }
 else if(rcv1==0x61){
 PORTC=0b00000100;
 }
 else if(rcv1==0x64){
 PORTC=0b00000001;
 }
 else if(rcv1==0x65){
 PORTC=0b00100101;
 }
 else if(rcv1==0x71){
 PORTC=0b00100000;
 }

 else if (rcv1==0x31 && count==0)
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
 else if(rcv1==0x31 && count==1)
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
 else if(rcv1==0x32 && count1==0)
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
 else if(rcv1==0x32 && count1==1)
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
 {PORTC=0x00;
 PORTA=0x00;
 }
 rcv1=0x00;


 }



}
