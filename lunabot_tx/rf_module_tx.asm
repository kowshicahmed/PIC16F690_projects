
_InitUART:

;rf_module_tx.c,6 :: 		void InitUART(void)
;rf_module_tx.c,7 :: 		{   ANSEL=0;                 // disable analog input
	CLRF       ANSEL+0
;rf_module_tx.c,8 :: 		ANSELH=0;               // disable analog input
	CLRF       ANSELH+0
;rf_module_tx.c,9 :: 		ANS11_bit =0;
	BCF        ANS11_bit+0, BitPos(ANS11_bit+0)
;rf_module_tx.c,11 :: 		SPBRG = 103  ;         // selected 2400 baud-rate
	MOVLW      103
	MOVWF      SPBRG+0
;rf_module_tx.c,12 :: 		BRGH_bit   = 1;        // RX Pin
	BSF        BRGH_bit+0, BitPos(BRGH_bit+0)
;rf_module_tx.c,13 :: 		SYNC_bit =0;           // Asynchronous Operation
	BCF        SYNC_bit+0, BitPos(SYNC_bit+0)
;rf_module_tx.c,14 :: 		SPEN_bit   = 1;        // Enable serial port pins
	BSF        SPEN_bit+0, BitPos(SPEN_bit+0)
;rf_module_tx.c,15 :: 		CREN_bit   = 1;        // Enable reception
	BSF        CREN_bit+0, BitPos(CREN_bit+0)
;rf_module_tx.c,16 :: 		SREN_bit   = 0;        // No effect
	BCF        SREN_bit+0, BitPos(SREN_bit+0)
;rf_module_tx.c,17 :: 		TXIE_bit   = 0;        // Disable tx interrupts
	BCF        TXIE_bit+0, BitPos(TXIE_bit+0)
;rf_module_tx.c,18 :: 		RCIE_bit   = 1;        // Enable rx interrupts
	BSF        RCIE_bit+0, BitPos(RCIE_bit+0)
;rf_module_tx.c,19 :: 		TX9_bit    = 0;        // 8-bit transmission
	BCF        TX9_bit+0, BitPos(TX9_bit+0)
;rf_module_tx.c,20 :: 		RX9_bit    = 0;        // 8-bit reception
	BCF        RX9_bit+0, BitPos(RX9_bit+0)
;rf_module_tx.c,21 :: 		TXEN_bit   = 0;        // Reset transmitter
	BCF        TXEN_bit+0, BitPos(TXEN_bit+0)
;rf_module_tx.c,22 :: 		TXEN_bit   = 1;        // Enable the transmitter
	BSF        TXEN_bit+0, BitPos(TXEN_bit+0)
;rf_module_tx.c,23 :: 		}
L_end_InitUART:
	RETURN
; end of _InitUART

_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;rf_module_tx.c,24 :: 		void interrupt(void)
;rf_module_tx.c,26 :: 		if(RCIF_bit==1 )  // If UART Rx Interrupt
	BTFSS      RCIF_bit+0, BitPos(RCIF_bit+0)
	GOTO       L_interrupt0
;rf_module_tx.c,28 :: 		if(OERR_bit ) // If over run error, then reset the receiver
	BTFSS      OERR_bit+0, BitPos(OERR_bit+0)
	GOTO       L_interrupt1
;rf_module_tx.c,30 :: 		CREN_bit  = 0;
	BCF        CREN_bit+0, BitPos(CREN_bit+0)
;rf_module_tx.c,31 :: 		CREN_bit  = 1;
	BSF        CREN_bit+0, BitPos(CREN_bit+0)
;rf_module_tx.c,32 :: 		}
L_interrupt1:
;rf_module_tx.c,33 :: 		rcv=RCREG;             // save the data in rcv
	MOVF       RCREG+0, 0
	MOVWF      _rcv+0
