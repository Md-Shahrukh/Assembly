
			ORG		00H
			SJMP	MAIN
			ORG		03H
			CPL		P2.1
			NOP
			NOP
			NOP
			NOP
			RETI
			ORG		23H
			sjmp	nkp
			ORG			30H
MAIN:		MOV			IE,#10010001B			; HW0, ES ENABLE
			MOV			TMOD,#20H
			MOV			TH1,#0FDH
			SETB		TR1
			MOV			SCON,#50H
			
MAIN1:		MOV			A,P1
			SJMP        $
			CJNE		A,#0FFH,K1
			SJMP		MAIN1
K1:			CPL			P2.0
			SJMP		MAIN



nkp:			CLR		RI
			MOV		A,SBUF
			MOV		P0,A
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
		SJMP X3
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
X3:			RETI
			


END