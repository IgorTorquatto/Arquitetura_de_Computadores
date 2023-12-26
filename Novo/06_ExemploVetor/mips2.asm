.data
	x: .word 1,2,3,4,5

.text
	#Coloca em $t0 o endereço base do vetor x
	# Coloca em $t1 o conteúdo do que está na primeira posição(0) do vetor x ( já que $t0 guarda o endereço base de x)
	la $t0,x
	lw $t1, 0($t0)
	
	#Imprimir
	li $v0,1
	move $a0,$t1 #move -> usado para mover o conteúdo de um reg para outro reg
	syscall