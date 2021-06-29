
_InitUART:

;MyProject.c,7 :: 		void InitUART(void)
;MyProject.c,8 :: 		{   ANSEL=0;                 // disable analog input
	CLRF       ANSEL+0
;MyProject.c,9 :: 		ANSELH=0;               // disable analog input
	CLRF       ANSELH+0
;MyProject.c,10 :: 		ANS11_bit =0;
	BCF        ANS11_bit+0, BitPos(ANS11_bit+0)
;MyProject.c,12 :: 		SPBRG = 103  ;         // selected 2400 baud-rate
	MOVLW      103
	MOVWF      SPBRG+0
;MyProject.c,13 :: 		BRGH_bit   = 1;        // RX Pin
	BSF        BRGH_bit+0, BitPos(BRGH_bit+0)
;MyProject.c,14 :: 		SYNC_bit =0;           // Asynchronous Operation
	BCF        SYNC_bit+0, BitPos(SYNC_bit+0)
;MyProject.c,15 :: 		SPEN_bit   = 1;        // Enable serial port pins
	BSF        SPEN_bit+0, BitPos(SPEN_bit+0)
;MyProject.c,16 :: 		CREN_bit   = 1;        // Enable reception
	BSF        CREN_bit+0, BitPos(CREN_bit+0)
;MyProject.c,17 :: 		SREN_bit   = 0;        // No effect
	BCF        SREN_bit+0, BitPos(SREN_bit+0)
;MyProject.c,18 :: 		TXIE_bit   = 0;        // Disable tx interrupts
	BCF        TXIE_bit+0, BitPos(TXIE_bit+0)
;MyProject.c,19 :: 		RCIE_bit   = 1;        // Enable rx interrupts
	BSF        RCIE_bit+0, BitPos(RCIE_bit+0)
;MyProject.c,20 :: 		TX9_bit    = 0;        // 8-bit transmission
	BCF        TX9_bit+0, BitPos(TX9_bit+0)
;MyProject.c,21 :: 		RX9_bit    = 0;        // 8-bit reception
	BCF        RX9_bit+0, BitPos(RX9_bit+0)
;MyProject.c,22 :: 		TXEN_bit   = 0;        // Reset transmitter
	BCF        TXEN_bit+0, BitPos(TXEN_bit+0)
;MyProject.c,23 :: 		TXEN_bit   = 1;        // Enable the transmitter
	BSF        TXEN_bit+0, BitPos(TXEN_bit+0)
;MyProject.c,24 :: 		}
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

;MyProject.c,25 :: 		void interrupt(void)
;MyProject.c,27 :: 		if(RCIF_bit==1 )  // If UART Rx Interrupt
	BTFSS      RCIF_bit+0, BitPos(RCIF_bit+0)
	GOTO       L_interrupt0
;MyProject.c,29 :: 		if(OERR_bit ) // If over run error, then reset the receiver
	BTFSS      OERR_bit+0, BitPos(OERR_bit+0)
	GOTO       L_interrupt1
;MyProject.c,31 :: 		CREN_bit  = 0;
	BCF        CREN_bit+0, BitPos(CREN_bit+0)
;MyProject.c,32 :: 		CREN_bit  = 1;
	BSF        CREN_bit+0, BitPos(CREN_bit+0)
;MyProject.c,33 :: 		}
L_interrupt1:
;MyProject.c,34 :: 		rcv=RCREG;             // save the data in rcv
	MOVF       RCREG+0, 0
	MOVWF      _rcv+0
;MyProject.c,35 :: 		if(rcv==0x77)           //filtering process
	MOVF       _rcv+0, 0
	XORLW      119
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt2
;MyProject.c,36 :: 		{rcv1=rcv;
	MOVF       _rcv+0, 0
	MOVWF      _rcv1+0
;MyProject.c,37 :: 		}
	GOTO       L_interrupt3
L_interrupt2:
;MyProject.c,38 :: 		else if (rcv==0x61)
	MOVF       _rcv+0, 0
	XORLW      97
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt4
;MyProject.c,39 :: 		{rcv1=rcv;
	MOVF       _rcv+0, 0
	MOVWF      _rcv1+0
;MyProject.c,40 :: 		}
	GOTO       L_interrupt5
L_interrupt4:
;MyProject.c,41 :: 		else if (rcv==0x73)
	MOVF       _rcv+0, 0
	XORLW      115
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt6
;MyProject.c,42 :: 		{rcv1=rcv;
	MOVF       _rcv+0, 0
	MOVWF      _rcv1+0
;MyProject.c,43 :: 		}
	GOTO       L_interrupt7
