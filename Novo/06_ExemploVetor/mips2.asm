.data
	x: .word 1,2,3,4,5

.text
	#Coloca em $t0 o endere�o base do vetor x
	# Coloca em $t1 o conte�do do que est� na primeira posi��o(0) do vetor x ( j� que $t0 guarda o endere�o base de x)
	la $t0,x
	lw $t1, 0($t0)
	
	#Imprimir
	li $v0,1
	move $a0,$t1 #move -> usado para mover o conte�do de um reg para outro reg
	syscall