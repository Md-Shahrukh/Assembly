				ORG	        00H
				MOV 		DPTR,	#NK1
	   	 X3:	MOVC		A,@ A+DPTR
				JZ 			SK3
				ACALL 		SEND
				INC			DPTR
				CLR			A
				SJMP 		X3
				
        SK3:    MOV 		DPTR,   #NK2
		 X4:	MOVC		A,@ A+DPTR
				JZ 			SK4
				ACALL 		SEND
				INC			DPTR
				CLR			A
				SJMP 		X4
		
        SK4:    MOV 		DPTR,   #NK3
		 X5:	MOVC		A,@ A+DPTR
				JZ 			BYE1
				ACALL 		SEND
				INC			DPTR
				CLR			A
				SJMP 		X5		
	  BYE1:     SJMP        BYE1				

	  SEND:	    MOV			TMOD ,#20H
				MOV  		TH1,#-3
				SETB		TR1
				MOV         SCON,#50H
				MOV			SBUF,A
       X31:		JNB			TI,X31
				CLR 		TI
				RET
				

				
       NK1:     DB 			"AT+CMGF=1",0
	   NK2:     DB			"AT+CMGS=7077113709",0
       NK3:     DB			"SILICON INSTITUTE OF TECHNOLOGY",0
	   BYE:				
END