.include "macros.asm"

.globl play

play:
	save_context
	move $s0,$a0 #linha
	move $s1,$a1 #coluna
	move $s2,$a2 #board
	
	
	#board[row] [column]
	sll $t0,$s0,5 #multiplica a linha digitada pelo usuário por 8
	sll $t1,$s1,2 #multiplica coluna por 4
	add $t0,$t0,$t1
	add $t0,$t0,$s2 #montando board[row][column]
	
	#if( board[row][column] == -1)
	
	li $t2,-1
	beq $t2,$t0,acertou_bomba
	
	#verificar se a célula já foi revelada
	bgez $t0,ja_revelada   # se a célula já foi revelada branch
	
	#Contagem do número de bombas adjacentes
	#Passando os argumentos antes de ir para a função countAdjacentBombs
	move $a0,$s2 #endereço da matriz
	move $a1,$s0 #linha
	move $a2,$s1 # coluna
	jal countAdjacentBombs
	move $t1,$v0  #move para $t1 a quantidade de bombas adjacentes
	
	sw $t1,0($s2) #para marcar a célula como revelada
	
	#Se não há bombas adjacentes, revela as células adjacentes recursivaemnte
	beqz $t1,revela_celulas_adjacentes
	
	#Não há bombas adjacentes, encerra função
	j end_play
	
acertou_bomba:
	li $v0,0 #return 0
	j end_play


ja_revelada:
	li $v0,1 #retorna 1 para indicar que a célula já foi revelada
	j end_play

#Função para revelar as células adjacentes recursivamente
revela_celulas_adjacentes:
	move $a0,$s2 #endereço da matriz
	move $a1,$s0 #linha
	move $a2,$s1 # coluna
	jal revealNeighboringCells #chama a função
	
end_play:
	restore_context
	jr $ra
	#restaura o contexto e volta pra main
		
