.include "macros.asm"

.globl revealNeighboringCells

revealNeighboringCells:

   	# Salva o contexto antes de executar a função
  	save_context

  	move $s0, $a0   # $s0 guarda o endereço da matriz (board)
  	move $s1, $a1   # $s1 guarda o valor da linha (row)
 	move $s2, $a2   # $s2 guarda o valor da coluna (column)

	# Chama a função que revela a célula atual
        jal revealCell

        # Verifica as células ao redor da célula atual
        li $t1, 0  # $t1 guarda o índice do loop (começa em 0)

begin_loop:
    # Calcula o deslocamento para a célula adjacente
    sll $t2, $t1, 2  # Multiplica o índice por 4 (tamanho de uma palavra)
    add $t3, $t2, $s0  # Adiciona o deslocamento ao endereço da matriz

    # Obtém as coordenadas da célula adjacente
    li $t4, 3  # Número de colunas (tamanho de uma linha)
    divu $t2, $t1, $t4  # Divide o índice pelo número de colunas
    mfhi $t5  # Obtém o quociente (linha da célula adjacente)
    mflo $t6  # Obtém o resto (coluna da célula adjacente)

    # Calcula as novas coordenadas da célula adjacente
    add $t5, $s1, $t5  # Adiciona o deslocamento à linha atual
    add $t6, $s2, $t6  # Adiciona o deslocamento à coluna atual

    # Chama a função recursivamente para a célula adjacente
    move $a0, $s0
    move $a1, $t5
    move $a2, $t6
    jal revealNeighboringCells

    # Incrementa o índice do loop
    addi $t1, $t1, 1
    blt $t1, 8, begin_loop  # Loop até que todas as células adjacentes sejam verificadas

    # Restaura o contexto antes de retornar
    restore_context
    jr $ra

# Função para revelar a célula atual
revealCell:
  lw $t0, 0($s0)   # Carrega o valor da célula atual
  bgez $t0, already_revealed  # Se a célula já foi revelada, vá para already_revealed

  li $t1, 0
  sll $t1, $s1, 5   # Multiplica a linha por 8 (shift left by 5)
  add $t1, $t1, $s2  # Adiciona a coluna
  add $t1, $t1, $s0  # Adiciona o endereço da matriz

  jal countAdjacentBombs  # Chama a função countAdjacentBombs
  move $t2, $v0  # $t2 guarda o número de bombas adjacentes

  # Marca a célula como revelada
  sw $t2, 0($t1)

  # Se não há bombas adjacentes, continua a revelação recursiva
  beqz $t2, continue_reveal

already_revealed:
    jr $ra  # Retorna se a célula já foi revelada

continue_reveal:
    jr $ra  # Retorna
