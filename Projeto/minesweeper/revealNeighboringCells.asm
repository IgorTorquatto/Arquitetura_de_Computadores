.include "macros.asm"

.globl revealNeighboringCells

revealNeighboringCells:
	save_context
	
	move $s0,$a0 #board
	move $s1,$a1 #row
	move $s2,$a2 #column
	
	li $s5,0
	addi $s5, $s1,-1 #int i = row - 1
	
	laco_i:
	addi $t1,$s1,1 #row + 1
	bgt $s5,$t1,final_laco_i # Se i >  row + 1 sai do la�o de i
	
	# Se t� aqui ent�o  i <= row + 1
	
	addi $s7,$s2,-1 #int j = column - 1;
	
	laco_j:
	addi $t3,$s2,1 #column + 1
	bgt $s7,$t3,final_laco_j
	
	# Se t� aqui ent�o  j <= column + 1
	li $t4,SIZE
	li $t8,-2
	
	sll $t5,$s5,5 #multiplica i  por 8
	sll $t6,$s7,2 #multiplica j por 4
	add $t7,$t5,$t6 #adiciona os dois
	add $s3,$t7,$s0 #montando  &board[i][j]
	lw $s4,0($s3) #montando  board[i][j] (conte�do)
	
	blt $s5,$zero, fake_else_j #i < 0
	bge $s5,$t4, fake_else_j # i>=Size
	blt $s7,$zero,fake_else_j # j < 0
	bge $s7,$t4,fake_else_j # j>= size
	bne $s4,$t8,fake_else_j  # board[i][j] != -2
	
	
	#Se t� aqui ent�o i >= 0 && i < SIZE && j >= 0 && j < SIZE && board[i][j] == -2
	move $a0,$s0 #board
	move $a1, $s5 #i
	move $a2 , $s7 #j
	jal countAdjacentBombs
	move $s6,$v0
	sw $s6, 0 ($s3) #board[i][j] = x
	
	
	beq $s6,$zero,reveal
	
	j fake_else_j
		
reveal:
	move $a0,$s0 #board
	move $a1, $s5 #i
	move $a2 , $s7 #j
	jal revealNeighboringCells	
	
	
fake_else_j:
	addi $s7,$s7,1 #j++
	j laco_j
		
	
final_laco_i:
	restore_context
	jr $ra
	
final_laco_j:
	addi $s5,$s5,1 #i++
	j laco_i
	