L_interrupt6:
;MyProject.c,44 :: 		else if (rcv==0x64)
	MOVF       _rcv+0, 0
	XORLW      100
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt8
;MyProject.c,45 :: 		{rcv1=rcv;
	MOVF       _rcv+0, 0
	MOVWF      _rcv1+0
;MyProject.c,46 :: 		}
	GOTO       L_interrupt9
L_interrupt8:
;MyProject.c,47 :: 		else if (rcv==0x71)
	MOVF       _rcv+0, 0
	XORLW      113
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt10
;MyProject.c,48 :: 		{rcv1=rcv;
	MOVF       _rcv+0, 0
	MOVWF      _rcv1+0
;MyProject.c,49 :: 		}
	GOTO       L_interrupt11
L_interrupt10:
;MyProject.c,50 :: 		else if (rcv==0x65)
	MOVF       _rcv+0, 0
	XORLW      101
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt12
;MyProject.c,51 :: 		{rcv1=rcv;
	MOVF       _rcv+0, 0
	MOVWF      _rcv1+0
;MyProject.c,52 :: 		}
	GOTO       L_interrupt13
L_interrupt12:
;MyProject.c,53 :: 		else if (rcv==0x31)
	MOVF       _rcv+0, 0
	XORLW      49
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt14
;MyProject.c,54 :: 		{rcv1=rcv;
	MOVF       _rcv+0, 0
	MOVWF      _rcv1+0
;MyProject.c,55 :: 		}
	GOTO       L_interrupt15
L_interrupt14:
;MyProject.c,56 :: 		else if (rcv==0x32)
	MOVF       _rcv+0, 0
	XORLW      50
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt16
;MyProject.c,57 :: 		{rcv1=rcv;
	MOVF       _rcv+0, 0
	MOVWF      _rcv1+0
;MyProject.c,58 :: 		}
	GOTO       L_interrupt17
