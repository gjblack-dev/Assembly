; This AVR assembly code was developed and tested by Gabriel J. Black
; Project: Autonomous Car
; This project uses sensors and a motor driver to create an autonomous car
; EEL 4744
; Spring 2025

; effectly a store immediate instruction
.MACRO STI
LDI R25, @0
STS @1, R25
.ENDMACRO
    
;calculations for Dual-Slope PWM 50Hz signal with 50% duty cycle
.EQU CLK_FREQ = 4000000
.EQU SIGNAL_FREQ = 50
.EQU PRESCALER = 1
.EQU TOP_VALUE = CLK_FREQ / (2 * SIGNAL_FREQ * PRESCALER)


; CMP_VALUE = MOTORSPEED
.EQU MOTORSPEED_100 = (TOP_VALUE * 100) / 100
.EQU MOTORSPEED_75 = (TOP_VALUE * 75) / 100
.EQU MOTORSPEED_50 = (TOP_VALUE * 50) / 100
.EQU MOTORSPEED_40 = (TOP_VALUE * 40) / 100
.EQU MOTORSPEED_25 = (TOP_VALUE * 25) / 100
.EQU MOTORSPEED_20 = (TOP_VALUE * 20) / 100
.EQU MOTORSPEED_10 = (TOP_VALUE * 10) / 100
 

    
    
.org 0x00
    RJMP MAIN

 .org 0x100
MAIN:
;------------------------- PWM Motor Setup ---------------------------- 
;set dual slope pwm mode     
STI 0b01110101, TCA0_SINGLE_CTRLB

;set port d as output for wave generators 0x03
;port f for testing 0x05
STI 0x03, PORTMUX_TCAROUTEA

;prescaler set to 1
STI 0x01, TCA0_SINGLE_CTRLA

;set new top
STI HIGH(TOP_VALUE), TCA0_SINGLE_PERH
STI LOW(TOP_VALUE), TCA0_SINGLE_PERL

;set 1st motor speed
STI HIGH(MOTORSPEED_75), TCA0_SINGLE_CMP2H
STI LOW(MOTORSPEED_75), TCA0_SINGLE_CMP2L

;set 2nd motor speed
STI HIGH(MOTORSPEED_75), TCA0_SINGLE_CMP1H
STI LOW(MOTORSPEED_75), TCA0_SINGLE_CMP1L


;set motor speed to portF
STI 0b00000110 , PORTD_DIR 
    
;set portd as output
STI 0xF0 , PORTA_DIR
    
;set direction outputs
STI 0b01100000, PORTA_OUT

;------------------------- LFS Sensor debugging Setup ----------------------------
; a program to load the output from line-following sensor and
; send the data to the PC terminal using USART1
; for debugging purposes only  
;STI HIGH(0x682), USART1_BAUDH
;STI LOW(0x682), USART1_BAUDL
;    
;STI  0x03, USART1_CTRLC
;    
;STI 0x10, PORTMUX_USARTROUTEA
;    
;STI  0b01000000, PORTD_DIR
;    
;STI 0xC0, USART1_CTRLB
    
;LDS R16, USART1_STATUS
;SBRS R16, 5
;RJMP loop
;STS USART1_TXDATAL, R20
    
loop:
LDS R20, PORTA_IN
ANDI R20, 0x0F       ;and "0x0F" with incoming data to mask upper 4 bits
CPI R20, 0x06	     ;compare with 0x06
BREQ GO_STRAIGHT     ;go straight if equal (z = 1)
BRGE TURN_RIGHT	     ;turn right if R20 > 0x06
BRLT TURN_LEFT	     ;turn lef if R20 < 0x06

rjmp loop
    
GO_STRAIGHT:
    ;set 1st motor speed
STI HIGH(MOTORSPEED_40), TCA0_SINGLE_CMP2H
STI LOW(MOTORSPEED_40), TCA0_SINGLE_CMP2L

;set 2nd motor speed
STI HIGH(MOTORSPEED_40), TCA0_SINGLE_CMP1H
STI LOW(MOTORSPEED_40), TCA0_SINGLE_CMP1L
    
RJMP loop

    
TURN_RIGHT:

;set 1st motor speed
STI HIGH(MOTORSPEED_25), TCA0_SINGLE_CMP2H
STI LOW(MOTORSPEED_25), TCA0_SINGLE_CMP2L

;set 2nd motor speed
STI HIGH(MOTORSPEED_10), TCA0_SINGLE_CMP1H
STI LOW(MOTORSPEED_10), TCA0_SINGLE_CMP1L

RJMP loop
    
    
    
TURN_LEFT:
    
    ;set 1st motor speed
STI HIGH(MOTORSPEED_10), TCA0_SINGLE_CMP2H
STI LOW(MOTORSPEED_10), TCA0_SINGLE_CMP2L

;set 2nd motor speed
STI HIGH(MOTORSPEED_25), TCA0_SINGLE_CMP1H
STI LOW(MOTORSPEED_25), TCA0_SINGLE_CMP1L
    
RJMP loop
    
