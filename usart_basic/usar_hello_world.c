
char rcv;
void InitUART(void)
{   ANSEL=0;
    ANSELH=0;
    ANS11_bit =0;

    SPBRG = 25  ;
	BRGH_bit   = 1;
 					// RX Pin
	SYNC_bit =0;			//Asynchronous Operation

	SPEN_bit   = 1;						// Enable serial port pins
	CREN_bit   = 1;						// Enable reception
	SREN_bit   = 0;						// No effect
	TXIE_bit   = 0;						// Disable tx interrupts
	RCIE_bit   = 1;						// Enable rx interrupts
	TX9_bit    = 0;						// 8-bit transmission
	RX9_bit    = 0;						// 8-bit reception
	TXEN_bit   = 0;						// Reset transmitter
	TXEN_bit   = 1;						// Enable the transmitter
}

void SendByteSerially(unsigned char Byte)  // Writes a character to the serial port
{
	while(!TXIF_bit );  // wait for previous transmission to finish
	TXREG = Byte;
}
unsigned char ReceiveByteSerially(void)   // Reads a character from the serial port
{
	if(OERR_bit ) // If over run error, then reset the receiver
	{
		CREN_bit  = 0;
		CREN_bit  = 1;
	}

	while(!RCIF_bit );  // Wait for transmission to receive

	return RCREG;
}
void SendStringSerially(const unsigned char* st)
{
	while(*st)
		SendByteSerially(*st++);
}

void interrupt(void)
{
	if(RCIF_bit )  // If UART Rx Interrupt
	{
		if(OERR_bit ) // If over run error, then reset the receiver
		{
			CREN_bit  = 0;
			CREN_bit  = 1;
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

	InitUART();							// Intialize UART

    SendStringSerially("Hello World!");	// Send string on UART

	GIE_bit  = 1;  							// Enable global interrupts
    PEIE_bit  = 1;  							// Enable Peripheral Interrupts
    rcv=0x00;
	while(1)
	{
	
	if(rcv!=0x00 && rcv!=0x41)
	{  SendByteSerially('\n');
         SendByteSerially('\r');
	SendByteSerially(rcv); // Echo back received char
	 rcv=0x00;
	 }
	 
	 else if(rcv!=0x00 && rcv==0x41)
	{  PORTC=0X41;
	 rcv=0x00;}

}
}