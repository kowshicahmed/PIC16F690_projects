
_pwm_select:

;TIMER_2_MULTIPLE_PWM.c,12 :: 		void pwm_select(int a)
;TIMER_2_MULTIPLE_PWM.c,15 :: 		if(count==a)
	MOVF       _count+1, 0
	XORWF      FARG_pwm_select_a+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__pwm_select28
	MOVF       FARG_pwm_select_a+0, 0
	XORWF      _count+0, 0
L__pwm_select28:
	BTFSS      STATUS+0, 2
	GOTO       L_pwm_select0
;TIMER_2_MULTIPLE_PWM.c,17 :: 		pwm_value=1;
	MOVLW      1
	MOVWF      _pwm_value+0
	MOVLW      0
	MOVWF      _pwm_value+1
;TIMER_2_MULTIPLE_PWM.c,18 :: 		}
	GOTO       L_pwm_select1
L_pwm_select0:
;TIMER_2_MULTIPLE_PWM.c,19 :: 		else if(count==50)
	MOVLW      0
	XORWF      _count+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__pwm_select29
	MOVLW      50
	XORWF      _count+0, 0
L__pwm_select29:
	BTFSS      STATUS+0, 2
	GOTO       L_pwm_select2
;TIMER_2_MULTIPLE_PWM.c,20 :: 		{  pwm_value=2;
	MOVLW      2
	MOVWF      _pwm_value+0
	MOVLW      0
	MOVWF      _pwm_value+1
;TIMER_2_MULTIPLE_PWM.c,21 :: 		count=0;
	CLRF       _count+0
	CLRF       _count+1
;TIMER_2_MULTIPLE_PWM.c,22 :: 		}
	GOTO       L_pwm_select3
L_pwm_select2:
;TIMER_2_MULTIPLE_PWM.c,23 :: 		else{}
L_pwm_select3:
L_pwm_select1:
;TIMER_2_MULTIPLE_PWM.c,25 :: 		if (pwm_value==2)
	MOVLW      0
	XORWF      _pwm_value+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__pwm_select30
	MOVLW      2
	XORWF      _pwm_value+0, 0
L__pwm_select30:
	BTFSS      STATUS+0, 2
	GOTO       L_pwm_select4
;TIMER_2_MULTIPLE_PWM.c,27 :: 		RC7_bit=1;
	BSF        RC7_bit+0, 7
;TIMER_2_MULTIPLE_PWM.c,28 :: 		}
	GOTO       L_pwm_select5
L_pwm_select4:
;TIMER_2_MULTIPLE_PWM.c,29 :: 		else if (pwm_value==1)
	MOVLW      0
	XORWF      _pwm_value+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__pwm_select31
	MOVLW      1
	XORWF      _pwm_value+0, 0
L__pwm_select31:
	BTFSS      STATUS+0, 2
	GOTO       L_pwm_select6
;TIMER_2_MULTIPLE_PWM.c,31 :: 		RC7_bit=0;
	BCF        RC7_bit+0, 7
;TIMER_2_MULTIPLE_PWM.c,32 :: 		}
	GOTO       L_pwm_select7
L_pwm_select6:
;TIMER_2_MULTIPLE_PWM.c,33 :: 		else {}
L_pwm_select7:
L_pwm_select5:
;TIMER_2_MULTIPLE_PWM.c,38 :: 		}
	RETURN
; end of _pwm_select

