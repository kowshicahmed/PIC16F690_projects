#line 1 "F:/pic project/mikroc_projects/MCU_pic16f690_projects/ADC/adc_MIKROC.c"

 int hi_val;
 int low_val;
 int n;
 float analog;

int hi, lo, value;

void main(){

 TRISA=0b00000100;
 TRISC=0b00000000;
 ANSEL=0b00000100;
 ANSELH=0x00;
ADON_bit=1;
CHS3_bit=0;
 CHS2_bit=0;
 CHS1_bit=1;
 CHS0_bit=0;
VCFG_bit=0;

 ADCS2_bit=1;
 ADCS1_bit=1;
 ADCS0_bit=0;

ADFM_bit=1;


while (1){
Delay_ms(50);
ADCON0.B1=1;
while (ADCON0.B1==1){}
delay_ms(200);


low_val=ADRESL;
hi_val=ADRESH;


n=(hi_val<<8)+ low_val;


analog=(n* 5.00)/1023;


 value=analog*100;
 hi=(value/10);
 lo=value%10;
PORTC= (hi<<4)+lo;

Delay_ms(50);

}
}
