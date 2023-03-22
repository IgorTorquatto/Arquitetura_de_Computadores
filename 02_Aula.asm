.data
	A: .word 3
	B: .word 5

.text
	#ler primeiro valor
	# 5 valor para ler
	addi $v0, $zero,5
	syscall
	move $t0,$v0
	#ler segundo valor
	addi $v0,$zero,5
	syscall
	move $t1,$v0
	#soma
	add $s1,$t0,$t1
	#escreve na tels
	addi $v0,$zero,1
	move $a0,$s1
	syscall