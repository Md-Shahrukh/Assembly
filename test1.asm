	org 00h
	mov R0,#05
	mov R1,#10
	push 00
	push 01
	pop 00
	pop 01
x1:	sjmp  x1
	end