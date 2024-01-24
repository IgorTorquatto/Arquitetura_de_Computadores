.include "macros.asm"

.globl countAdjacentBombs

countAdjacentBombs:
# your code here
	save_context
	
	move $s0,$a0 #board
	move $s1,$a1 #row
	move $s2,$a2 #column
	
	li $t0, 0  #contador = 0
	li $t1,0 # i = 0
	subi $t1,$s1,1 #i =  row - 1  
	
	begin_for_i_it_count:
	addi $t2, $s1,1  #row + 1;
	bgt $t1, $t2, end_for_i_it_count #int i = row - 1; i <= row + 1; ++i  a �nica forma de sair desse la�o for � se i > row + 1
	
	#se t� aqui � porque i <= row + 1 ent�o temos que criar o la�o do j
	subi $s4,$s2,1  #criando o j    j = column - 1;
	
	#$t1 � o i $s4 � o j 
	
	begin_for_j_it_count:
	addi $t3,$s2,1  #column +1
	bgt $s4,$t3,end_for_j_it_count # se j > column + 1 fim do la�o j
	
	# Se j <= column + 1
	li $t4, SIZE
	li $t5, -1
	
	#sll $t6,$t1,3 #multiplica i  por 6
	#add $t6,$t6,$t1  
	sll $t6,$t1,5  #multiplica i  por 8
	sll $t7,$s4,2 #multiplica j por 4
	add $t8,$t6,$t7 #adiciona os dois
	add $t9,$t8,$s0 #montando  board[i][j]
	
	
	blt $t1,$zero,fake_else_count   # i < 0
	bge $t1,$t4,fake_else_count    # i>= size
	blt $s4,$zero,fake_else_count   # j < 0
	bge $s4,$t4,fake_else_count     # j>= size
	bne $t9,$t5,fake_else_count   # board[i][j] != -1
	
	# Se chegou aqui ent�o i >= 0 && i < SIZE && j >= 0 && j < SIZE && board[i][j] == -1
	addi $t0,$t0,1  #adiciona contador
	addi $s4,$s4,1 #adiciona j
	j begin_for_j_it_count
	
	
end_for_j_it_count:
	addi $t1, $t1, 1  # i aumenta 1
  	j begin_for_i_it_count

end_for_i_it_count:
	# retorna o valor do count e volta para o fluxo do programa em play.asm
	move $v0,$t0 
  	restore_context
 	jr $ra 
 	
fake_else_count:
	addi $s4,$s4,1 #j++
	j begin_for_j_it_count
	
