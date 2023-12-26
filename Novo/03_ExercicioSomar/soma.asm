#Somar e imprimir
.data
	num1: .word 3
	num2: .word 4
	result: .word 0

.text
	#Soma
	lw $t0,num1
	lw $t1,num2
	add $t3,$t0,$t1
	
	#Guarda
	sw $t3, result
	
	#Imprime
	li $v0,1
	lw $a0,result
	syscall