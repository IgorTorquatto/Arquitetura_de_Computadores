#a= b+c
.data
	a: .word 2
	b: .word 3
	c: .word 4

.text
	lw $t0, b
	lw $t1, c
	add $t3, $t0,$t1
	sw $t3, a
	
	#Imprimindo
	li $v0,1
	move $a0,$t3
	syscall