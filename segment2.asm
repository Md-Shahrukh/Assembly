		org 00h
X3:		MOV A,#02
		MOV P3,#11111110B
		MOV P1,#10100100B
		ACALL DELAY
		MOV A,03
		MOV P3,#11111101B
		MOV P1,#10110000B
		ACALL DELAY
		SJMP X3
DELAY:	MOV R0,#100
X1:		MOV R1,#50
X2:		DJNZ R1,X2
		DJNZ R0,X1
		
		RET
		END