L_interrupt16:
;MyProject.c,59 :: 		else if (rcv==0x66)
	MOVF       _rcv+0, 0
	XORLW      102
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt18
;MyProject.c,60 :: 		{rcv1=rcv;
	MOVF       _rcv+0, 0
	MOVWF      _rcv1+0
;MyProject.c,61 :: 		}
L_interrupt18:
L_interrupt17:
L_interrupt15:
L_interrupt13:
L_interrupt11:
L_interrupt9:
L_interrupt7:
L_interrupt5:
L_interrupt3:
;MyProject.c,63 :: 		}
L_interrupt0:
;MyProject.c,64 :: 		}
L_end_interrupt:
L__interrupt73:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;MyProject.c,65 :: 		void main(void)
;MyProject.c,66 :: 		{TRISB=0b00100000;        //declared RB5_bit as input which is the uart RX pin
	MOVLW      32
	MOVWF      TRISB+0
;MyProject.c,67 :: 		TRISA=0X00;
	CLRF       TRISA+0
;MyProject.c,68 :: 		TRISC=0X00;
	CLRF       TRISC+0
;MyProject.c,69 :: 		PORTC=0X00;
	CLRF       PORTC+0
;MyProject.c,70 :: 		PORTB=0X00;
	CLRF       PORTB+0
;MyProject.c,71 :: 		count=0;
	CLRF       _count+0
	CLRF       _count+1
;MyProject.c,72 :: 		count1=0;
	CLRF       _count1+0
	CLRF       _count1+1
;MyProject.c,74 :: 		InitUART();        // Intialize UART
	CALL       _InitUART+0
;MyProject.c,77 :: 		GIE_bit  = 1;       // Enable global interrupts
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
;MyProject.c,78 :: 		PEIE_bit  = 1;         // Enable Peripheral Interrupts
	BSF        PEIE_bit+0, BitPos(PEIE_bit+0)
;MyProject.c,80 :: 		while(1)
L_main19:
;MyProject.c,82 :: 		while(rcv1==0x00){
L_main21:
	MOVF       _rcv1+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main22
;MyProject.c,83 :: 		}
	GOTO       L_main21
L_main22:
;MyProject.c,84 :: 		if(rcv1==0x77){         //if rcv=w(0x77)
	MOVF       _rcv1+0, 0
	XORLW      119
	BTFSS      STATUS+0, 2
	GOTO       L_main23
;MyProject.c,85 :: 		PORTC=0b00000101;      //both motors will rotate in foreward direction
	MOVLW      5
	MOVWF      PORTC+0
;MyProject.c,87 :: 		}
	GOTO       L_main24
L_main23:
;MyProject.c,88 :: 		else if(rcv1==0x73){    //if rcv=s(0x73)
	MOVF       _rcv1+0, 0
	XORLW      115
	BTFSS      STATUS+0, 2
	GOTO       L_main25
;MyProject.c,89 :: 		PORTC=0b00001010;      //both motors will in backward direction
	MOVLW      10
	MOVWF      PORTC+0
;MyProject.c,90 :: 		}
	GOTO       L_main26
L_main25:
;MyProject.c,91 :: 		else if(rcv1==0x61){   //if rcv=a(0x61)
	MOVF       _rcv1+0, 0
	XORLW      97
	BTFSS      STATUS+0, 2
	GOTO       L_main27
;MyProject.c,92 :: 		PORTC=0b00000100;   //left motor will be stopped right motor will rotate foreward
	MOVLW      4
	MOVWF      PORTC+0
;MyProject.c,93 :: 		}
	GOTO       L_main28
L_main27:
;MyProject.c,94 :: 		else if(rcv1==0x64){   //if rcv=d(0x64)
	MOVF       _rcv1+0, 0
	XORLW      100
	BTFSS      STATUS+0, 2
	GOTO       L_main29
;MyProject.c,95 :: 		PORTC=0b00000001;     //right motor will be stopped left motor will rotate foreward
	MOVLW      1
	MOVWF      PORTC+0
;MyProject.c,96 :: 		}
	GOTO       L_main30
L_main29:
;MyProject.c,97 :: 		else if(rcv1==0x65){    //if rcv=e(0x65)
	MOVF       _rcv1+0, 0
	XORLW      101
	BTFSS      STATUS+0, 2
	GOTO       L_main31
;MyProject.c,98 :: 		PORTC=0b00100101;       //moving forward and digging
	MOVLW      37
	MOVWF      PORTC+0
;MyProject.c,99 :: 		}
	GOTO       L_main32
L_main31:
;MyProject.c,100 :: 		else if(rcv1==0x71){     //if rcv=q(0x671)
	MOVF       _rcv1+0, 0
	XORLW      113
	BTFSS      STATUS+0, 2
	GOTO       L_main33
;MyProject.c,101 :: 		PORTC=0b00100000;        //only digging
	MOVLW      32
	MOVWF      PORTC+0
;MyProject.c,102 :: 		}
	GOTO       L_main34
L_main33:
;MyProject.c,104 :: 		else if (rcv1==0x31 && count==0)     //if "1" is pressed the stepper will have half rotation in the front
	MOVF       _rcv1+0, 0
	XORLW      49
	BTFSS      STATUS+0, 2
	GOTO       L_main37
	MOVLW      0
	XORWF      _count+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main75
	MOVLW      0
	XORWF      _count+0, 0
L__main75:
	BTFSS      STATUS+0, 2
	GOTO       L_main37
L__main70:
;MyProject.c,109 :: 		PORTA=0b00000011;
	MOVLW      3
	MOVWF      PORTA+0
;MyProject.c,110 :: 		Delay_ms(1000);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main38:
	DECFSZ     R13+0, 1
	GOTO       L_main38
	DECFSZ     R12+0, 1
	GOTO       L_main38
	DECFSZ     R11+0, 1
	GOTO       L_main38
	NOP
	NOP
;MyProject.c,112 :: 		PORTA=0b00000010;
	MOVLW      2
	MOVWF      PORTA+0
;MyProject.c,113 :: 		Delay_ms(1000);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main39:
	DECFSZ     R13+0, 1
	GOTO       L_main39
	DECFSZ     R12+0, 1
	GOTO       L_main39
	DECFSZ     R11+0, 1
	GOTO       L_main39
	NOP
	NOP
;MyProject.c,114 :: 		PORTA=0b00000110;
	MOVLW      6
	MOVWF      PORTA+0
;MyProject.c,115 :: 		Delay_ms(1000);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main40:
	DECFSZ     R13+0, 1
	GOTO       L_main40
	DECFSZ     R12+0, 1
	GOTO       L_main40
	DECFSZ     R11+0, 1
	GOTO       L_main40
	NOP
	NOP
;MyProject.c,116 :: 		PORTA=0b00000100;
	MOVLW      4
	MOVWF      PORTA+0
;MyProject.c,117 :: 		Delay_ms(1000);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main41:
	DECFSZ     R13+0, 1
	GOTO       L_main41
	DECFSZ     R12+0, 1
	GOTO       L_main41
	DECFSZ     R11+0, 1
	GOTO       L_main41
	NOP
	NOP
;MyProject.c,118 :: 		rcv1=0x00;
	CLRF       _rcv1+0
;MyProject.c,119 :: 		count=1;
	MOVLW      1
	MOVWF      _count+0
	MOVLW      0
	MOVWF      _count+1
;MyProject.c,120 :: 		}
	GOTO       L_main42
