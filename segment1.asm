	org 00h
	CLR P3.0
X5:	MOV A,#00
X2:	MOV R0,A
	CJNE R0,#00,X1
	MOV P1,#11000000B
	INC A
	ACALL DELAY
	SJMP X2
X1:	CJNE R0,#01,X3
	MOV P1,#11111001B
	INC A
	ACALL DELAY
	SJMP X2
X3:	CJNE R0,#02,X4
	MOV P1,#10100100B
	INC A
	ACALL DELAY
	SJMP X2
X4:	CJNE R0,#03,X6
	MOV P1,#10110000B
	INC A
	ACALL DELAY
	SJMP X2
X6:	CJNE R0,#04,X7
	MOV P1,#10011001B
	INC A
	ACALL DELAY
	SJMP X2
X7:	CJNE R0,#05,X8
	MOV P1,#10010010B
	INC A
	ACALL DELAY
	SJMP X2
X8:	CJNE R0,#06,X9
	MOV P1,#10000010B
	INC A
	ACALL DELAY
	SJMP X2
X9:	CJNE R0,#07,X10
	MOV P1,#11111000B
	INC A
	ACALL DELAY
	SJMP X2
X10:CJNE R0,#08,X11
	MOV P1,#10000000B
	INC A
	ACALL DELAY
	SJMP X2
X11:CJNE R0,#09,X12
	MOV P1,#10010000B
	INC A
	ACALL DELAY
	SJMP X2
X12:ACALL DELAY
	SJMP X5
DELAY:MOV R1,#11
Q3:	MOV R2,#200
Q2:	MOV R3,#200
Q1:	DJNZ R3,Q1
	DJNZ R2,Q2
	DJNZ R1,Q3
	RET
	END