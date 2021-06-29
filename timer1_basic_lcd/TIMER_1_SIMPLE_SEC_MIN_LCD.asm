
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;TIMER_1_SIMPLE_SEC_MIN_LCD.c,28 :: 		void interrupt (void)
;TIMER_1_SIMPLE_SEC_MIN_LCD.c,29 :: 		{if (TMR1IE_bit=1 && TMR1IF_bit==1)
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
;TIMER_1_SIMPLE_SEC_MIN_LCD.c,30 :: 		{ count++;
	INCF       _count+0, 1
	BTFSC      STATUS+0, 2
	INCF       _count+1, 1
;TIMER_1_SIMPLE_SEC_MIN_LCD.c,31 :: 		TMR1IF_bit=0;
	BCF        TMR1IF_bit+0, 0
;TIMER_1_SIMPLE_SEC_MIN_LCD.c,33 :: 		TMR1H=0x3C;
	MOVLW      60
	MOVWF      TMR1H+0
;TIMER_1_SIMPLE_SEC_MIN_LCD.c,34 :: 		TMR1L=0xAF;
	MOVLW      175
	MOVWF      TMR1L+0
;TIMER_1_SIMPLE_SEC_MIN_LCD.c,35 :: 		}
L_interrupt2:
;TIMER_1_SIMPLE_SEC_MIN_LCD.c,36 :: 		}
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

