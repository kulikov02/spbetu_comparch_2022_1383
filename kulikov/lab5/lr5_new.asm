AStack SEGMENT STACK
	db 2048 DUP(? )
AStack ENDS

DATA SEGMENT
	KEEP_CS DW 0
	KEEP_IP DW 0
	GREETING  DB 'Student from 1383 - Kulikov M.D.', 10, 13, '$'
	COUNTER DB 0
	CUR_DELAY DB 1
	INT_FLAG DB 0
DATA ENDS

CODE SEGMENT
ASSUME CS : CODE, DS : DATA, SS : AStack

ONE_SEC_DELAY Proc NEAR
	push cx
	push dx
	mov cx, 0fh
	mov dx, 4240h
	mov ah, 86h
	int 15h
	pop dx
	pop cx
	ret
ONE_SEC_DELAY ENDP

SUBR_INT PROC FAR

	MOV BL,1
	CMP BL,INT_FLAG
	JE THE_END
	INC INT_FLAG
	PRINT_LOOP:
		MOV DX, OFFSET GREETING
		mov ah,9
		INT 21H
		cmp cx, 1
		je THE_END
		DELAY:
			push cx
			mov cx,0ffffh
			first_delay_loop:
				push cx
				mov cx,0fh
				delay_loop:
					nop
					loop delay_loop
				pop cx
				loop first_delay_loop
			pop cx
			inc COUNTER
			MOV AL, COUNTER
			CMP AL,CUR_DELAY
			JL DELAY
		SHL CUR_DELAY,1
		AND COUNTER,0
		LOOP PRINT_LOOP



	THE_END:

	MOV AL, 20H
	OUT 20H, AL
	IRET

SUBR_INT ENDP



Main PROC FAR
	push DS
	sub AX, AX
	push AX
	mov AX, DATA
	mov DS, AX


	MOV AH, 35H
	MOV AL, 08H
	INT 21H
	MOV KEEP_IP, BX
	MOV KEEP_CS, ES
	
	

	PUSH DS
	MOV DX, OFFSET SUBR_INT
	MOV AX, SEG SUBR_INT
	MOV DS, AX
	MOV AH, 25H
	MOV AL, 08H
	INT 21H
	POP DS
	
	
	MOV CX, 3
	
	
	
	
	mov ah,08h
	
	loop_label:
		int 21h
		cmp al,1bh
		jne loop_label
	
	finish_label:
		
	


	CLI
	PUSH DS
	MOV DX, KEEP_IP
	MOV AX, KEEP_CS
	MOV DS, AX
	MOV AH, 25H
	MOV AL, 08H
	INT 21H
	POP DS
	STI

	
	ret

Main ENDP
CODE ENDS
	END Main