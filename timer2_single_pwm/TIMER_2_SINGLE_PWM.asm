
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;TIMER_2_SINGLE_PWM.c,19 :: 		void interrupt (void)
;TIMER_2_SINGLE_PWM.c,20 :: 		{if (TMR2IE_bit=1 && TMR2IF_bit==1)
	BTFSS      TMR2IF_bit+0, 1
	GOTO       L_interrupt1
	MOVLW      1
	MOVWF      R0+0
	GOTO       L_interrupt0
L_interrupt1:
	CLRF       R0+0
L_interrupt0:
	BTFSC      R0+0, 0
	GOTO       L__interrupt8
	BCF        TMR2IE_bit+0, 1
	GOTO       L__interrupt9
L__interrupt8:
	BSF        TMR2IE_bit+0, 1
L__interrupt9:
	BTFSS      TMR2IE_bit+0, 1
	GOTO       L_interrupt2
;TIMER_2_SINGLE_PWM.c,22 :: 		count++;
	INCF       _count+0, 1
	BTFSC      STATUS+0, 2
	INCF       _count+1, 1
;TIMER_2_SINGLE_PWM.c,26 :: 		TMR2IF_bit=0;
	BCF        TMR2IF_bit+0, 1
;TIMER_2_SINGLE_PWM.c,28 :: 		}
L_interrupt2:
;TIMER_2_SINGLE_PWM.c,29 :: 		}
L__interrupt7:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;TIMER_2_SINGLE_PWM.c,32 :: 		void main()
;TIMER_2_SINGLE_PWM.c,33 :: 		{   TRISA=0x00;
	CLRF       TRISA+0
;TIMER_2_SINGLE_PWM.c,34 :: 		TRISB=0x00;
	CLRF       TRISB+0
;TIMER_2_SINGLE_PWM.c,35 :: 		TRISC=0x00;
	CLRF       TRISC+0
;TIMER_2_SINGLE_PWM.c,36 :: 		ANSEL=0;
	CLRF       ANSEL+0
;TIMER_2_SINGLE_PWM.c,37 :: 		ANSELH=0;
	CLRF       ANSELH+0
;TIMER_2_SINGLE_PWM.c,39 :: 		PORTA=0X00;
	CLRF       PORTA+0
;TIMER_2_SINGLE_PWM.c,40 :: 		PORTB=0X00;
	CLRF       PORTB+0
;TIMER_2_SINGLE_PWM.c,41 :: 		PORTC=0X00;
	CLRF       PORTC+0
;TIMER_2_SINGLE_PWM.c,44 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;TIMER_2_SINGLE_PWM.c,45 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;TIMER_2_SINGLE_PWM.c,46 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;TIMER_2_SINGLE_PWM.c,49 :: 		PEIE_bit=1; // ENABLE PERIPHERAL INTERRUPT
	BSF        PEIE_bit+0, 6
;TIMER_2_SINGLE_PWM.c,50 :: 		GIE_bit=1;   // ENABLE GLOBAL INTERRUPT
	BSF        GIE_bit+0, 7
;TIMER_2_SINGLE_PWM.c,54 :: 		T2CKPS1_bit=0;//  T2CON(BIT 1-T1CKPS1 AND BIT 0-T1CKPS0) IS SET TO 0 FOR A PRESCALAR 1:1
	BCF        T2CKPS1_bit+0, 1
;TIMER_2_SINGLE_PWM.c,55 :: 		T2CKPS0_bit=0;//
	BCF        T2CKPS0_bit+0, 0
;TIMER_2_SINGLE_PWM.c,57 :: 		TOUTPS3_bit=0;
	BCF        TOUTPS3_bit+0, 6
;TIMER_2_SINGLE_PWM.c,58 :: 		TOUTPS2_bit=0;   //  T2CON(BIT6 ,BIT 5,BIT 4, BIT3)  IS SET TO 0 FOR A POSTSCALAR 1:1
	BCF        TOUTPS2_bit+0, 5
;TIMER_2_SINGLE_PWM.c,59 :: 		TOUTPS1_bit=0;
	BCF        TOUTPS1_bit+0, 4
;TIMER_2_SINGLE_PWM.c,60 :: 		TOUTPS0_bit=0;
	BCF        TOUTPS0_bit+0, 3
;TIMER_2_SINGLE_PWM.c,62 :: 		TMR2IF_bit=0;   // TIMER1 INTERRUPT FLAG BIT INITIALLY SET TO 0 BEFORE ACTIVATING TIMER1 INTTERUPT ON NEXT LINE
	BCF        TMR2IF_bit+0, 1
;TIMER_2_SINGLE_PWM.c,63 :: 		TMR2IE_bit=1;  // ENABLE TIMER1 INTERRUPT ON OVERFLOW
	BSF        TMR2IE_bit+0, 1
;TIMER_2_SINGLE_PWM.c,67 :: 		PR2=200;      // SETTING VALUE OF PR2, THAT IS WHEN TIMER 2
	MOVLW      200
	MOVWF      PR2+0
;TIMER_2_SINGLE_PWM.c,72 :: 		TMR2ON_bit =1;
	BSF        TMR2ON_bit+0, 2
;TIMER_2_SINGLE_PWM.c,75 :: 		while (1)
L_main3:
;TIMER_2_SINGLE_PWM.c,79 :: 		if(count==25)
	MOVLW      0
	XORWF      _count+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main10
	MOVLW      25
	XORWF      _count+0, 0
L__main10:
	BTFSS      STATUS+0, 2
	GOTO       L_main5
;TIMER_2_SINGLE_PWM.c,80 :: 		{   RC7_bit=~RC7_bit;
	MOVLW      128
	XORWF      RC7_bit+0, 1
;TIMER_2_SINGLE_PWM.c,83 :: 		count=0;
	CLRF       _count+0
	CLRF       _count+1
;TIMER_2_SINGLE_PWM.c,84 :: 		}
	GOTO       L_main6
L_main5:
;TIMER_2_SINGLE_PWM.c,85 :: 		else{}
L_main6:
;TIMER_2_SINGLE_PWM.c,88 :: 		}}
	GOTO       L_main3
	GOTO       $+0
; end of _main
