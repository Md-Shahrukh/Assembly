			WMCON EQU 96H
			ORG 00H
			MOV TMOD,#20H
			MOV TH1,#-3
			SETB TR1
			MOV SCON,#50H
			MOV WMCON,#00001010B
			MOV DPTR,#100H
			MOVX A,@DPTR
			MOV SBUF,A
			ACALL X1
			SJMP $
				
X1:			JNB TI,X1
			CLR TI
			RET
			
			END