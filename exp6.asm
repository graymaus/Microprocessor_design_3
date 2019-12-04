; STANDARD HEADER FILE
	PROCESSOR		16F876A
;---REGISTER FILES ���� ---
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
;---STATUS BITS ����---
IRP	 EQU	7
RP1	 EQU	6
RP0	 EQU	5
NOT_TO 	 EQU	4
NOT_PD 	 EQU	3
ZF 	 EQU	2 ;ZERO FLAG BIT
DC 	 EQU	1 ;DIGIT CARRY/BORROW BIT
CF 	 EQU	0 ;CARRY BORROW FLAG BIT

; -- INTCON BITS ���� --
; -- OPTION BITS ���� --

W 	 EQU	B'0' ; W ������ 0���� ����
F 	 EQU	.1   ; F ������ 1�� ����

; --USER
DISP1	 EQU 	20H
DBUF1	 EQU  	21H
DBUF2	 EQU	22H
DISP2	 EQU	23H
DISP3	 EQU	24H
DISP4	 EQU	25H

;MAIN PROGRAM
	ORG	0000
	BSF 	STATUS,RP0 ; BANK�� 1�� ������
	MOVLW	B'00000000'; 
	MOVWF	TRISA
	MOVLW	B'00000000';
	MOVWF	TRISC	 ; PORTA��C�� ��� OUTPUT����
	MOVWF	ADCON1
	BCF	STATUS,RP0 ; BANK�� 0���� ����
	MOVLW	B'00011011';
	MOVWF	DISP1
	MOVLW	B'01000001';
	MOVWF	DISP2
	
D_LOOP	MOVLW	0
	MOVWF	PORTA	;���� OFF	
	MOVLW	.1
	CALL	CONV
	MOVWF	PORTC
	MOVLW	B'00001000'
	MOVWF	PORTA
	CALL	DELAY	;1
		
	MOVLW	0
	MOVWF	PORTA	;���� OFF	
	MOVLW	.2
	CALL	CONV
	MOVWF	PORTC
	MOVLW	B'00000100'
	MOVWF	PORTA
	CALL	DELAY	;2
		
	MOVLW	0
	MOVWF	PORTA	;���� OFF	
	MOVLW	.1
	CALL	CONV
	MOVWF	PORTC
	MOVLW	B'00000010'
	MOVWF	PORTA
	CALL	DELAY	;3
		
	MOVLW	0
	MOVWF	PORTA	;���� OFF	
	MOVLW	.9
	CALL	CONV
	MOVWF	PORTC
	MOVLW	B'00000001'
	MOVWF	PORTA
	CALL	DELAY	;4

	GOTO	D_LOOP
; SUBROUTINE
DELAY			;5ms ����
	MOVLW	.200
	MOVWF	DBUF1	 ; 125���� Ȯ���ϱ� ���� ����
LP1	MOVLW	.200
	MOVWF	DBUF2	 ; 10���� Ȯ���ϱ� ���� ����
LP2	NOP
	DECFSZ	DBUF2,F
	GOTO	LP2
	DECFSZ	DBUF1,F	 ; ������ ���ҽ��� 00�� �Ǿ��� Ȯ��
	GOTO	LP1	 ; ZERO�� �ƴϸ� ���⿡ ����
	RETURN
	
; SUBROUTINE2
CONV	ANDLW	0FH	 ; W�� low nibble ���� ��ȯ����
	ADDWF	PCL,F	 ; PCL+��ȯ ���ڰ� --> PCL
			 ; PC�� ����ǹǷ� �� ��ɾ� ���� ���� ��ġ�� ����
	RETLW	B'00000011'; '0'�� ǥ���ϴ� ���� W�� ��
	RETLW	B'10011111'; '1'�� ǥ���ϴ� ���� W�� ��
	RETLW	B'00100101'; '2'�� ǥ���ϴ� ���� W�� ��
	RETLW	B'00001101'; '3'�� ǥ���ϴ� ���� W�� ��
	RETLW	B'10011001'; '4'�� ǥ���ϴ� ���� W�� ��
	RETLW	B'01001001'; '5'�� ǥ���ϴ� ���� W�� ��
	RETLW	B'01000001'; '6'�� ǥ���ϴ� ���� W�� ��
	RETLW	B'00011011'; '7'�� ǥ���ϴ� ���� W�� ��
	RETLW	B'00000001'; '8'�� ǥ���ϴ� ���� W�� ��
	RETLW	B'00001001'; '9'�� ǥ���ϴ� ���� W�� ��
	RETLW	B'11111101'; '-'�� ǥ���ϴ� ���� W�� ��
	RETLW	B'11111111'; ' '�� ǥ���ϴ� ���� W�� ��
	RETLW	B'11100101'; 'C'�� ǥ���ϴ� ���� W�� ��
	RETLW	B'11111110'; '.'�� ǥ���ϴ� ���� W�� ��
	RETLW	B'01100001'; 'E'�� ǥ���ϴ� ���� W�� ��
	RETLW	B'01110001'; 'F'�� ǥ���ϴ� ���� W�� ��
			 
	
END