.data 
	x: .word 3

.text
	lw $t0,x
	addi $t1,$t0,1
	sw $t1,x
	
	#finaliza
	li $v0,10
	syscall