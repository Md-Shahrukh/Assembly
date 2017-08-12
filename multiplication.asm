			org 00h
			
			MOV A,R5 
			MOV B,R7 
			MUL AB   
			MOV R2,B 
			MOV R3,A 
			MOV A,R5    
 MOV B,R6    
 MUL AB      
 ADD A,R2    
 MOV R2,A    
 MOV A,B     
 ADDC A,#00h 
 MOV R1,A    
 MOV A,#00h  
 ADDC A,#00h 
 MOV R0,A    

 MOV A,R4   
 MOV B,R7   
 MUL AB     
 ADD A,R2  
 MOV R2,A   
 MOV A,B    
 ADDC A,R1  
 MOV R1,A   
 MOV A,#00h ;Load the accumulator with zero
 ADDC A,R0  ;Add the current value of R0 (plus any carry)
 MOV R0,A   ;Move the resulting answer to R1.
 MOV A,R4  ;Move R4 back into the Accumulator
 MOV B,R6  ;Move R6 into B
 MUL AB    ;Multiply the two values
 ADD A,R1  ;Add the low-byte into the value already in R1
 MOV R1,A  ;Move the resulting value back into R1
 MOV A,B   ;Move the high-byte into the accumulator
 ADDC A,R0 ;Add it to the value already in R0 (plus any carry)
 MOV R0,A  ;Move the resulting answer back to R0
MUL16_16: 
 ;Multiply R5 by R7
 MOV A,R5 ;Move the R5 into the Accumulator
 MOV B,R7 ;Move R7 into B
 MUL AB   ;Multiply the two values
 MOV R2,B ;Move B (the high-byte) into R2
 MOV R3,A ;Move A (the low-byte) into R3

 ;Multiply R5 by R6
 MOV A,R5    ;Move R5 back into the Accumulator
 MOV B,R6    ;Move R6 into B
 MUL AB      ;Multiply the two values
 ADD A,R2    ;Add the low-byte into the value already in R2
 MOV R2,A    ;Move the resulting value back into R2
 MOV A,B     ;Move the high-byte into the accumulator
 ADDC A,#00h ;Add zero (plus the carry, if any)
 MOV R1,A    ;Move the resulting answer into R1
 MOV A,#00h  ;Load the accumulator with  zero
 ADDC A,#00h ;Add zero (plus the carry, if any)
 MOV R0,A    ;Move the resulting answer to R0.

 ;Multiply R4 by R7
 MOV A,R4   ;Move R4 into the Accumulator
 MOV B,R7   ;Move R7 into B
 MUL AB     ;Multiply the two values
 ADD A,R2   ;Add the low-byte into the value already in R2
 MOV R2,A   ;Move the resulting value back into R2
 MOV A,B    ;Move the high-byte into the accumulator
 ADDC A,R1  ;Add the current value of R1 (plus any carry)
 MOV R1,A   ;Move the resulting answer into R1.
 MOV A,#00h ;Load the accumulator with zero
 ADDC A,R0  ;Add the current value of R0 (plus any carry)
 MOV R0,A   ;Move the resulting answer to R1.
 ;Multiply R4 by R6
 MOV A,R4  ;Move R4 back into the Accumulator
 MOV B,R6  ;Move R6 into B
 MUL AB    ;Multiply the two values
 ADD A,R1  ;Add the low-byte into the value already in R1
 MOV R1,A  ;Move the resulting value back into R1
 MOV A,B   ;Move the high-byte into the accumulator
 ADDC A,R0 ;Add it to the value already in R0 (plus any carry)
 MOV R0,A  ;Move the resulting answer back to R0

 ;Return - answer is now in R0, R1, R2, and R3
 RET
 ;Load the first value into R6 and R7
 MOV R6,#62h
 MOV R7,#30h
 
 ;Load the first value into R4 and R5
 MOV R4,#43h
 MOV R5,#2Eh

 ;Call the 16-bit subtraction routine
 LCALL MUL16_16 
 end