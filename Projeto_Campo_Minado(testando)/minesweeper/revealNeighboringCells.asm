.include "macros.asm"

.globl revealNeighboringCells

revealNeighboringCells:

   	# Salva o contexto antes de executar a fun��o
  	save_context

  	move $s0, $a0   # $s0 guarda o endere�o da matriz (board)
  	move $s1, $a1   # $s1 guarda o valor da linha (row)
 	move $s2, $a2   # $s2 guarda o valor da coluna (column)

	# Chama a fun��o que revela a c�lula atual
        jal revealCell

        # Verifica as c�lulas ao redor da c�lula atual
        li $t1, 0  # $t1 guarda o �ndice do loop (come�a em 0)

begin_loop:
    # Calcula o deslocamento para a c�lula adjacente
    sll $t2, $t1, 2  # Multiplica o �ndice por 4 (tamanho de uma palavra)
    add $t3, $t2, $s0  # Adiciona o deslocamento ao endere�o da matriz

    # Obt�m as coordenadas da c�lula adjacente
    li $t4, 3  # N�mero de colunas (tamanho de uma linha)
    divu $t2, $t1, $t4  # Divide o �ndice pelo n�mero de colunas
    mfhi $t5  # Obt�m o quociente (linha da c�lula adjacente)
    mflo $t6  # Obt�m o resto (coluna da c�lula adjacente)

    # Calcula as novas coordenadas da c�lula adjacente
    add $t5, $s1, $t5  # Adiciona o deslocamento � linha atual
    add $t6, $s2, $t6  # Adiciona o deslocamento � coluna atual

    # Chama a fun��o recursivamente para a c�lula adjacente
    move $a0, $s0
    move $a1, $t5
    move $a2, $t6
    jal revealNeighboringCells

    # Incrementa o �ndice do loop
    addi $t1, $t1, 1
    blt $t1, 8, begin_loop  # Loop at� que todas as c�lulas adjacentes sejam verificadas

    # Restaura o contexto antes de retornar
    restore_context
    jr $ra

# Fun��o para revelar a c�lula atual
revealCell:
  lw $t0, 0($s0)   # Carrega o valor da c�lula atual
  bgez $t0, already_revealed  # Se a c�lula j� foi revelada, v� para already_revealed

  li $t1, 0
  sll $t1, $s1, 5   # Multiplica a linha por 8 (shift left by 5)
  add $t1, $t1, $s2  # Adiciona a coluna
  add $t1, $t1, $s0  # Adiciona o endere�o da matriz

  jal countAdjacentBombs  # Chama a fun��o countAdjacentBombs
  move $t2, $v0  # $t2 guarda o n�mero de bombas adjacentes

  # Marca a c�lula como revelada
  sw $t2, 0($t1)

  # Se n�o h� bombas adjacentes, continua a revela��o recursiva
  beqz $t2, continue_reveal

already_revealed:
    jr $ra  # Retorna se a c�lula j� foi revelada

continue_reveal:
    jr $ra  # Retorna
