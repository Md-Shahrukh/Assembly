R8				EQU		50H				
				
				ORG	00H
					MOV R8,#30H
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
				MOV A,#80H
				ACALL CMD
				ACALL DELAY
				MOV DPTR,#DAT1
				MOV R2,#11
				ACALL DAT2
				ACALL DELAY
				MOV A,#0C0H
				ACALL CMD
				ACALL DELAY
				MOV R2,#0FFH
Q1:				MOV R1,#00
Q2:				MOV A,R1
				MOV B,#10
				DIV AB
				MOV 30H,B
				ACALL DELAY
				MOV B,#10
				DIV AB
				MOV 31H,B
				MOV 32H,A
				INC R1
				ACALL DAT
				ACALL DELAY
				ACALL DAT11
				ACALL DELAY
				ACALL DAT12
				ACALL DELAY
				MOV A,#0C0H
				ACALL CMD
				DJNZ R2,Q2
				CJNE R1,#255,Q1
				SJMP $
CMD: 	MOV P2,A
		CLR P0.0
		CLR P0.1
		SETB P0.2
		ACALL DELAY
		CLR P0.2
		RET
		
DAT2:	CLR A
		MOVC A,@A+DPTR
DAT6:	MOV P2,A
		INC DPTR
		SETB P0.0
		CLR P0.1
		SETB P0.2
		ACALL DELAY
		CLR P0.2
		DJNZ R2,DAT2
		RET

DAT:	MOV A,32H
    	ADD A,R8
		MOV P2,A
		SETB P0.0
		CLR P0.1
		SETB P0.2
		ACALL DELAY
		CLR P0.2
		MOV A,R3
		RET
DAT11:	MOV A,31H
    	ADD A,R8
		MOV P2,A
		SETB P0.0
		CLR P0.1
		SETB P0.2
		ACALL DELAY
		CLR P0.2
		MOV A,R3
		RET
DAT12:	MOV A,30H
    	ADD A,R8
		MOV P2,A
		SETB P0.0
		CLR P0.1
		SETB P0.2
		ACALL DELAY
		CLR P0.2
		MOV A,R3
		RET
		
DELAY: 	MOV R0,#200
X1:		MOV R4,#200
X2:		DJNZ R4,X2
		DJNZ R0,X1
		RET
			ORG 250H
DAT1:   DB "LCD COUNTER",0					
				END
		