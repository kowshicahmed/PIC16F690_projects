
_main:

;MyProject.c,25 :: 		void main() {
;MyProject.c,26 :: 		TRISA=0b00000001;  // defining RA0 as input
	MOVLW      1
	MOVWF      TRISA+0
;MyProject.c,27 :: 		TRISB=0X00;
	CLRF       TRISB+0
;MyProject.c,28 :: 		TRISC=0X00;
	CLRF       TRISC+0
;MyProject.c,29 :: 		ANSEL=0x01;
	MOVLW      1
	MOVWF      ANSEL+0
;MyProject.c,30 :: 		ANSELH=0;
	CLRF       ANSELH+0
;MyProject.c,31 :: 		PORTB=0X00;
	CLRF       PORTB+0
;MyProject.c,32 :: 		C1ON_bit = 0;               // Disable comparators
	BCF        C1ON_bit+0, BitPos(C1ON_bit+0)
;MyProject.c,33 :: 		C2ON_bit = 0;
	BCF        C2ON_bit+0, BitPos(C2ON_bit+0)
;MyProject.c,35 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;MyProject.c,36 :: 		PWM1_Init(5000);                    // Initialize PWM1 module at 5KHz
	BCF        T2CON+0, 0
	BCF        T2CON+0, 1
	MOVLW      199
	MOVWF      PR2+0
	CALL       _PWM1_Init+0
;MyProject.c,38 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,39 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,40 :: 		Lcd_Out(1, 1, "TEMPERATURE= ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,41 :: 		while(1)
L_main0:
;MyProject.c,42 :: 		{   PWM1_Start();                       // start PWM1
	CALL       _PWM1_Start+0
;MyProject.c,43 :: 		reg_value=ADC_read(0);
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _reg_value+0
	MOVF       R0+1, 0
	MOVWF      _reg_value+1
;MyProject.c,44 :: 		analog=(reg_value* 5.00)/1023;
	CALL       _Int2Double+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      32
	MOVWF      R4+2
	MOVLW      129
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      192
	MOVWF      R4+1
	MOVLW      127
	MOVWF      R4+2
	MOVLW      136
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _analog+0
	MOVF       R0+1, 0
	MOVWF      _analog+1
	MOVF       R0+2, 0
	MOVWF      _analog+2
	MOVF       R0+3, 0
	MOVWF      _analog+3
;MyProject.c,45 :: 		value=analog*100;
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      72
	MOVWF      R4+2
	MOVLW      133
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	CALL       _Double2Int+0
	MOVF       R0+0, 0
	MOVWF      _value+0
	MOVF       R0+1, 0
	MOVWF      _value+1
;MyProject.c,46 :: 		analog_h=(value/10);
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      _analog_h+0
	MOVF       R0+1, 0
	MOVWF      _analog_h+1
;MyProject.c,47 :: 		analog_l=(value%10);
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _value+0, 0
	MOVWF      R0+0
	MOVF       _value+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      _analog_l+0
	MOVF       R0+1, 0
	MOVWF      _analog_l+1
;MyProject.c,48 :: 		temp_c= (analog_h<<4) + analog_l ;
	MOVLW      4
	MOVWF      R2+0
	MOVF       _analog_h+0, 0
	MOVWF      _temp_c+0
	MOVF       R2+0, 0
L__main19:
	BTFSC      STATUS+0, 2
	GOTO       L__main20
	RLF        _temp_c+0, 1
	BCF        _temp_c+0, 0
	ADDLW      255
	GOTO       L__main19
L__main20:
	MOVF       R0+0, 0
	ADDWF      _temp_c+0, 1
;MyProject.c,51 :: 		Lcd_Chr(1,13,analog_h+48);
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      13
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      48
	ADDWF      _analog_h+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;MyProject.c,52 :: 		Lcd_Chr(1,14,analog_l+48);
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      14
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      48
	ADDWF      _analog_l+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;MyProject.c,53 :: 		Lcd_Chr(1,15,0xDF);
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      15
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      223
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;MyProject.c,54 :: 		Lcd_Out(1,16,"C");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      16
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,57 :: 		if(temp_c<=0x20)
	MOVF       _temp_c+0, 0
	SUBLW      32
	BTFSS      STATUS+0, 0
	GOTO       L_main2
;MyProject.c,60 :: 		LCD_Out(2,3,"MOTOR AT 20% ");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,61 :: 		PWM1_Set_Duty(77);        // Set current duty 30%
	MOVLW      77
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;MyProject.c,62 :: 		Delay_ms(500);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main3:
	DECFSZ     R13+0, 1
	GOTO       L_main3
	DECFSZ     R12+0, 1
	GOTO       L_main3
	DECFSZ     R11+0, 1
	GOTO       L_main3
	NOP
	NOP
;MyProject.c,63 :: 		}
	GOTO       L_main4
L_main2:
;MyProject.c,64 :: 		else if(temp_c>0x20 && temp_c<=0x30)
	MOVF       _temp_c+0, 0
	SUBLW      32
	BTFSC      STATUS+0, 0
	GOTO       L_main7
	MOVF       _temp_c+0, 0
	SUBLW      48
	BTFSS      STATUS+0, 0
	GOTO       L_main7
L__main17:
;MyProject.c,66 :: 		LCD_Out(2,3,"MOTOR AT 40% ");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr4_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,67 :: 		PWM1_Set_Duty(127);        // Set current duty 50%
	MOVLW      127
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;MyProject.c,68 :: 		Delay_ms(500);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main8:
	DECFSZ     R13+0, 1
	GOTO       L_main8
	DECFSZ     R12+0, 1
	GOTO       L_main8
	DECFSZ     R11+0, 1
	GOTO       L_main8
	NOP
	NOP
;MyProject.c,69 :: 		}
	GOTO       L_main9
L_main7:
;MyProject.c,71 :: 		else if(temp_c>0x30 && temp_c<0x40) {
	MOVF       _temp_c+0, 0
	SUBLW      48
	BTFSC      STATUS+0, 0
	GOTO       L_main12
	MOVLW      64
	SUBWF      _temp_c+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main12
L__main16:
;MyProject.c,73 :: 		LCD_Out(2,3,"MOTOR AT 75% ");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr5_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,74 :: 		PWM1_Set_Duty(192);        // Set current duty 75%
	MOVLW      192
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;MyProject.c,75 :: 		Delay_ms(500);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main13:
	DECFSZ     R13+0, 1
	GOTO       L_main13
	DECFSZ     R12+0, 1
	GOTO       L_main13
	DECFSZ     R11+0, 1
	GOTO       L_main13
	NOP
	NOP
;MyProject.c,76 :: 		}
	GOTO       L_main14
L_main12:
;MyProject.c,78 :: 		LCD_Out(2,3, "MOTOR AT 100%");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr6_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,79 :: 		PWM1_Set_Duty(255);        // Set current duty 100%
	MOVLW      255
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;MyProject.c,80 :: 		Delay_ms(500);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main15:
	DECFSZ     R13+0, 1
	GOTO       L_main15
	DECFSZ     R12+0, 1
	GOTO       L_main15
	DECFSZ     R11+0, 1
	GOTO       L_main15
	NOP
	NOP
;MyProject.c,81 :: 		}
L_main14:
L_main9:
L_main4:
;MyProject.c,83 :: 		}
	GOTO       L_main0
;MyProject.c,85 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
