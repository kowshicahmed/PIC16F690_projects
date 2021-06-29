
_main:

;adc_MIKROC.c,9 :: 		void main(){
;adc_MIKROC.c,11 :: 		TRISA=0b00000100;
	MOVLW      4
	MOVWF      TRISA+0
;adc_MIKROC.c,12 :: 		TRISC=0b00000000;
	CLRF       TRISC+0
;adc_MIKROC.c,13 :: 		ANSEL=0b00000100;
	MOVLW      4
	MOVWF      ANSEL+0
;adc_MIKROC.c,14 :: 		ANSELH=0x00;
	CLRF       ANSELH+0
;adc_MIKROC.c,15 :: 		ADON_bit=1;
	BSF        ADON_bit+0, BitPos(ADON_bit+0)
;adc_MIKROC.c,16 :: 		CHS3_bit=0;		//Selecting the AN2 in the mux for ADC
	BCF        CHS3_bit+0, BitPos(CHS3_bit+0)
;adc_MIKROC.c,17 :: 		CHS2_bit=0;
	BCF        CHS2_bit+0, BitPos(CHS2_bit+0)
;adc_MIKROC.c,18 :: 		CHS1_bit=1;
	BSF        CHS1_bit+0, BitPos(CHS1_bit+0)
;adc_MIKROC.c,19 :: 		CHS0_bit=0;
	BCF        CHS0_bit+0, BitPos(CHS0_bit+0)
;adc_MIKROC.c,20 :: 		VCFG_bit=0;
	BCF        VCFG_bit+0, BitPos(VCFG_bit+0)
;adc_MIKROC.c,22 :: 		ADCS2_bit=1;		//ADC Clock = 4Mhz/64;
	BSF        ADCS2_bit+0, BitPos(ADCS2_bit+0)
;adc_MIKROC.c,23 :: 		ADCS1_bit=1;
	BSF        ADCS1_bit+0, BitPos(ADCS1_bit+0)
;adc_MIKROC.c,24 :: 		ADCS0_bit=0;
	BCF        ADCS0_bit+0, BitPos(ADCS0_bit+0)
;adc_MIKROC.c,26 :: 		ADFM_bit=1;
	BSF        ADFM_bit+0, BitPos(ADFM_bit+0)
;adc_MIKROC.c,29 :: 		while (1){
L_main0:
;adc_MIKROC.c,30 :: 		Delay_ms(50);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main2:
	DECFSZ     R13+0, 1
	GOTO       L_main2
	DECFSZ     R12+0, 1
	GOTO       L_main2
	NOP
	NOP
;adc_MIKROC.c,31 :: 		ADCON0.B1=1;
	BSF        ADCON0+0, 1
;adc_MIKROC.c,32 :: 		while (ADCON0.B1==1){}
L_main3:
	BTFSS      ADCON0+0, 1
	GOTO       L_main4
	GOTO       L_main3
L_main4:
;adc_MIKROC.c,33 :: 		delay_ms(200);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      8
	MOVWF      R12+0
	MOVLW      119
	MOVWF      R13+0
L_main5:
	DECFSZ     R13+0, 1
	GOTO       L_main5
	DECFSZ     R12+0, 1
	GOTO       L_main5
	DECFSZ     R11+0, 1
	GOTO       L_main5
;adc_MIKROC.c,36 :: 		low_val=ADRESL;		//read low byte
	MOVF       ADRESL+0, 0
	MOVWF      _low_val+0
	CLRF       _low_val+1
;adc_MIKROC.c,37 :: 		hi_val=ADRESH;
	MOVF       ADRESH+0, 0
	MOVWF      _hi_val+0
	CLRF       _hi_val+1
;adc_MIKROC.c,40 :: 		n=(hi_val<<8)+ low_val;
	MOVF       _hi_val+0, 0
	MOVWF      R0+1
	CLRF       R0+0
	MOVF       _low_val+0, 0
	ADDWF      R0+0, 1
	MOVF       _low_val+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      _n+0
	MOVF       R0+1, 0
	MOVWF      _n+1
;adc_MIKROC.c,43 :: 		analog=(n* 5.00)/1023;
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
;adc_MIKROC.c,46 :: 		value=analog*100;
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
;adc_MIKROC.c,47 :: 		hi=(value/10);
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      _hi+0
	MOVF       R0+1, 0
	MOVWF      _hi+1
;adc_MIKROC.c,48 :: 		lo=value%10;
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
	MOVWF      _lo+0
	MOVF       R0+1, 0
	MOVWF      _lo+1
;adc_MIKROC.c,49 :: 		PORTC= (hi<<4)+lo;
	MOVLW      4
	MOVWF      R3+0
	MOVF       _hi+0, 0
	MOVWF      R2+0
	MOVF       R3+0, 0
L__main8:
	BTFSC      STATUS+0, 2
	GOTO       L__main9
	RLF        R2+0, 1
	BCF        R2+0, 0
	ADDLW      255
	GOTO       L__main8
L__main9:
	MOVF       R0+0, 0
	ADDWF      R2+0, 0
	MOVWF      PORTC+0
;adc_MIKROC.c,51 :: 		Delay_ms(50);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main6:
	DECFSZ     R13+0, 1
	GOTO       L_main6
	DECFSZ     R12+0, 1
	GOTO       L_main6
	NOP
	NOP
;adc_MIKROC.c,53 :: 		}
	GOTO       L_main0
;adc_MIKROC.c,54 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
