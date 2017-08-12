		ORG 00H
		MOV A,#38H
		ACALL CMD
		ACALL DELAY
		MOV A,#0EH
		ACALL CMD
		ACALL DELAY
		MOV A,#01H
		ACALL CMD
		ACALL DELAY
		MOV A,#06H
		ACALL CMD
		ACALL DELAY
		MOV A,#87H
		ACALL CMD
		ACALL DELAY
		MOV A,#"N"
		ACALL DAT
		ACALL DELAY
		MOV A,#"I"
		ACALL DAT
		ACALL DELAY
X3:		SJMP X3
CMD: 	MOV P2,A
		CLR P0.0
		CLR P0.1
		SETB P0.2
		ACALL DELAY
		CLR P0.2
		RET
DAT:	MOV P2,A
		SETB P0.0
		CLR P0.1
		SETB P0.2
		ACALL DELAY
		CLR P0.2
		RET
DELAY: 	MOV R0,#200
	X1:	MOV R1,#200
	X2:	DJNZ R1,X2
		DJNZ R0,X1
		RET
		END