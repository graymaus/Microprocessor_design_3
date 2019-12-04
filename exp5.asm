; STANDARD HEADER FILE
	PROCESSOR		16F876A
;---REGISTER FILES 선언 ---
;  BANK 0
INDF	 EQU	00H
TMR0	 EQU	01H
PCL	 EQU	02H
STATUS	 EQU	03H
FSR	 EQU	04H	
PORTA	 EQU	05H
PORTB	 EQU	06H
PORTC	 EQU	07H
EEDATA	 EQU	08H
EEADR	 EQU	09H
PCLATH	 EQU	0AH
INTCON	 EQU	0BH
; BANK 1
OPTINOR	 EQU	81H
TRISA	 EQU	85H
TRISB	 EQU	86H
TRISC	 EQU	87H
EECON1	 EQU	88H
EECON2	 EQU	89H
ADCON1	 EQU	9FH
;---STATUS BITS 선언---
IRP	 EQU	7
RP1	 EQU	6
RP0	 EQU	5
NOT_TO 	 EQU	4
NOT_PD 	 EQU	3
ZF 	 EQU	2 ;ZERO FLAG BIT
DC 	 EQU	1 ;DIGIT CARRY/BORROW BIT
CF 	 EQU	0 ;CARRY BORROW FLAG BIT

; -- INTCON BITS 선언 --
; -- OPTION BITS 선언 --

W 	 EQU	B'0' ; W 변수를 0으로 선언
F 	 EQU	.1   ; F 변수를 1로 선언

; --USER
DISP1	 EQU 	20H
DBUF1	 EQU  	21H
DBUF2	 EQU	22H
DISP2	 EQU	23H

;MAIN PROGRAM
	ORG	0000
	BSF 	STATUS,RP0 ; BANK를 1로 변경함
	MOVLW	B'00000000'; 
	MOVWF	TRISA
	MOVLW	B'00000000';
	MOVWF	TRISC	 ; PORTA와C를 모두 OUTPUT설정
	MOVWF	ADCON1
	BCF	STATUS,RP0 ; BANK를 0으로 변경
	MOVLW	B'00011011';
	MOVWF	DISP1
	MOVLW	B'01000001';
	MOVWF	DISP2
	
D_LOOP	MOVLW	0
	MOVWF	PORTA	;전부 OFF	
	MOVLW	B'10011111'
	MOVWF	PORTC
	MOVLW	B'00001000'
	MOVWF	PORTA
	CALL	DELAY	;1
		
	MOVLW	0
	MOVWF	PORTA	;전부 OFF	
	MOVLW	B'00100101'
	MOVWF	PORTC
	MOVLW	B'00000100'
	MOVWF	PORTA
	CALL	DELAY	;2
		
	MOVLW	0
	MOVWF	PORTA	;전부 OFF	
	MOVLW	B'00001101'
	MOVWF	PORTC
	MOVLW	B'00000010'
	MOVWF	PORTA
	CALL	DELAY	;3
		
	MOVLW	0
	MOVWF	PORTA	;전부 OFF	
	MOVLW	B'10011001'
	MOVWF	PORTC
	MOVLW	B'00000001'
	MOVWF	PORTA
	CALL	DELAY	;4

	GOTO	D_LOOP
; SUBROUTINE
DELAY			;5ms 지연
	MOVLW	.125
	MOVWF	DBUF1	 ; 125번을 확인하기 위한 변수
LP1	MOVLW	.10
	MOVWF	DBUF2	 ; 10번을 확인하기 위한 변수
LP2	NOP
	DECFSZ	DBUF2,F
	GOTO	LP2
	DECFSZ	DBUF1,F	 ; 변수를 감소시켜 00이 되었나 확인
	GOTO	LP1	 ; ZERO가 아니면 여기에 들어옴
	RETURN
	
END