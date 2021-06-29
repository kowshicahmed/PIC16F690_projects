
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;TIMER_1_SEC_MIN_7SEG.c,13 :: 		void interrupt (void)
;TIMER_1_SEC_MIN_7SEG.c,14 :: 		{if (TMR1IE_bit=1 && TMR1IF_bit==1)
	BTFSS      TMR1IF_bit+0, 0
	GOTO       L_interrupt1
	MOVLW      1
	MOVWF      R0+0
	GOTO       L_interrupt0
L_interrupt1:
	CLRF       R0+0
L_interrupt0:
	BTFSC      R0+0, 0
	GOTO       L__interrupt10
	BCF        TMR1IE_bit+0, 0
	GOTO       L__interrupt11
L__interrupt10:
	BSF        TMR1IE_bit+0, 0
L__interrupt11:
	BTFSS      TMR1IE_bit+0, 0
	GOTO       L_interrupt2
;TIMER_1_SEC_MIN_7SEG.c,15 :: 		{ count++;
	INCF       _count+0, 1
	BTFSC      STATUS+0, 2
	INCF       _count+1, 1
;TIMER_1_SEC_MIN_7SEG.c,16 :: 		TMR1IF_bit=0;
	BCF        TMR1IF_bit+0, 0
;TIMER_1_SEC_MIN_7SEG.c,18 :: 		TMR1H=0x3C;
	MOVLW      60
	MOVWF      TMR1H+0
;TIMER_1_SEC_MIN_7SEG.c,19 :: 		TMR1L=0xAF;
	MOVLW      175
	MOVWF      TMR1L+0
;TIMER_1_SEC_MIN_7SEG.c,20 :: 		}
L_interrupt2:
;TIMER_1_SEC_MIN_7SEG.c,21 :: 		}
L__interrupt9:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;TIMER_1_SEC_MIN_7SEG.c,24 :: 		void main()
;TIMER_1_SEC_MIN_7SEG.c,25 :: 		{   TRISA=0x00;
	CLRF       TRISA+0
;TIMER_1_SEC_MIN_7SEG.c,26 :: 		TRISB=0x00;
	CLRF       TRISB+0
;TIMER_1_SEC_MIN_7SEG.c,27 :: 		TRISC=0x00;
	CLRF       TRISC+0
;TIMER_1_SEC_MIN_7SEG.c,28 :: 		ANSEL=0;
	CLRF       ANSEL+0
;TIMER_1_SEC_MIN_7SEG.c,29 :: 		ANSELH=0;
	CLRF       ANSELH+0
;TIMER_1_SEC_MIN_7SEG.c,32 :: 		PEIE_bit=1; // ENABLE PERIPHERAL INTERRUPT
	BSF        PEIE_bit+0, 6
;TIMER_1_SEC_MIN_7SEG.c,33 :: 		GIE_bit=1;   // ENABLE GLOBAL INTERRUPT
	BSF        GIE_bit+0, 7
;TIMER_1_SEC_MIN_7SEG.c,35 :: 		TMR1GE_bit=0;  // IF TMR1ON IS HIGH,TIMER1 IS ON,
	BCF        TMR1GE_bit+0, 6
;TIMER_1_SEC_MIN_7SEG.c,37 :: 		T1CKPS1_bit=0;//  T1CON(BIT 5,T1CKPS1 AND BIT4,T1CKPS0) IS SET TO 0 FOR A PRESCALAR 1:1
	BCF        T1CKPS1_bit+0, 5
;TIMER_1_SEC_MIN_7SEG.c,38 :: 		T1CKPS0_bit=0;//
	BCF        T1CKPS0_bit+0, 4
;TIMER_1_SEC_MIN_7SEG.c,40 :: 		TMR1IF_bit=0;   // TIMER1 INTERRUPT FLAG BIT INITIALLY SET TO 0 BEFORE ACTIVATING TIMER1 INTTERUPT ON NEXT LINE
	BCF        TMR1IF_bit+0, 0
;TIMER_1_SEC_MIN_7SEG.c,41 :: 		TMR1IE_bit=1;  // ENABLE TIMER1 INTERRUPT ON OVERFLOW
	BSF        TMR1IE_bit+0, 0
;TIMER_1_SEC_MIN_7SEG.c,43 :: 		TMR1CS_bit=0;  // INTERNAL CLOCK (FOSC/4)
	BCF        TMR1CS_bit+0, 1
;TIMER_1_SEC_MIN_7SEG.c,45 :: 		TMR1H=0x3C;  // REGISTER VALUE OF TIMER1
	MOVLW      60
	MOVWF      TMR1H+0
;TIMER_1_SEC_MIN_7SEG.c,46 :: 		TMR1L=0xAF;
	MOVLW      175
	MOVWF      TMR1L+0
;TIMER_1_SEC_MIN_7SEG.c,48 :: 		PORTB=0X00;
	CLRF       PORTB+0
;TIMER_1_SEC_MIN_7SEG.c,49 :: 		PORTA=0X00;
	CLRF       PORTA+0
;TIMER_1_SEC_MIN_7SEG.c,50 :: 		PORTC=0X00;
	CLRF       PORTC+0
;TIMER_1_SEC_MIN_7SEG.c,51 :: 		RA5_bit=0    ;
	BCF        RA5_bit+0, 5
;TIMER_1_SEC_MIN_7SEG.c,55 :: 		while (1)
L_main3:
;TIMER_1_SEC_MIN_7SEG.c,58 :: 		TMR1ON_bit =1;
	BSF        TMR1ON_bit+0, 0
;TIMER_1_SEC_MIN_7SEG.c,59 :: 		if (count==20)
	MOVLW      0
	XORWF      _count+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main12
	MOVLW      20
	XORWF      _count+0, 0
L__main12:
	BTFSS      STATUS+0, 2
	GOTO       L_main5
;TIMER_1_SEC_MIN_7SEG.c,61 :: 		sec=(sec+1);
	INCF       _sec+0, 1
	BTFSC      STATUS+0, 2
	INCF       _sec+1, 1
;TIMER_1_SEC_MIN_7SEG.c,62 :: 		count=0;
	CLRF       _count+0
	CLRF       _count+1
;TIMER_1_SEC_MIN_7SEG.c,63 :: 		sec_7seg_MSB=sec/10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _sec+0, 0
	MOVWF      R0+0
	MOVF       _sec+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      _sec_7seg_MSB+0
	MOVF       R0+1, 0
	MOVWF      _sec_7seg_MSB+1
;TIMER_1_SEC_MIN_7SEG.c,64 :: 		sec_7seg_LSB=sec%10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _sec+0, 0
	MOVWF      R0+0
	MOVF       _sec+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      _sec_7seg_LSB+0
	MOVF       R0+1, 0
	MOVWF      _sec_7seg_LSB+1
;TIMER_1_SEC_MIN_7SEG.c,65 :: 		PORTC= (sec_7seg_MSB<<4)+ sec_7seg_LSB;
	MOVLW      4
	MOVWF      R3+0
	MOVF       _sec_7seg_MSB+0, 0
	MOVWF      R2+0
	MOVF       R3+0, 0
L__main13:
	BTFSC      STATUS+0, 2
	GOTO       L__main14
	RLF        R2+0, 1
	BCF        R2+0, 0
	ADDLW      255
	GOTO       L__main13
L__main14:
	MOVF       R0+0, 0
	ADDWF      R2+0, 0
	MOVWF      PORTC+0
;TIMER_1_SEC_MIN_7SEG.c,67 :: 		if (sec==60)
	MOVLW      0
	XORWF      _sec+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main15
	MOVLW      60
	XORWF      _sec+0, 0
L__main15:
	BTFSS      STATUS+0, 2
	GOTO       L_main6
;TIMER_1_SEC_MIN_7SEG.c,69 :: 		sec=0;
	CLRF       _sec+0
	CLRF       _sec+1
;TIMER_1_SEC_MIN_7SEG.c,70 :: 		minute=( minute+1);
	INCF       _minute+0, 1
	BTFSC      STATUS+0, 2
	INCF       _minute+1, 1
;TIMER_1_SEC_MIN_7SEG.c,72 :: 		min_7seg_LSB_MSB[0]= minute/10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _minute+0, 0
	MOVWF      R0+0
	MOVF       _minute+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      _min_7seg_LSB_MSB+0
;TIMER_1_SEC_MIN_7SEG.c,73 :: 		min_7seg_LSB_MSB[1]= minute%10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _minute+0, 0
	MOVWF      R0+0
	MOVF       _minute+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      _min_7seg_LSB_MSB+1
;TIMER_1_SEC_MIN_7SEG.c,75 :: 		PORTB=(min_7seg_LSB_MSB[0]<<4) +0 ;
	MOVF       _min_7seg_LSB_MSB+0, 0
	MOVWF      R2+0
	RLF        R2+0, 1
	BCF        R2+0, 0
	RLF        R2+0, 1
	BCF        R2+0, 0
	RLF        R2+0, 1
	BCF        R2+0, 0
	RLF        R2+0, 1
	BCF        R2+0, 0
	MOVF       R2+0, 0
	MOVWF      PORTB+0
;TIMER_1_SEC_MIN_7SEG.c,77 :: 		RA0_bit= min_7seg_LSB_MSB[1];
	BTFSC      R0+0, 0
	GOTO       L__main16
	BCF        RA0_bit+0, 0
	GOTO       L__main17
L__main16:
	BSF        RA0_bit+0, 0
L__main17:
;TIMER_1_SEC_MIN_7SEG.c,78 :: 		RA1_bit= min_7seg_LSB_MSB[1]>>1;
	MOVF       R0+0, 0
	MOVWF      R2+0
	RRF        R2+0, 1
	BCF        R2+0, 7
	BTFSC      R2+0, 0
	GOTO       L__main18
	BCF        RA1_bit+0, 1
	GOTO       L__main19
L__main18:
	BSF        RA1_bit+0, 1
L__main19:
;TIMER_1_SEC_MIN_7SEG.c,79 :: 		RA2_bit= min_7seg_LSB_MSB[1]>>2;
	MOVF       R0+0, 0
	MOVWF      R2+0
	RRF        R2+0, 1
	BCF        R2+0, 7
	RRF        R2+0, 1
	BCF        R2+0, 7
	BTFSC      R2+0, 0
	GOTO       L__main20
	BCF        RA2_bit+0, 2
	GOTO       L__main21
L__main20:
	BSF        RA2_bit+0, 2
L__main21:
;TIMER_1_SEC_MIN_7SEG.c,80 :: 		RA5_bit= min_7seg_LSB_MSB[1]>>3;
	MOVLW      3
	MOVWF      R3+0
	MOVF       R0+0, 0
	MOVWF      R2+0
	MOVF       R3+0, 0
L__main22:
	BTFSC      STATUS+0, 2
	GOTO       L__main23
	RRF        R2+0, 1
	BCF        R2+0, 7
	ADDLW      255
	GOTO       L__main22
L__main23:
	BTFSC      R2+0, 0
	GOTO       L__main24
	BCF        RA5_bit+0, 5
	GOTO       L__main25
L__main24:
	BSF        RA5_bit+0, 5
L__main25:
;TIMER_1_SEC_MIN_7SEG.c,83 :: 		if(minute==60)
	MOVLW      0
	XORWF      _minute+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main26
	MOVLW      60
	XORWF      _minute+0, 0
L__main26:
	BTFSS      STATUS+0, 2
	GOTO       L_main7
;TIMER_1_SEC_MIN_7SEG.c,86 :: 		hour=(hour+1);
	INCF       _hour+0, 1
	BTFSC      STATUS+0, 2
	INCF       _hour+1, 1
;TIMER_1_SEC_MIN_7SEG.c,88 :: 		if (hour==12)
	MOVLW      0
	XORWF      _hour+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main27
	MOVLW      12
	XORWF      _hour+0, 0
L__main27:
	BTFSS      STATUS+0, 2
	GOTO       L_main8
;TIMER_1_SEC_MIN_7SEG.c,90 :: 		hour=0;
	CLRF       _hour+0
	CLRF       _hour+1
;TIMER_1_SEC_MIN_7SEG.c,91 :: 		}
L_main8:
;TIMER_1_SEC_MIN_7SEG.c,92 :: 		}
L_main7:
;TIMER_1_SEC_MIN_7SEG.c,93 :: 		}
L_main6:
;TIMER_1_SEC_MIN_7SEG.c,94 :: 		}
L_main5:
;TIMER_1_SEC_MIN_7SEG.c,97 :: 		}
	GOTO       L_main3
;TIMER_1_SEC_MIN_7SEG.c,98 :: 		}
	GOTO       $+0
; end of _main
