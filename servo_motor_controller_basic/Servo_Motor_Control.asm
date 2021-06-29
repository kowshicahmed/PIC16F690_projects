
_main:

;Servo_Motor_Control.c,3 :: 		void main() {
;Servo_Motor_Control.c,5 :: 		TRISA = 0x04;
	MOVLW      4
	MOVWF      TRISA+0
;Servo_Motor_Control.c,6 :: 		TRISB=0X00;
	CLRF       TRISB+0
;Servo_Motor_Control.c,7 :: 		TRISC=0X00;
	CLRF       TRISC+0
;Servo_Motor_Control.c,8 :: 		ANSEL  = 0;                         // Configure AN pins as digital
	CLRF       ANSEL+0
;Servo_Motor_Control.c,9 :: 		ANSELH = 0;
	CLRF       ANSELH+0
;Servo_Motor_Control.c,10 :: 		C1ON_bit = 0;                       // Disable comparators
	BCF        C1ON_bit+0, BitPos(C1ON_bit+0)
;Servo_Motor_Control.c,11 :: 		C2ON_bit = 0;
	BCF        C2ON_bit+0, BitPos(C2ON_bit+0)
;Servo_Motor_Control.c,14 :: 		PORTB = 0;
	CLRF       PORTB+0
;Servo_Motor_Control.c,15 :: 		PORTC=0X00;
	CLRF       PORTC+0
;Servo_Motor_Control.c,18 :: 		while (1) {
L_main0:
;Servo_Motor_Control.c,22 :: 		if (RA0_bit==1 && RA1_bit==0)
	BTFSS      RA0_bit+0, BitPos(RA0_bit+0)
	GOTO       L_main4
	BTFSC      RA1_bit+0, BitPos(RA1_bit+0)
	GOTO       L_main4
L__main16:
;Servo_Motor_Control.c,25 :: 		RC0_bit=1;
	BSF        RC0_bit+0, BitPos(RC0_bit+0)
;Servo_Motor_Control.c,26 :: 		Delay_us(1150);
	MOVLW      2
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_main5:
	DECFSZ     R13+0, 1
	GOTO       L_main5
	DECFSZ     R12+0, 1
	GOTO       L_main5
;Servo_Motor_Control.c,27 :: 		RC0_bit=0;
	BCF        RC0_bit+0, BitPos(RC0_bit+0)
;Servo_Motor_Control.c,28 :: 		Delay_us(18850);
	MOVLW      25
	MOVWF      R12+0
	MOVLW      121
	MOVWF      R13+0
L_main6:
	DECFSZ     R13+0, 1
	GOTO       L_main6
	DECFSZ     R12+0, 1
	GOTO       L_main6
	NOP
	NOP
;Servo_Motor_Control.c,29 :: 		Delay_ms(2000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main7:
	DECFSZ     R13+0, 1
	GOTO       L_main7
	DECFSZ     R12+0, 1
	GOTO       L_main7
	DECFSZ     R11+0, 1
	GOTO       L_main7
	NOP
	NOP
;Servo_Motor_Control.c,31 :: 		}
	GOTO       L_main8
L_main4:
;Servo_Motor_Control.c,34 :: 		else if( RA0_bit==0 && RA1_bit==1)
	BTFSC      RA0_bit+0, BitPos(RA0_bit+0)
	GOTO       L_main11
	BTFSS      RA1_bit+0, BitPos(RA1_bit+0)
	GOTO       L_main11
L__main15:
;Servo_Motor_Control.c,37 :: 		RC0_bit=1;
	BSF        RC0_bit+0, BitPos(RC0_bit+0)
;Servo_Motor_Control.c,38 :: 		Delay_us(700);
	MOVLW      233
	MOVWF      R13+0
L_main12:
	DECFSZ     R13+0, 1
	GOTO       L_main12
;Servo_Motor_Control.c,39 :: 		RC0_bit=0;
	BCF        RC0_bit+0, BitPos(RC0_bit+0)
;Servo_Motor_Control.c,40 :: 		Delay_us(19300);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      15
	MOVWF      R13+0
L_main13:
	DECFSZ     R13+0, 1
	GOTO       L_main13
	DECFSZ     R12+0, 1
	GOTO       L_main13
;Servo_Motor_Control.c,41 :: 		}
	GOTO       L_main14
L_main11:
;Servo_Motor_Control.c,42 :: 		else RC0_bit=0;
	BCF        RC0_bit+0, BitPos(RC0_bit+0)
L_main14:
L_main8:
;Servo_Motor_Control.c,43 :: 		}
	GOTO       L_main0
;Servo_Motor_Control.c,44 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