L_main37:
;MyProject.c,121 :: 		else if(rcv1==0x31 && count==1)       //if "1" is pressed again the stepper will have another half rotation in the front
	MOVF       _rcv1+0, 0
	XORLW      49
	BTFSS      STATUS+0, 2
	GOTO       L_main45
	MOVLW      0
	XORWF      _count+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main76
	MOVLW      1
	XORWF      _count+0, 0
L__main76:
	BTFSS      STATUS+0, 2
	GOTO       L_main45
L__main69:
;MyProject.c,123 :: 		PORTA=0b00010100;
	MOVLW      20
	MOVWF      PORTA+0
;MyProject.c,124 :: 		Delay_ms(1000);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main46:
	DECFSZ     R13+0, 1
	GOTO       L_main46
	DECFSZ     R12+0, 1
	GOTO       L_main46
	DECFSZ     R11+0, 1
	GOTO       L_main46
	NOP
	NOP
;MyProject.c,126 :: 		PORTA=0b00010000;
	MOVLW      16
	MOVWF      PORTA+0
;MyProject.c,127 :: 		Delay_ms(1000);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main47:
	DECFSZ     R13+0, 1
	GOTO       L_main47
	DECFSZ     R12+0, 1
	GOTO       L_main47
	DECFSZ     R11+0, 1
	GOTO       L_main47
	NOP
	NOP
;MyProject.c,129 :: 		PORTA=0b00010001;
	MOVLW      17
	MOVWF      PORTA+0
;MyProject.c,130 :: 		Delay_ms(1000);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main48:
	DECFSZ     R13+0, 1
	GOTO       L_main48
	DECFSZ     R12+0, 1
	GOTO       L_main48
	DECFSZ     R11+0, 1
	GOTO       L_main48
	NOP
	NOP
;MyProject.c,131 :: 		PORTA=0b00000001;
	MOVLW      1
	MOVWF      PORTA+0
;MyProject.c,132 :: 		Delay_ms(1000);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main49:
	DECFSZ     R13+0, 1
	GOTO       L_main49
	DECFSZ     R12+0, 1
	GOTO       L_main49
	DECFSZ     R11+0, 1
	GOTO       L_main49
	NOP
	NOP
;MyProject.c,133 :: 		rcv1=0x00;
	CLRF       _rcv1+0
;MyProject.c,134 :: 		count=0;
	CLRF       _count+0
	CLRF       _count+1
;MyProject.c,136 :: 		}
	GOTO       L_main50
L_main45:
;MyProject.c,137 :: 		else if(rcv1==0x32 && count1==0)   //if "2" is pressed the stepper will have half rotation in the backward direction
	MOVF       _rcv1+0, 0
	XORLW      50
	BTFSS      STATUS+0, 2
	GOTO       L_main53
	MOVLW      0
	XORWF      _count1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main77
	MOVLW      0
	XORWF      _count1+0, 0
L__main77:
	BTFSS      STATUS+0, 2
	GOTO       L_main53
L__main68:
;MyProject.c,139 :: 		PORTA=0b00010001;
	MOVLW      17
	MOVWF      PORTA+0
;MyProject.c,140 :: 		Delay_ms(1000);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main54:
	DECFSZ     R13+0, 1
	GOTO       L_main54
	DECFSZ     R12+0, 1
	GOTO       L_main54
	DECFSZ     R11+0, 1
	GOTO       L_main54
	NOP
	NOP
;MyProject.c,141 :: 		PORTA=0b00010000;
	MOVLW      16
	MOVWF      PORTA+0
;MyProject.c,142 :: 		Delay_ms(1000);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main55:
	DECFSZ     R13+0, 1
	GOTO       L_main55
	DECFSZ     R12+0, 1
	GOTO       L_main55
	DECFSZ     R11+0, 1
	GOTO       L_main55
	NOP
	NOP
