WMCON    EQU     96H
	
			ORG 00H
			MOV A,#31H
			MOV WMCON,#00011010B
			MOV DPTR,#100H
			MOVX @DPTR,A
			ACALL X1
			MOV WMCON,#00001010B
			MOV TMOD,#20H
			MOV TH1,#-3
			SETB TR1
			MOV SCON,#50H
			CLR A
			;MOV WMCON,#00001010B
			MOV DPTR,#100H
			MOVX A,@DPTR
			MOV SBUF,A
			ACALL X2
			SJMP $
X1:			MOV R0,WMCON
			CJNE R0,#00011010B,X1
			RET
X2:			JNB TI,X1
			CLR TI
			RET
			
			END
				