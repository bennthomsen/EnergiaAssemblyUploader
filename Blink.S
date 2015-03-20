;-------------------------------------------------------------------------------
; blinkasm.S - gcc compatible interrupt driven led blinker in msp430 asm
;
; Version 1.0 - 10/22/2011 rick@kimballsoftware.com
;	
;-------------------------------------------------------------------------------
#include "msp430g2553.h"
 
;-------------------------------------------------------------------------------
;;; ---- gcc doesn't know about PC,SP,SR,CG1,CG2 ----
 
#define PC r0                   
#define SP r1
#define SR r2
#define CG1 r2
#define CG2 r3

;-------------------------------------------------------------------------------
        .text
;-------------------------------------------------------------------------------
RESET_ISR:
        ;; disable watchdog and set stack to highest RAM addr
        mov.w   #WDTPW+WDTHOLD,&WDTCTL
        mov.w   #__stack,SP                     ; gcc ldscripts compute __stack based on mmcu
 
        ;; initialize clock,gpio,timer
       BIS.b #0x01,&P1DIR ; Set bit0 in port1 as output
       BIC.B #0x01,&P1OUT ; clear bit0

start: MOV.W #10000, R15  ; Load 50000 into R15

loop1: DEC.W R15          ; Decrement value stored in R15
       JNZ loop1          ; Jump to loop1 if value in R15 is non zero
       BIS.B #0x01,&P1OUT ; set bit0
       MOV.W #10000, R15  ; Load 50000 into R15

loop2: DEC.W R15          ; Decrement value stored in R15
       JNZ loop2          ; Jump to loop2 if value in R15 is non zero
       BIC.B #0x01,&P1OUT ; Clear bit0
       JMP start          ; Jump to start

       ;------------------------------------------------------------------------------
; UNEXPECTED_ISR - default handler for unhandled interrupt
;-------------------------------------------------------------------------------
UNEXPECTED_ISR:
        reti                    ; cycles: 5

       ;------------------------------------------------------------------------------
; Interrupt Vectors - see the datasheet for your chip
;                    *msp430g2553 vectors described below
;------------------------------------------------------------------------------
        .section ".vectors", "ax", @progbits
        .word UNEXPECTED_ISR    ;0xffe0 slot  0  0
        .word UNEXPECTED_ISR    ;0xffe2 slot  1  2
        .word UNEXPECTED_ISR    ;0xffe4 slot  2  4 (PORT1_VECTOR)
        .word UNEXPECTED_ISR    ;0xffe6 slot  3  6 (PORT2_VECTOR)
        .word UNEXPECTED_ISR    ;0xffe8 slot  4  8 
        .word UNEXPECTED_ISR    ;0xffea slot  5  A (ADC10_VECTOR)
        .word UNEXPECTED_ISR    ;0xffec slot  6  C (USCIAB0TX_VECTOR) 
        .word UNEXPECTED_ISR    ;0xffee slot  7  E (USCIAB0RX_VECTOR)
        .word UNEXPECTED_ISR    ;0xfff0 slot  8 10 (TIMER0_A1_VECTOR)
        .word UNEXPECTED_ISR     ;0xfff2 slot  9 12 (TIMER0_A0_VECTOR)
        .word UNEXPECTED_ISR    ;0xfff4 slot 10 14 (WDT_VECTOR)
        .word UNEXPECTED_ISR    ;0xfff6 slot 11 16 (COMPARATORA_VECTOR)
        .word UNEXPECTED_ISR    ;0xfff8 slot 12 18 (TIMER1_A1_VECTOR)
        .word UNEXPECTED_ISR    ;0xfffa slot 13 1a (TIMER1_A0_VECTOR)
        .word UNEXPECTED_ISR    ;0xfffc slot 14 1c (NMI_VECTOR)
        .word RESET_ISR         ;0xfffe slot 15 1e (RESET_VECTOR)
        .end
