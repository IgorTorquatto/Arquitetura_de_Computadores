.data
	ask: .asciiz "Introduza um número: "
	
.text
	li $v0 ,4
	la $a0 , ask
	syscall