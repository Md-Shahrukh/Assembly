;--------------------------------Remote control based device control-----------------------------------------------------;
;----LCD_DATA-P2, LCD_EN-P0.0, LCD_CMD-P0.1, DEVICE-P0.4 for kye-1, DEVICE-P0.5 for key-2, DEVICE-P0.6 for key-3, DEVICE-P0.7 for key-4---------;
;;;---------------------------------------------------------------------------------------------------------------------------------------------;
		
sensor 		equ		p3.2	

			org 	0000h
			ljmp 	amain
			org 	03h		
			ljmp 	sensor_int			
	
			ORG		30H

AMAIN:		ACALL		LCDCOMMAND
			ACALL		LCDDATA				;WEL COME
			ACALL		LCDCOMMAND1
			ACALL		LCDDATA1
			MOV			IE,#10000001B	
			SJMP		$

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;==============================================================================================
sensor_int:	clr 		ie.7			;disable all interrupts
			clr 		a		
			lcall 		remote_get		;data is like 0=ff,1=feh
			orl 		a,#0f0h			;make the MSB as 1111
			cpl 		a				;to get data like 0=00h,1=01h,2=02h
			cjne 		a,#01h,LEVEL5		
			CPL			P0.4
			ACALL		LCDCOMMAND
			ACALL		LCDDATA2
		
			SJMP		reset_dat	

LEVEL5:		CJNE		A,#02H,LEVEL6
			CPL			P0.5
			ACALL		LCDCOMMAND
			ACALL		LCDDATA3
			SJMP		RESET_DAT
LEVEL6:		CJNE		A,#03H,LEVEL7
			CPL			P0.6
			;ACALL		DELAY
			SJMP		RESET_DAT

LEVEL7:		CJNE		A,#04H,LEVEL8
			CPL			P0.7
			;ACALL		DELAY
			SJMP		RESET_DAT

LEVEL8:		SJMP		RESET_DAT
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;=====================================================================================================


remote_get:	lcall 		delay_3bit			;give a 1 bit delay to check AGC 2-bit
		jnb 		sensor,next_tx			;if AGC=00 then incorrect, exit 
								;if AGC=01 then correct
					
		lcall 		delay_1bit			;address bits Rx:flip bit + 5 address bits
		
			
		mov 		r7,#06h				;flip bit + addr bits = 1+5=6 bits
remote_addr:	mov 		c,sensor
		rlc 		a
		lcall 		delay_1bit
		djnz 		r7,remote_addr
		anl 		a,#00011111b			;mask the flip bit
		cjne 		a,#00h,next_tx			;if the address is not 00, then exit

								;command bits reception					
		mov 		r7,#06h				;no. of cmd bits=6
		clr 		a
		
remote_cmd:	mov 		c,sensor
		rlc 		a
		lcall 		delay_1bit
		djnz 		r7,remote_cmd
		ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;======================================================================================================

reset_dat:		

exit_int0:	lcall 		retransmit			;to avoid retransmission		
		setb 		ie.7		
		reti
;=;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;	Delay of 3/4 of bit cycle:
;	1.728ms *3/4 = 1.296ms
;---------------------------------------------------------------------------
delay_3bit:	mov 		r5,#51			;56
s_loop3:	mov 		r6,#10
		djnz 		r6,$
		djnz 		r5,s_loop3
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP	
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		ret
;=======================================================================================================

;---------------------------------------------------------------------------
next_tx:	lcall 		delay_15bit			;if error then wait for 15 bit time
		setb 		ie.7				;enable interrupts
		ret

;=========================================================================================================


;---------------------------------------------------------------------------
;	Delay of 1 bit cycle: 1.728ms
;---------------------------------------------------------------------------
delay_1bit:	mov 		r5,#69		;75
s_loop2:	mov 		r6,#10
		djnz 		r6,$
		djnz 		r5,s_loop2
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP

		ret

;============================================================================
;	Delay of 15 bit cycles:
;	1.728ms * 15 = 25.92ms
;---------------------------------------------------------------------------
delay_15bit:	mov 		r5,#204		;221,206
s_loop1:	mov 		r6,#57
		djnz 		r6,$
		djnz 		r5,s_loop1
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		ret
;============================================================================

;---------------------------------------------------------------------------
;	Delay of 130ms between retransmission
;---------------------------------------------------------------------------
retransmit:	mov 		r5,#0E9H			;0FFH
s_loop4:	mov 		r6,#0ffh
s_loop5:	mov 		r4,#02h
		djnz 		r4,$
		djnz 		r6,s_loop5
		djnz 		r5,s_loop4
		ret
;===========================================================================


LCDDATA:	CLR		A
		MOV		DPTR,#LCDDAT
LEVEL4:		MOVC		A,@A+DPTR
		JZ		LEVEL3
		ACALL		DATA1
		INC		DPTR
		CLR		A
		SJMP		LEVEL4
LEVEL3:		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;==============================================================================
LCDDATA1:	CLR		A
		MOV		DPTR,#LCDDAT1
LEVEL10:	MOVC		A,@A+DPTR
		JZ		LEVEL9
		ACALL		DATA1
		INC		DPTR
		CLR		A
		SJMP		LEVEL10
LEVEL9:		RET	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;==============================================================================
LCDDATA2:	CLR		A
		MOV		DPTR,#LCDDAT2
LEVEL14:	MOVC		A,@A+DPTR
		JZ		LEVEL13
		ACALL		DATA1
		INC		DPTR
		CLR		A
		SJMP		LEVEL14
LEVEL13:	RET	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;==============================================================================
LCDDATA3:	CLR		A
		MOV		DPTR,#LCDDAT3
LEVEL16:	MOVC		A,@A+DPTR
		JZ		LEVEL15
		ACALL		DATA1
		INC		DPTR
		CLR		A
		SJMP		LEVEL16
LEVEL15:	RET	


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;===============================================================================
LCDCOMMAND:	CLR		A
		MOV		DPTR,#LCDCOMM
LEVEL2:		MOVC		A,@A+DPTR
		JZ		LEVEL1
		ACALL		COMM
		INC		DPTR
		CLR		A
		SJMP		LEVEL2
LEVEL1:		RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;===============================================================================
LCDCOMMAND1:	CLR		A
		MOV		DPTR,#LCDCOMM1
LEVEL12:	MOVC		A,@A+DPTR
		JZ		LEVEL11
		ACALL		COMM
		INC		DPTR
		CLR		A
		SJMP		LEVEL12
LEVEL11:	RET
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;=================================================================================
COMM:	MOV		P2,A
		CLR		P0.0
		CLR		P0.1
		SETB	P0.2
		ACALL	DELAY
		CLR		P0.2
		RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;==================================================================================

DATA1:	MOV			P2,A
		SETB		P0.0
		CLR			P0.1
		SETB		P0.2
		ACALL		DELAY
		CLR			P0.2
		RET	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;==================================================================================


DELAY:		MOV		R2,#255
HERE1:		MOV		R3,#255
HERE:		DJNZ		R3,HERE	
		DJNZ		R2,HERE1
		RET		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;==================================================================================

LCDCOMM:	DB		38H,0EH,01H,06H,80H,0
LCDCOMM1:	DB		06H,0C0H,0
LCDDAT	:	DB		"    WEL COME    ",0
LCDDAT1:	DB		"NI Innovation",0
LCDDAT2:	DB		"DEVICE-1 OPERATE",0
LCDDAT3:	DB		"DEVICE-2 OPERATE",0
	

		END

