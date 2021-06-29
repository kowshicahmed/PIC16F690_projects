char rcv = 0x00; //declared an 8bit character to take the received data
char rcv1;

void InitUART(void)
{
    ANSEL = 0;  // disable analog input
    ANSELH = 0; // disable analog input
    ANS11_bit = 0;

    SPBRG = 103;  // selected 2400 baud-rate
    BRGH_bit = 1; // RX Pin
    SYNC_bit = 0; // Asynchronous Operation
    SPEN_bit = 1; // Enable serial port pins
    CREN_bit = 1; // Enable reception
    SREN_bit = 0; // No effect
    TXIE_bit = 0; // Disable tx interrupts
    RCIE_bit = 1; // Enable rx interrupts
    TX9_bit = 0;  // 8-bit transmission
    RX9_bit = 0;  // 8-bit reception
    TXEN_bit = 0; // Reset transmitter
    TXEN_bit = 1; // Enable the transmitter
}
void interrupt(void)
{
    if (RCIF_bit == 1) // If UART Rx Interrupt
    {
        if (OERR_bit) // If over run error, then reset the receiver
        {
            CREN_bit = 0;
            CREN_bit = 1;
        }
        rcv = RCREG; // save the data in rcv
    }
}
void main(void)
{
    TRISB = 0b00100000; //declared RB5_bit as input which is the uart RX pin
    TRISA = 0X00;
    TRISC = 0X00;
    PORTC = 0X00;
    PORTB = 0X00;

    InitUART(); // Intialize UART

    GIE_bit = 1;  // Enable global interrupts
    PEIE_bit = 1; // Enable Peripheral Interrupts

    while (1) //here the mcu will only transmit "w" "a" "s" "d" "q" "e" "1" "2" and "f" for brake operation
    {
        if (rcv == 0x77)
        {
            rcv1 = rcv;
            TXREG = rcv1;
        }
        else if (rcv == 0x61)
        {
            rcv1 = rcv;
            TXREG = rcv1;
        }
        else if (rcv == 0x73)
        {
            rcv1 = rcv;
            TXREG = rcv1;
        }
        else if (rcv == 0x64)
        {
            rcv1 = rcv;
            TXREG = rcv1;
        }
        else if (rcv == 0x71)
        {
            rcv1 = rcv;
            TXREG = rcv1;
        }
        else if (rcv == 0x65)
        {
            rcv1 = rcv;
            TXREG = rcv1;
        }
        else if (rcv == 0x31)
        {
            rcv1 = rcv;
            TXREG = rcv1;
        }
        else if (rcv == 0x32)
        {
            rcv1 = rcv;
            TXREG = rcv1;
        }
        else if (rcv == 0x66)
        {
            rcv1 = rcv;
            TXREG = rcv1;
        }
    }
}