;rf_module_tx.c,35 :: 		}
L_interrupt0:
;rf_module_tx.c,36 :: 		}
L_end_interrupt:
L__interrupt23:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;rf_module_tx.c,37 :: 		void main(void)
;rf_module_tx.c,38 :: 		{TRISB=0b00100000;        //declared RB5_bit as input which is the uart RX pin
	MOVLW      32
	MOVWF      TRISB+0
;rf_module_tx.c,39 :: 		TRISA=0X00;
	CLRF       TRISA+0
;rf_module_tx.c,40 :: 		TRISC=0X00;
	CLRF       TRISC+0
;rf_module_tx.c,41 :: 		PORTC=0X00;
	CLRF       PORTC+0
;rf_module_tx.c,42 :: 		PORTB=0X00;
	CLRF       PORTB+0
;rf_module_tx.c,44 :: 		InitUART();        // Intialize UART
	CALL       _InitUART+0
;rf_module_tx.c,47 :: 		GIE_bit  = 1;       // Enable global interrupts
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
;rf_module_tx.c,48 :: 		PEIE_bit  = 1;         // Enable Peripheral Interrupts
	BSF        PEIE_bit+0, BitPos(PEIE_bit+0)
;rf_module_tx.c,50 :: 		while(1)          //here the mcu will only transmit "w" "a" "s" "d" "q" "e" "1" "2" and "f" for brake operation
L_main2:
;rf_module_tx.c,51 :: 		{   if(rcv==0x77)
	MOVF       _rcv+0, 0
	XORLW      119
	BTFSS      STATUS+0, 2
	GOTO       L_main4
;rf_module_tx.c,52 :: 		{rcv1=rcv;
	MOVF       _rcv+0, 0
	MOVWF      _rcv1+0
;rf_module_tx.c,53 :: 		TXREG=rcv1;
	MOVF       _rcv+0, 0
	MOVWF      TXREG+0
;rf_module_tx.c,55 :: 		}
	GOTO       L_main5
L_main4:
;rf_module_tx.c,56 :: 		else if (rcv==0x61)
	MOVF       _rcv+0, 0
	XORLW      97
	BTFSS      STATUS+0, 2
	GOTO       L_main6
;rf_module_tx.c,57 :: 		{rcv1=rcv;
	MOVF       _rcv+0, 0
	MOVWF      _rcv1+0
;rf_module_tx.c,58 :: 		TXREG=rcv1;
	MOVF       _rcv+0, 0
	MOVWF      TXREG+0
;rf_module_tx.c,60 :: 		}
	GOTO       L_main7
L_main6:
;rf_module_tx.c,61 :: 		else if (rcv==0x73)
	MOVF       _rcv+0, 0
	XORLW      115
	BTFSS      STATUS+0, 2
	GOTO       L_main8
;rf_module_tx.c,62 :: 		{rcv1=rcv;
	MOVF       _rcv+0, 0
	MOVWF      _rcv1+0
;rf_module_tx.c,63 :: 		TXREG=rcv1;
	MOVF       _rcv+0, 0
	MOVWF      TXREG+0
;rf_module_tx.c,65 :: 		}
	GOTO       L_main9
L_main8:
;rf_module_tx.c,66 :: 		else if (rcv==0x64)
	MOVF       _rcv+0, 0
	XORLW      100
	BTFSS      STATUS+0, 2
	GOTO       L_main10
;rf_module_tx.c,67 :: 		{rcv1=rcv;
	MOVF       _rcv+0, 0
	MOVWF      _rcv1+0
;rf_module_tx.c,68 :: 		TXREG=rcv1;
	MOVF       _rcv+0, 0
	MOVWF      TXREG+0
;rf_module_tx.c,70 :: 		}
	GOTO       L_main11
L_main10:
;rf_module_tx.c,71 :: 		else if (rcv==0x71)
	MOVF       _rcv+0, 0
	XORLW      113
	BTFSS      STATUS+0, 2
	GOTO       L_main12
;rf_module_tx.c,72 :: 		{rcv1=rcv;
	MOVF       _rcv+0, 0
	MOVWF      _rcv1+0
;rf_module_tx.c,73 :: 		TXREG=rcv1;
	MOVF       _rcv+0, 0
	MOVWF      TXREG+0
;rf_module_tx.c,75 :: 		}
	GOTO       L_main13
L_main12:
;rf_module_tx.c,76 :: 		else if (rcv==0x65)
	MOVF       _rcv+0, 0
	XORLW      101
	BTFSS      STATUS+0, 2
	GOTO       L_main14
;rf_module_tx.c,77 :: 		{rcv1=rcv;
	MOVF       _rcv+0, 0
	MOVWF      _rcv1+0
;rf_module_tx.c,78 :: 		TXREG=rcv1;
	MOVF       _rcv+0, 0
	MOVWF      TXREG+0
;rf_module_tx.c,80 :: 		}
	GOTO       L_main15
L_main14:
;rf_module_tx.c,81 :: 		else if (rcv==0x31)
	MOVF       _rcv+0, 0
	XORLW      49
	BTFSS      STATUS+0, 2
	GOTO       L_main16
;rf_module_tx.c,82 :: 		{rcv1=rcv;
	MOVF       _rcv+0, 0
	MOVWF      _rcv1+0
;rf_module_tx.c,83 :: 		TXREG=rcv1;
	MOVF       _rcv+0, 0
	MOVWF      TXREG+0
;rf_module_tx.c,85 :: 		}
	GOTO       L_main17
L_main16:
;rf_module_tx.c,86 :: 		else if (rcv==0x32)
	MOVF       _rcv+0, 0
	XORLW      50
	BTFSS      STATUS+0, 2
	GOTO       L_main18
;rf_module_tx.c,87 :: 		{rcv1=rcv;
	MOVF       _rcv+0, 0
	MOVWF      _rcv1+0
;rf_module_tx.c,88 :: 		TXREG=rcv1;
	MOVF       _rcv+0, 0
	MOVWF      TXREG+0
;rf_module_tx.c,90 :: 		}
	GOTO       L_main19
L_main18:
;rf_module_tx.c,91 :: 		else if (rcv==0x66)
	MOVF       _rcv+0, 0
	XORLW      102
	BTFSS      STATUS+0, 2
	GOTO       L_main20
;rf_module_tx.c,92 :: 		{rcv1=rcv;
	MOVF       _rcv+0, 0
	MOVWF      _rcv1+0
;rf_module_tx.c,93 :: 		TXREG=rcv1;
	MOVF       _rcv+0, 0
	MOVWF      TXREG+0
;rf_module_tx.c,95 :: 		}
L_main20:
L_main19:
L_main17:
L_main15:
L_main13:
L_main11:
L_main9:
L_main7:
L_main5:
;rf_module_tx.c,97 :: 		}
	GOTO       L_main2
;rf_module_tx.c,101 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
