				ORG		00H
				LJMP	MAIN
				
				ORG		0003H
				ACALL	AGC
				RETI
				
				ORG		000BH
				ACALL	CHECK	
				RETI
				
				ORG		001BH
				ACALL	ADDRESS	
				RETI
				
				ORG		100H
MAIN:			MOV		IE,#10000001B
				MOV		R2,#0BH
				ACALL	LCD
				SJMP 	$
					
				
LCD:			MOV		DPTR,#LCDCMD
LCD1:			MOVC	A,@A+DPTR
				JZ		X1
				ACALL	CMD
				CLR		A
				INC		DPTR
				SJMP	LCD1
X1:				RET	

CMD: 			MOV 	P2,A
				CLR 	P0.0
				CLR 	P0.1
				SETB 	P0.2
				ACALL 	DELAY
				CLR		P0.2
				RET

DELAY: 			MOV 	R5,#50
XX1:			MOV 	R4,#100
XX2:			DJNZ	R4,XX2
				DJNZ 	R5,XX1
				RET	

AGC:			CLR		IE.7
				MOV		IE,#10000010B
				MOV		TMOD,#01H
				MOV		TH0,#0FBH
				MOV		TL0,#055H
				SETB	TR0
				RET

CHECK:			CLR		TR0
				CLR		IE.7
				MOV		C,P3.2
				CLR		A
				MOV		ACC.0,C
				CJNE	A,#01H,Z4
				MOV		31H,A
				MOV		IE,#10001000B
				MOV		TMOD,#00010000B
				MOV		TH1,#0F9H
				MOV		TL1,#0C8H
				SETB	TR1
				MOV		R0,#32H
				RET
Z4:				MOV		TH0,#00H
				MOV		TL0,#01H
				SETB	TR0
Z5:				JNB		TF0,Z5
				CLR		TF0
				CLR		TR0
				MOV		IE,#10000001B
				RET
ADDRESS:		CLR		TR1
				MOV		C,P3.2
				CLR		A
				MOV		ACC.0,C
				MOV		@R0,A
				INC		R0
				DEC		R2
				CJNE	R2,#00H,Z7
				MOV		R0,#35H
				MOV		A,@R0
				CJNE	A,#00H,Z4
				ACALL	DISPLAY
				RET
Z7:				MOV		TH1,#0F9H
				MOV		TL1,#0C8H
				SETB	TR1
				RET
DISPLAY:		MOV		30H,#00H
				MOV		R0,#30H
				MOV		R2,#0EH
				CLR		IE.7
DISP:			MOV		A,@R0
				ACALL	DAT
				ACALL	DELAY
				ACALL	DELAY
				ACALL	DELAY
				INC		R0
				CLR		A
				DJNZ	R2,DISP
				MOV		TMOD,#01H
				MOV		TH0,#00H
				MOV		TL0,#00H
				SETB	TR0
Z11:			JNB		TF0,Z11
				CLR		TF0
				CLR		TR0
				ACALL	DELAY
				ACALL	DELAY
				ACALL	DELAY
				ACALL	DELAY
				ACALL	DELAY
				ACALL	DELAY
				ACALL	DELAY
				ACALL	DELAY
				ACALL	DELAY
				ACALL	DELAY
				ACALL	DELAY
				ACALL	DELAY
				ACALL	DELAY
				ACALL	DELAY
				ACALL	DELAY
				ACALL	DELAY
				ACALL	DELAY
				ACALL	DELAY
				ACALL	DELAY
				ACALL	DELAY
				ACALL	DELAY
				ACALL	DELAY
				ACALL	DELAY
				ACALL	DELAY
				ACALL	DELAY
				ACALL	DELAY
				ACALL	DELAY
				ACALL	DELAY
				ACALL	DELAY
				ACALL	DELAY
				ACALL	DELAY
				ACALL	DELAY
				ACALL	DELAY
				ACALL	DELAY
				ACALL	DELAY
				ACALL	DELAY
				ACALL	DELAY
				MOV		A,#01H
				ACALL	CMD
				MOV		IE,#10000001B
				RET
DAT:			ADD		A,#30H
				MOV 	P2,A
				SETB 	P0.0
				CLR 	P0.1
				SETB 	P0.2
				ACALL 	DELAY
				CLR 	P0.2
				RET				
				ORG		300H
LCDCMD:			DB		38H,0EH,01H,80H,06H,0
				END