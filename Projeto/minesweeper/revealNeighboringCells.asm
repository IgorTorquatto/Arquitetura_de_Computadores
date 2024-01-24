.include "macros.asm"

.globl revealNeighboringCells

revealNeighboringCells:
	save_context
	
	move $s0,$a0 #board
	move $s1,$a1 #row
	move $s2,$a2 #column
	
	li $t0,0
	addi $t0, $s1,-1 #int i = row - 1
	
	laco_i:
	addi $t1,$s1,1 #row + 1
	bgt $t0,$t1,final_laco_i # Se i >  row + 1 sai do laço de i
	
	# Se tá aqui então  i <= row + 1
	
	addi $t2,$s2,-1 #int j = column - 1;
	
	laco_j:
	addi $t3,$s2,1 #column + 1
	bgt $t2,$t3,final_laco_j
	
	# Se tá aqui então  j <= column + 1
	li $t4,SIZE
	li $t8,-2
	
	sll $t5,$t0,5 #multiplica i  por 8
	sll $t6,$t2,2 #multiplica j por 4
	add $t7,$t5,$t6 #adiciona os dois
	add $s3,$t7,$s0 #montando  &board[i][j]
	lw $s4,0($s3) #montando  board[i][j] (conteúdo)
	
	blt $t0,$zero, fake_else_j #i < 0
	bge $t0,$t4, fake_else_j # i>=Size
	blt $t2,$zero,fake_else_j # j < 0
	bge $t2,$t4,fake_else_j # j>= size
	bne $s4,$t8,fake_else_j  # board[i][j] != -2
	
	
	#Se tá aqui então i >= 0 && i < SIZE && j >= 0 && j < SIZE && board[i][j] == -2
	move $a0,$s0 #board
	move $a1, $s1 #row
	move $a2 , $s2 #column
	jal countAdjacentBombs
	move $t9,$v0
	sw $t9, 0 ($s3) #board[i][j] = x
	
	
	beq $t9,$zero,reveal
	
	j fake_else_j
		
reveal:
	move $a0,$s0 #board
	move $a1, $s1 #row
	move $a2 , $s2 #column
	jal revealNeighboringCells	
	
	
fake_else_j:
	addi $t2,$t2,1 #j++
	j laco_j
		
	
final_laco_i:
	restore_context
	jr $ra
	
final_laco_j:
	addi $t0,$t0,1 #i++
	j laco_i
	
