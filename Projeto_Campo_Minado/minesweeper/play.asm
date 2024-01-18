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
	
	#if( board[row][column] == -2)

	
acertou_bomba:
	restore_context
	li $v0,0 #return 0
	jr $ra
		