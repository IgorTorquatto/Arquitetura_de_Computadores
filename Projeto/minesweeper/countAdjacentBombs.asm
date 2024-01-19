.include "macros.asm"

.globl countAdjacentBombs

countAdjacentBombs:
# your code here
	save_context
	
	move $s0,$a0 #board
	move $s1,$a1 #row
	move $s2,$a2 #column
	
	li $t0, 0  #contador = 0
	subi $s3,$s1,1 # i = $s3
	
	begin_for_i_it_count:
	addi $t1, $s1,1  #row + 1;
	bgt $s3, $t1, end_for_i_it_count
	subi $s4,$s2,1  #criando o j   #se tá aqui é porque i <= row + 1
	
	
	begin_for_j_it_count:
	addi $t1,$s2,1  #column +1
	li $t2, SIZE
	li $t3, -1
	sll $t4,$s3,5 #multiplica a linha  por 8
	sll $t5,$s4,2 #multiplica coluna por 4
	add $t4,$t4,$t5
	add $t4,$t4,$s0 #montando board[i][j]
	
	
	bgt $s4,$t1,end_for_j_it_count
	blt $s3,$zero,fake_else_count   # i < 0
	bge $s3,$t2,fake_else_count    # i>= size
	blt $s4,$zero,fake_else_count   # j < 0
	bge $s4,$t2,fake_else_count     # j>= size
	bne $t4,$t3,fake_else_count   # board[i][j] != -1
	
	addi $t0,$t0,1  #i >= 0 && i < SIZE && j >= 0 && j < SIZE && board[i][j] == -1 count ++
	addi $s4,$s4,1
	j begin_for_j_it_count
	
	
end_for_j_it_count:
	addi $s3, $s3, 1  # i aumenta 1
  	j begin_for_i_it_count

end_for_i_it_count:
	move $v0,$t0
  	restore_context
 	jr $ra 
 	
fake_else_count:
	addi $s4,$s4,1
	j begin_for_j_it_count
	
