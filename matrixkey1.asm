		ORG 00H
		MOV P2,#0FFH
X0:		MOV P1,#00H
		MOV A,P2
		CJNE A,#0FFH,X2
		SJMP X0
X2:		MOV P1,#0FFH
		CLR P1.0
		MOV A,P2
		CJNE A,#0FFH,X3
		SJMP X4
X3:		MOV A,P2
		CJNE A,#0FEH,X5
		MOV P0,#11000000B
		ACALL DELAY
		SJMP X0
X5:		MOV A,P2
		CJNE A,#0FDH,X6
		MOV P0,#11111001B
		ACALL DELAY
		SJMP X0
X6:		MOV A,P2
		CJNE A,#11111011B,X0
		MOV P0,#10100100B
		ACALL DELAY
		SJMP X0
X4:		SETB P1.0
		CLR P1.1
		MOV A,P2
		CJNE A,#0FFH,X7
		SJMP X8
X7:		MOV A,P2
		CJNE A,#11111110B,X9
		MOV P0,#10110000B
		ACALL DELAY
		SJMP X0
X9:		MOV A,P2
		CJNE A,#11111101B,X10
		MOV P0,#10011001B
		ACALL DELAY
		SJMP X0
X10:	MOV A,P2
		CJNE A,#11111011B,X0
		MOV P0,#10010010B
		ACALL DELAY
		SJMP X0
X8:		SETB P1.1
		CLR P1.2
		MOV A,P2
		CJNE A,#0FFH,X11
		SJMP X0
X11:	MOV A,P2
		CJNE A,#11111110B,X12
		MOV P0,#10000010B
		ACALL DELAY
		SJMP X0
X12:	MOV A,P2
		CJNE A,#11111101B,X13
		MOV P0,#11111000B
		ACALL DELAY
		LJMP X0
X13:	MOV A,P2
		CJNE A,#11111011B,X14
		MOV P0,#10000000B
		ACALL DELAY
		LJMP X0
X14:	LJMP X0
DELAY:	MOV R0,#3
Q3:		MOV R1,#200
Q2:		MOV R2,#200
Q1:		DJNZ R2,Q1
		DJNZ R1,Q2
		DJNZ R0,Q3
		RET
		END
		