;MyProject.c,143 :: 		PORTA=0b00010100;
	MOVLW      20
	MOVWF      PORTA+0
;MyProject.c,144 :: 		Delay_ms(1000);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main56:
	DECFSZ     R13+0, 1
	GOTO       L_main56
	DECFSZ     R12+0, 1
	GOTO       L_main56
	DECFSZ     R11+0, 1
	GOTO       L_main56
	NOP
	NOP
;MyProject.c,145 :: 		PORTA=0b00000100;
	MOVLW      4
	MOVWF      PORTA+0
;MyProject.c,146 :: 		Delay_ms(1000);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main57:
	DECFSZ     R13+0, 1
	GOTO       L_main57
	DECFSZ     R12+0, 1
	GOTO       L_main57
	DECFSZ     R11+0, 1
	GOTO       L_main57
	NOP
	NOP
;MyProject.c,147 :: 		rcv1=0x00;
	CLRF       _rcv1+0
;MyProject.c,148 :: 		count1=1;
	MOVLW      1
	MOVWF      _count1+0
	MOVLW      0
	MOVWF      _count1+1
;MyProject.c,150 :: 		}
	GOTO       L_main58
L_main53:
;MyProject.c,151 :: 		else if(rcv1==0x32 && count1==1)     //if "2" is pressed again the stepper will have another half rotation in the backward direction
	MOVF       _rcv1+0, 0
	XORLW      50
	BTFSS      STATUS+0, 2
	GOTO       L_main61
	MOVLW      0
	XORWF      _count1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main78
	MOVLW      1
	XORWF      _count1+0, 0
L__main78:
	BTFSS      STATUS+0, 2
	GOTO       L_main61
L__main67:
;MyProject.c,153 :: 		PORTA=0b00000110;
	MOVLW      6
	MOVWF      PORTA+0
;MyProject.c,154 :: 		Delay_ms(1000);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main62:
	DECFSZ     R13+0, 1
	GOTO       L_main62
	DECFSZ     R12+0, 1
	GOTO       L_main62
	DECFSZ     R11+0, 1
	GOTO       L_main62
	NOP
	NOP
;MyProject.c,155 :: 		PORTA=0b00000010;
	MOVLW      2
	MOVWF      PORTA+0
;MyProject.c,156 :: 		Delay_ms(1000);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main63:
	DECFSZ     R13+0, 1
	GOTO       L_main63
	DECFSZ     R12+0, 1
	GOTO       L_main63
	DECFSZ     R11+0, 1
	GOTO       L_main63
	NOP
	NOP
;MyProject.c,157 :: 		PORTA=0b00000011;
	MOVLW      3
	MOVWF      PORTA+0
;MyProject.c,158 :: 		Delay_ms(1000);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main64:
	DECFSZ     R13+0, 1
	GOTO       L_main64
	DECFSZ     R12+0, 1
	GOTO       L_main64
	DECFSZ     R11+0, 1
	GOTO       L_main64
	NOP
	NOP
;MyProject.c,159 :: 		PORTA=0b00000001;
	MOVLW      1
	MOVWF      PORTA+0
;MyProject.c,160 :: 		Delay_ms(1000);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main65:
	DECFSZ     R13+0, 1
	GOTO       L_main65
	DECFSZ     R12+0, 1
	GOTO       L_main65
	DECFSZ     R11+0, 1
	GOTO       L_main65
	NOP
	NOP
;MyProject.c,161 :: 		rcv1=0x00;
	CLRF       _rcv1+0
;MyProject.c,162 :: 		count1=0;
	CLRF       _count1+0
	CLRF       _count1+1
;MyProject.c,163 :: 		}
	GOTO       L_main66
L_main61:
;MyProject.c,167 :: 		{PORTC=0x00;           //brake for any other button
	CLRF       PORTC+0
;MyProject.c,168 :: 		PORTA=0x00;
	CLRF       PORTA+0
;MyProject.c,169 :: 		}
L_main66:
L_main58:
L_main50:
L_main42:
L_main34:
L_main32:
L_main30:
L_main28:
L_main26:
L_main24:
;MyProject.c,170 :: 		rcv1=0x00;
	CLRF       _rcv1+0
;MyProject.c,173 :: 		}
	GOTO       L_main19
;MyProject.c,177 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