_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;TIMER_2_MULTIPLE_PWM.c,40 :: 		void interrupt (void)
;TIMER_2_MULTIPLE_PWM.c,41 :: 		{if (TMR2IE_bit=1 && TMR2IF_bit==1)
	BTFSS      TMR2IF_bit+0, 1
	GOTO       L_interrupt9
	MOVLW      1
	MOVWF      R0+0
	GOTO       L_interrupt8
L_interrupt9:
	CLRF       R0+0
L_interrupt8:
	BTFSC      R0+0, 0
	GOTO       L__interrupt33
	BCF        TMR2IE_bit+0, 1
	GOTO       L__interrupt34
L__interrupt33:
	BSF        TMR2IE_bit+0, 1
L__interrupt34:
	BTFSS      TMR2IE_bit+0, 1
	GOTO       L_interrupt10
;TIMER_2_MULTIPLE_PWM.c,43 :: 		count++;
	INCF       _count+0, 1
	BTFSC      STATUS+0, 2
	INCF       _count+1, 1
;TIMER_2_MULTIPLE_PWM.c,47 :: 		TMR2IF_bit=0;
	BCF        TMR2IF_bit+0, 1
;TIMER_2_MULTIPLE_PWM.c,49 :: 		}
L_interrupt10:
;TIMER_2_MULTIPLE_PWM.c,50 :: 		}
L__interrupt32:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;TIMER_2_MULTIPLE_PWM.c,53 :: 		void main()
;TIMER_2_MULTIPLE_PWM.c,54 :: 		{   TRISA=0x07;
	MOVLW      7
	MOVWF      TRISA+0
;TIMER_2_MULTIPLE_PWM.c,55 :: 		TRISB=0x10;
	MOVLW      16
	MOVWF      TRISB+0
;TIMER_2_MULTIPLE_PWM.c,56 :: 		TRISC=0x00;
	CLRF       TRISC+0
;TIMER_2_MULTIPLE_PWM.c,57 :: 		ANSEL=0;
	CLRF       ANSEL+0
;TIMER_2_MULTIPLE_PWM.c,58 :: 		ANSELH=0;
	CLRF       ANSELH+0
;TIMER_2_MULTIPLE_PWM.c,59 :: 		CM1CON0=0;
	CLRF       CM1CON0+0
;TIMER_2_MULTIPLE_PWM.c,60 :: 		CM2CON0=0;
	CLRF       CM2CON0+0
;TIMER_2_MULTIPLE_PWM.c,62 :: 		C1ON_bit=0;
	BCF        C1ON_bit+0, 7
;TIMER_2_MULTIPLE_PWM.c,63 :: 		C2ON_bit=0;
	BCF        C2ON_bit+0, 7
;TIMER_2_MULTIPLE_PWM.c,65 :: 		RA4_bit=0;
	BCF        RA4_bit+0, 4
;TIMER_2_MULTIPLE_PWM.c,66 :: 		RA5_bit=0;
	BCF        RA5_bit+0, 5
;TIMER_2_MULTIPLE_PWM.c,71 :: 		PORTC=0X00;
	CLRF       PORTC+0
;TIMER_2_MULTIPLE_PWM.c,76 :: 		PEIE_bit=1; // ENABLE PERIPHERAL INTERRUPT
	BSF        PEIE_bit+0, 6
;TIMER_2_MULTIPLE_PWM.c,77 :: 		GIE_bit=1;   // ENABLE GLOBAL INTERRUPT
	BSF        GIE_bit+0, 7
;TIMER_2_MULTIPLE_PWM.c,81 :: 		T2CKPS1_bit=0;//  T2CON(BIT 1-T1CKPS1 AND BIT 0-T1CKPS0) IS SET TO 0 FOR A PRESCALAR 1:1
	BCF        T2CKPS1_bit+0, 1
;TIMER_2_MULTIPLE_PWM.c,82 :: 		T2CKPS0_bit=0;//
	BCF        T2CKPS0_bit+0, 0
;TIMER_2_MULTIPLE_PWM.c,84 :: 		TOUTPS3_bit=0;
	BCF        TOUTPS3_bit+0, 6
;TIMER_2_MULTIPLE_PWM.c,85 :: 		TOUTPS2_bit=0;   //  T2CON(BIT6 ,BIT 5,BIT 4, BIT3)  IS SET TO 0 FOR A POSTSCALAR 1:1
	BCF        TOUTPS2_bit+0, 5
;TIMER_2_MULTIPLE_PWM.c,86 :: 		TOUTPS1_bit=0;
	BCF        TOUTPS1_bit+0, 4
;TIMER_2_MULTIPLE_PWM.c,87 :: 		TOUTPS0_bit=0;
	BCF        TOUTPS0_bit+0, 3
;TIMER_2_MULTIPLE_PWM.c,89 :: 		TMR2IF_bit=0;   // TIMER1 INTERRUPT FLAG BIT INITIALLY SET TO 0 BEFORE ACTIVATING TIMER1 INTTERUPT ON NEXT LINE
	BCF        TMR2IF_bit+0, 1
;TIMER_2_MULTIPLE_PWM.c,90 :: 		TMR2IE_bit=1;  // ENABLE TIMER1 INTERRUPT ON OVERFLOW
	BSF        TMR2IE_bit+0, 1
;TIMER_2_MULTIPLE_PWM.c,94 :: 		PR2=200;      // SETTING VALUE OF PR2, THAT IS WHEN TIMER 2
	MOVLW      200
	MOVWF      PR2+0
;TIMER_2_MULTIPLE_PWM.c,96 :: 		TMR2ON_bit =1;
	BSF        TMR2ON_bit+0, 2
;TIMER_2_MULTIPLE_PWM.c,102 :: 		while (1)
L_main11:
;TIMER_2_MULTIPLE_PWM.c,105 :: 		if(RA0_bit==1 && RA1_bit==0 && RA2_bit==0 && RB4_bit==0)
	BTFSS      RA0_bit+0, 0
	GOTO       L_main15
	BTFSC      RA1_bit+0, 1
	GOTO       L_main15
	BTFSC      RA2_bit+0, 2
	GOTO       L_main15
	BTFSC      RB4_bit+0, 4
	GOTO       L_main15
L__main27:
;TIMER_2_MULTIPLE_PWM.c,107 :: 		pwm_select(38);
	MOVLW      38
	MOVWF      FARG_pwm_select_a+0
	MOVLW      0
	MOVWF      FARG_pwm_select_a+1
	CALL       _pwm_select+0
;TIMER_2_MULTIPLE_PWM.c,108 :: 		}
	GOTO       L_main16