;TIMER_1_SIMPLE_SEC_MIN_LCD.c,39 :: 		void main()
;TIMER_1_SIMPLE_SEC_MIN_LCD.c,40 :: 		{   TRISA=0x00;
	CLRF       TRISA+0
;TIMER_1_SIMPLE_SEC_MIN_LCD.c,41 :: 		TRISB=0x00;
	CLRF       TRISB+0
;TIMER_1_SIMPLE_SEC_MIN_LCD.c,42 :: 		TRISC=0x00;
	CLRF       TRISC+0
;TIMER_1_SIMPLE_SEC_MIN_LCD.c,43 :: 		ANSEL=0;
	CLRF       ANSEL+0
;TIMER_1_SIMPLE_SEC_MIN_LCD.c,44 :: 		ANSELH=0;
	CLRF       ANSELH+0
;TIMER_1_SIMPLE_SEC_MIN_LCD.c,47 :: 		PORTB=0X00;
	CLRF       PORTB+0
;TIMER_1_SIMPLE_SEC_MIN_LCD.c,48 :: 		PORTA=0X00;
	CLRF       PORTA+0
;TIMER_1_SIMPLE_SEC_MIN_LCD.c,49 :: 		PORTC=0X00;
	CLRF       PORTC+0
;TIMER_1_SIMPLE_SEC_MIN_LCD.c,50 :: 		RA5_bit=0    ;
	BCF        RA5_bit+0, 5
;TIMER_1_SIMPLE_SEC_MIN_LCD.c,52 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;TIMER_1_SIMPLE_SEC_MIN_LCD.c,53 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;TIMER_1_SIMPLE_SEC_MIN_LCD.c,54 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;TIMER_1_SIMPLE_SEC_MIN_LCD.c,55 :: 		Lcd_Out(1,4,"00:00:00");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      4
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_TIMER_1_SIMPLE_SEC_MIN_LCD+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;TIMER_1_SIMPLE_SEC_MIN_LCD.c,56 :: 		Lcd_Out(2,2,"24 HOUR CLOCK");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_TIMER_1_SIMPLE_SEC_MIN_LCD+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;TIMER_1_SIMPLE_SEC_MIN_LCD.c,60 :: 		PEIE_bit=1; // ENABLE PERIPHERAL INTERRUPT
	BSF        PEIE_bit+0, 6
;TIMER_1_SIMPLE_SEC_MIN_LCD.c,61 :: 		GIE_bit=1;   // ENABLE GLOBAL INTERRUPT
	BSF        GIE_bit+0, 7
;TIMER_1_SIMPLE_SEC_MIN_LCD.c,63 :: 		TMR1GE_bit=0;  // IF TMR1ON IS HIGH,TIMER1 IS ON,
	BCF        TMR1GE_bit+0, 6
;TIMER_1_SIMPLE_SEC_MIN_LCD.c,65 :: 		T1CKPS1_bit=0;//  T1CON(BIT 5,T1CKPS1 AND BIT4,T1CKPS0) IS SET TO 0 FOR A PRESCALAR 1:1
	BCF        T1CKPS1_bit+0, 5
;TIMER_1_SIMPLE_SEC_MIN_LCD.c,66 :: 		T1CKPS0_bit=0;//
	BCF        T1CKPS0_bit+0, 4
;TIMER_1_SIMPLE_SEC_MIN_LCD.c,68 :: 		TMR1IF_bit=0;   // TIMER1 INTERRUPT FLAG BIT INITIALLY SET TO 0 BEFORE ACTIVATING TIMER1 INTTERUPT ON NEXT LINE
	BCF        TMR1IF_bit+0, 0
;TIMER_1_SIMPLE_SEC_MIN_LCD.c,69 :: 		TMR1IE_bit=1;  // ENABLE TIMER1 INTERRUPT ON OVERFLOW
	BSF        TMR1IE_bit+0, 0
;TIMER_1_SIMPLE_SEC_MIN_LCD.c,71 :: 		TMR1CS_bit=0;  // INTERNAL CLOCK (FOSC/4)
	BCF        TMR1CS_bit+0, 1
;TIMER_1_SIMPLE_SEC_MIN_LCD.c,73 :: 		TMR1H=0x3C;  // REGISTER VALUE OF TIMER1
	MOVLW      60
	MOVWF      TMR1H+0
;TIMER_1_SIMPLE_SEC_MIN_LCD.c,74 :: 		TMR1L=0xAF;
	MOVLW      175
	MOVWF      TMR1L+0
;TIMER_1_SIMPLE_SEC_MIN_LCD.c,79 :: 		while (1)
L_main3:
;TIMER_1_SIMPLE_SEC_MIN_LCD.c,82 :: 		TMR1ON_bit =1;
	BSF        TMR1ON_bit+0, 0
;TIMER_1_SIMPLE_SEC_MIN_LCD.c,83 :: 		if (count==20)
	MOVLW      0
	XORWF      _count+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main12
	MOVLW      20
	XORWF      _count+0, 0
L__main12:
	BTFSS      STATUS+0, 2
	GOTO       L_main5
;TIMER_1_SIMPLE_SEC_MIN_LCD.c,85 :: 		sec=(sec+1);
	INCF       _sec+0, 1
	BTFSC      STATUS+0, 2
	INCF       _sec+1, 1
;TIMER_1_SIMPLE_SEC_MIN_LCD.c,86 :: 		count=0;
	CLRF       _count+0
	CLRF       _count+1
;TIMER_1_SIMPLE_SEC_MIN_LCD.c,87 :: 		sec_7seg_MSB=sec/10;
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
;TIMER_1_SIMPLE_SEC_MIN_LCD.c,88 :: 		sec_7seg_LSB=sec%10;
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
;TIMER_1_SIMPLE_SEC_MIN_LCD.c,90 :: 		Lcd_Chr(1,10,(sec_7seg_MSB+48));
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      10
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      48
	ADDWF      _sec_7seg_MSB+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;TIMER_1_SIMPLE_SEC_MIN_LCD.c,91 :: 		Lcd_Chr_Cp((sec_7seg_LSB+48));
	MOVLW      48
	ADDWF      _sec_7seg_LSB+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;TIMER_1_SIMPLE_SEC_MIN_LCD.c,95 :: 		if (sec==60)
	MOVLW      0
	XORWF      _sec+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main13
	MOVLW      60
	XORWF      _sec+0, 0
L__main13:
	BTFSS      STATUS+0, 2
	GOTO       L_main6
;TIMER_1_SIMPLE_SEC_MIN_LCD.c,97 :: 		sec=0;
	CLRF       _sec+0
	CLRF       _sec+1
;TIMER_1_SIMPLE_SEC_MIN_LCD.c,98 :: 		minute=( minute+1);
	INCF       _minute+0, 1
	BTFSC      STATUS+0, 2
	INCF       _minute+1, 1
;TIMER_1_SIMPLE_SEC_MIN_LCD.c,100 :: 		min_7seg_LSB_MSB[1]= minute/10;
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
	MOVWF      _min_7seg_LSB_MSB+1
;TIMER_1_SIMPLE_SEC_MIN_LCD.c,101 :: 		min_7seg_LSB_MSB[0]= minute%10;
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
	MOVWF      _min_7seg_LSB_MSB+0
;TIMER_1_SIMPLE_SEC_MIN_LCD.c,103 :: 		Lcd_Chr(1,7,(min_7seg_LSB_MSB[1]+48));
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      7
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      48
	ADDWF      _min_7seg_LSB_MSB+1, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;TIMER_1_SIMPLE_SEC_MIN_LCD.c,104 :: 		Lcd_Chr_Cp((min_7seg_LSB_MSB[0]+48));
	MOVLW      48
	ADDWF      _min_7seg_LSB_MSB+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;TIMER_1_SIMPLE_SEC_MIN_LCD.c,106 :: 		if(minute==60)
	MOVLW      0
	XORWF      _minute+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main14
	MOVLW      60
	XORWF      _minute+0, 0
L__main14:
	BTFSS      STATUS+0, 2
	GOTO       L_main7
;TIMER_1_SIMPLE_SEC_MIN_LCD.c,109 :: 		hour=(hour+1);
	INCF       _hour+0, 1
	BTFSC      STATUS+0, 2
	INCF       _hour+1, 1
;TIMER_1_SIMPLE_SEC_MIN_LCD.c,111 :: 		hour_7seg_LSB_MSB[1]= hour/10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _hour+0, 0
	MOVWF      R0+0
	MOVF       _hour+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      _hour_7seg_LSB_MSB+1
;TIMER_1_SIMPLE_SEC_MIN_LCD.c,112 :: 		hour_7seg_LSB_MSB[0]= hour%10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _hour+0, 0
	MOVWF      R0+0
	MOVF       _hour+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      _hour_7seg_LSB_MSB+0
;TIMER_1_SIMPLE_SEC_MIN_LCD.c,114 :: 		Lcd_Chr(1,4,(hour_7seg_LSB_MSB[1]+48));
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      4
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      48
	ADDWF      _hour_7seg_LSB_MSB+1, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;TIMER_1_SIMPLE_SEC_MIN_LCD.c,115 :: 		Lcd_Chr_Cp((hour_7seg_LSB_MSB[0]+48));
	MOVLW      48
	ADDWF      _hour_7seg_LSB_MSB+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;TIMER_1_SIMPLE_SEC_MIN_LCD.c,117 :: 		if (hour==12)
	MOVLW      0
	XORWF      _hour+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main15
	MOVLW      12
	XORWF      _hour+0, 0
L__main15:
	BTFSS      STATUS+0, 2
	GOTO       L_main8
;TIMER_1_SIMPLE_SEC_MIN_LCD.c,119 :: 		hour=0;
	CLRF       _hour+0
	CLRF       _hour+1
;TIMER_1_SIMPLE_SEC_MIN_LCD.c,120 :: 		}
L_main8:
;TIMER_1_SIMPLE_SEC_MIN_LCD.c,121 :: 		}
L_main7:
;TIMER_1_SIMPLE_SEC_MIN_LCD.c,122 :: 		}
L_main6:
;TIMER_1_SIMPLE_SEC_MIN_LCD.c,123 :: 		}
L_main5:
;TIMER_1_SIMPLE_SEC_MIN_LCD.c,126 :: 		}
	GOTO       L_main3
;TIMER_1_SIMPLE_SEC_MIN_LCD.c,127 :: 		}
	GOTO       $+0
; end of _main
