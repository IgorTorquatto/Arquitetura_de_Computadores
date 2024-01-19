.include "macros.asm"

.globl countAdjacentBombs

countAdjacentBombs:
# your code here
        save_context
	move $s0,$a0 #board
	move $s1,$a1 #linha
	move $s2,$a2 #coluna
	
	li $t0,0  #guarda em $t0 o número de bombas adjacentes
	
	li $t1, -1  #valor para indicar a presença de uma bomba na célula
	
	# Loop para percorrer as células ao redor
	# Começando da linha anterior até a próxima linha
	# E começando da coluna anterior até a próxima coluna
        # (Total de 3x3 = 9 células)
        move $t2,$s1
        subi $t2,$t2,1  # Inicia da linha anterior
        blez $t2, skip_row_loop # Certifica-se de que a linha anterior existe
	
row_loop:
	move $t3,$s2 
	subi $t3,$t3,1  # Inicia da coluna anterior
	blez $t3, skip_column_loop  # Certifica-se de que a coluna anterior existe

column_loop:
	# Verifica se a célula está dentro dos limites do tabuleiro
        bgez $t2, check_row
        j skip_row_loop
        
check_row:
        blt $t2, SIZE, check_column
        j skip_row_loop
        
check_column:
        blt $t3, SIZE, check_cell
        j skip_column_loop

check_cell:
        sll $t4, $t2, 5  # Multiplica a linha por 8 (shift left by 5)
        add $t4, $t4, $t3  # Adiciona a coluna
        add $t4, $t4, $s0  # Adiciona o endereço da matriz
        lw $t5, 0($t4)  # Carrega o valor da célula
        
         # Verifica se a célula contém uma bomba
        beq $t5, $t1, increment_bomb_count
        
skip_column_loop:
	bge $t3, SIZE, end_column_loop  # Verifica se atingiu o limite das colunas
	addi $t3, $t3, 1  # Incrementa a coluna
	j column_loop  # Salta de volta para o loop da coluna se ainda houver colunas a serem verificadas


increment_bomb_count:
        addi $t0, $t0, 1  # Incrementa o número de bombas adjacentes

skip_row_loop:
        addi $t2, $t2, 1  # Incrementa a linha
        bnez $t2, row_loop  # Salta de volta para o loop da linha se ainda houver linhas a serem verificadas

        # Retorna o número de bombas adjacentes
        move $v0, $t0

        # Restaura o contexto antes de retornar
        restore_context
        jr $ra
        
end_column_loop:
        

	
	