L_main15:
;TIMER_2_MULTIPLE_PWM.c,110 :: 		else if(RA0_bit==0 && RA1_bit==1 && RA2_bit==0 && RB4_bit==0)
	BTFSC      RA0_bit+0, 0
	GOTO       L_main19
	BTFSS      RA1_bit+0, 1
	GOTO       L_main19
	BTFSC      RA2_bit+0, 2
	GOTO       L_main19
	BTFSC      RB4_bit+0, 4
	GOTO       L_main19
L__main26:
;TIMER_2_MULTIPLE_PWM.c,113 :: 		pwm_select(25);
	MOVLW      25
	MOVWF      FARG_pwm_select_a+0
	MOVLW      0
	MOVWF      FARG_pwm_select_a+1
	CALL       _pwm_select+0
;TIMER_2_MULTIPLE_PWM.c,115 :: 		}
	GOTO       L_main20
L_main19:
;TIMER_2_MULTIPLE_PWM.c,118 :: 		else if(RA0_bit==0 && RA1_bit==0 && RA2_bit==1 && RB4_bit==0)
	BTFSC      RA0_bit+0, 0
	GOTO       L_main23
	BTFSC      RA1_bit+0, 1
	GOTO       L_main23
	BTFSS      RA2_bit+0, 2
	GOTO       L_main23
	BTFSC      RB4_bit+0, 4
	GOTO       L_main23
L__main25:
;TIMER_2_MULTIPLE_PWM.c,121 :: 		pwm_select(13);
	MOVLW      13
	MOVWF      FARG_pwm_select_a+0
	MOVLW      0
	MOVWF      FARG_pwm_select_a+1
	CALL       _pwm_select+0
;TIMER_2_MULTIPLE_PWM.c,123 :: 		}
	GOTO       L_main24
L_main23:
;TIMER_2_MULTIPLE_PWM.c,126 :: 		else{count=0;RC7_bit=0;}
	CLRF       _count+0
	CLRF       _count+1
	BCF        RC7_bit+0, 7
L_main24:
L_main20:
L_main16:
;TIMER_2_MULTIPLE_PWM.c,132 :: 		}}
	GOTO       L_main11
	GOTO       $+0
; end of _main
