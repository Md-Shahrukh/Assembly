			ORG 	00H
			LJMP 	MAIN
			
			ORG		0003H
			ACALL 	AGC
			
			RETI
			
			;ORG 	000BH
			;ACALL	CHECK_AGC
			;RETI
			
			;ORG		001BH
			;ACALL 	RE_CHECK
			;RETI
			
			ORG 100H
MAIN:		MOV		DPTR,#LCDCMD
MAIN1:		MOVC	A,@A+DPTR
			JZ		X1
			ACALL	CMD
			INC		DPTR
			CLR		A
			MOV		R1,#0CH
			SJMP 	MAIN1
X1:			CLR		A
			MOV		R2,#00H
			MOV 	IE,#10000001B
			;MOV 	TCON,#02H
X2:			CJNE	R2,#30H,X2
			;LCALL	READ
			MOV		IE,#10000001B
			MOV		R2,#00H
			MOV		DPTR,#LCDRE
X3:			MOVC	A,@A+DPTR
			ACALL	CMD
			JZ		X2		
			CLR 	A
			INC		DPTR
			SJMP	X3
			
CMD: 		MOV 	P2,A
			CLR 	P0.0
			CLR 	P0.1
			SETB 	P0.2
			ACALL 	DELAY
			CLR		P0.2
			RET
DAT1:		MOV		A,#00H			
DAT:		ADD		A,#30H
			MOV 	P2,A
			SETB 	P0.0
			CLR 	P0.1
			SETB 	P0.2
			ACALL 	DELAY
			CLR 	P0.2
			RET
			

DELAY: 		MOV 	R5,#50
XX1:		MOV 	R4,#100
XX2:		DJNZ	R4,XX2
			DJNZ 	R5,XX1
			RET	

DELAY1:		MOV		R5,#3
X11:		MOV		R4,#255
X12:		MOV		R3,#255
X13:		DJNZ	R3,X13
			DJNZ	R4,X12
			DJNZ	R5,X11
			RET

AGC:		CLR		A
			ACALL 	DAT
			CLR		IE.7
			MOV		IE,#82H
			MOV		TMOD,#01H
			MOV		TH0,#0F9H
			MOV		TL0,#0C8H
			SETB	TR0
Q11:		JNB		TF0,Q11
			CLR		TF0
			MOV		C,P3.2
			CLR		A
			MOV		ACC.0,C
			ACALL	DAT
			DJNZ	R1,AGC
			MOV		R2,#30H
			RET

CHECK_AGC:	CLR		TR0
			MOV 	C,P3.2
			CLR 	A
			MOV		ACC.0,C
			CJNE	A,#01H,Q1
			ACALL 	DAT
			MOV		R2,#30H
			RET
Q1:			CLR		TR0
			CLR		IE.7
			MOV		IE,#10001000B
			MOV		TMOD,#10H
			MOV 	TH1,#0A8H
			MOV		TL1,#0E8H
			SETB	TR1
Z1:			JNB		TF1,Z1
			RET

;RE_CHECK:	CLR		TR1
			;MOV		R2,#30H
			;RET
			
;READ:		MOV		R1,#0CH
;READ1:		MOV		TMOD,#01H
			;MOV		TH0,#0F9H
			;MOV		TL0,#0C6H
			;SETB	TR0
;Z2:			JNB		TF0,Z2
			;MOV		C,P3.2
			;MOV		ACC.0,C
			;ACALL	DAT
			;ACALL	DELAY
			;DJNZ 	R1,READ1
			;RET

			ORG 300H
LCDCMD:		DB 		38H,0EH,06H,01H,80H,0
LCDRE:		DB		01,0
			END