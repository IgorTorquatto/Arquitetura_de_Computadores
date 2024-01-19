.include "macros.asm"

.globl play

play:
# your code here
	save_context 
	move $s0,$a0 #board
	move $s1,$a1 #row
	move $s2,$a2 #column
	
	#board[row] [column]
	sll $t0,$s1,5 #multiplica a linha digitada pelo usu?rio por 8
	sll $t1,$s2,2 #multiplica coluna por 4
	add $t0,$t0,$t1
	add $t0,$t0,$s0 #montando board[row][column]
	
	li $t1,-1 # $t1 = -1
	beq $t0,$t1,acertou_bomba  #board[row][column] == -1
	
	li $t1,-2
	beq $t0,$t1,countAdj #board[row][column] == -2
	
	j continuar_jogo
		
countAdj:
	# tem que chamar a função countAdjacentBombs e salvar o valor do seu retorno em um registrador
	move $a0,$s0
	move $a1, $s1
	move $a2 , $s2
	jal countAdjacentBombs
	move $t2, $v0
	sw $t2,0($t0) 		#board[row][column] = x
	
	beq $t2,$zero,revealCells

	j continuar_jogo
	
revealCells:
	move $a0,$s0
	move $a1, $s1
	move $a2 , $s2
	jal revealNeighboringCells
	
continuar_jogo:
	li $v0,1
	j final_play

acertou_bomba:
	li $v0,0
	j final_play

final_play:
	restore_context
	jr $ra