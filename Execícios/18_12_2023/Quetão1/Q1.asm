.data
	ask: .asciiz "Introduza um n�mero: "
	
.text
	li $v0 ,4
	la $a0 , ask
	syscall