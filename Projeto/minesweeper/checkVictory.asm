.include "macros.asm"

.globl checkVictory

checkVictory:
 
	save_context
	
	move $s0,$a0 #board
	li $t0,0  #contador
	
	li $t1,0 #i
	
	laco_i:
	li $t2,SIZE #size
	bge $t1,$t2,fim_laco_i
	
	li $t3,0 #j
	
	laco_j:
	li $t2,SIZE
	bge $t3,$t2,fim_laco_j
	
	sll $t4,$t1,5 #multiplica o i por 8
	sll $t5,$t3,2 #multiplica j por 4
	add $t6,$t4,$t5#soma os dois 
	add $s1,$t6,$s0 #montando &board[i][j] 
	lw  $s2,0($s1) #montando board[i][j](conteúdo)
	
	blt $s2,$zero,branch_do_if
	
	addi $t0,$t0,1 #count++
	addi $t3,$t3,1 #j++
	j laco_j
	
branch_do_if:
	addi $t3,$t3,1 #j++
	j laco_j
	
fim_laco_j:
	addi $t1,$t1,1
	j laco_i

fim_laco_i:
	# if (count < SIZE * SIZE - BOMB_COUNT)
	mul $t7,$t2,$t2 #size * size
	li $t2,-10
	add $t7,$t7,$t2
	bge $t0,$t7,_branch_if
	
	li $v0,0
	restore_context
	jr $ra

_branch_if:
	li $v0,1
	restore_context
	jr $ra