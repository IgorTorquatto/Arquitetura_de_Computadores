.data

.text
	li $a0, 7
	jal fib
	move $a0, $v0
	li $v0, 1
	syscall
	li $v0, 10
	syscall
	
	
fib:
	addi $sp, $sp, -12
	sw $a0, 4($sp)
	sw $ra, 0($sp)
	li $t0, 0
	slti $t0, $a0, 2
	beq $t0, $zero, else
	addi $v0, $a0, 0
	addi $sp, $sp, 12
	jr $ra
else:
	addi $a0, $a0, -1
	jal fib
	sw $v0, 8($sp)
	lw $a0, 4($sp)
	addi $a0, $a0, -2
	jal fib
	lw $v1, 8($sp)
	add $v0, $v1, $v0
	lw $a0, 4($sp)
	lw $ra, 0($sp)
	addi $sp, $sp, 12
	jr $ra
	
