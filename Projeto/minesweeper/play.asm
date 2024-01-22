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
	add $t0,$t0,$t1 #soma os dois 
	add $t0,$t0,$s0 #montando board[row][column] ao somar com o endereço base do tabuleiro
	
	# Se board[row][column] == -1 return 0 
	li $t1,-1 # $t1 = -1
	beq $t0,$t1,acertou_bomba  #board[row][column] == -1
	
	#Senão , temos que checar se board[row][column] == -2
	li $t1,-2
	beq $t0,$t1,countAdj #board[row][column] == -2
	
	j continuar_jogo  # Se board[row][column] não for igual nem a -1 nem a -2 deve-se continuar o jogo retornando 1
		
countAdj:
	# tem que chamar a função countAdjacentBombs e salvar o valor do seu retorno em um registrador
	move $a0,$s0 #board
	move $a1, $s1 #row
	move $a2 , $s2 #column
	jal countAdjacentBombs
	move $t2, $v0  # countAdjacentBombs retorna um número, salva esse número em $t2 e depois guarda em board[row][column]
	sw $t2,0($t0) 	#board[row][column] = x
	
	beq $t2,$zero,revealCells  # Se  o retorno da função countAdjacentBombs for zero tem que chamar a função revealAdjacentCells passando os parâmetros

	j continuar_jogo
	
revealCells:
	move $a0,$s0 #board
	move $a1, $s1 #row
	move $a2 , $s2 #column
	jal revealNeighboringCells
	
continuar_jogo:
	#Essa função continua o jogo retornando 1 e pulando para final_play
	li $v0,1
	j final_play

acertou_bomba:
	li $v0,0
	j final_play

final_play:
	restore_context
	jr $ra
