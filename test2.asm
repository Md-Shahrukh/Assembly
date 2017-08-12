	org 00h
 main:   CPL P1.5
		Acall delay
		sjmp main
		
delay: push 00
		NOP
		NOP
		ret
		end