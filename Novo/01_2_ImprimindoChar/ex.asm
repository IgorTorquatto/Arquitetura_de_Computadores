.data 
	x: .asciiz "c"
	
.text
	la $a0,x
	li $v0,4
	syscall