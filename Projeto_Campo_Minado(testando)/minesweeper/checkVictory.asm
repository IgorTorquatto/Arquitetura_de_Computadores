.include "macros.asm"

.globl checkVictory

checkVictory:

  	# Salva o contexto antes de executar a função
  	save_context

  	move $s0, $a0   # $s0 guarda o endereço da matriz (board)

  	li $t0, 0       # $t0 guarda o número de células válidas reveladas, inicializado com zero

  	# Loop para percorrer todas as células da matriz
  	li $t1, 0       # $t1 guarda o índice do loop (começa em 0)

begin_loop:
    sll $t2, $t1, 2   # Multiplica o índice por 4 (tamanho de uma palavra)
    add $t3, $t2, $s0  # Adiciona o deslocamento ao endereço da matriz

    lw $t4, 0($t3)  # Carrega o valor da célula

    # Verifica se a célula é válida e já foi revelada
    bgez $t4, valid_cell
    j skip_cell_check

valid_cell:
      bnez $t4, revealed_cell  # Se a célula for válida e já foi revelada, vá para revealed_cell

skip_cell_check:
     addi $t0, $t0, 1  # Incrementa o número de células válidas reveladas

revealed_cell:
     addi $t1, $t1, 1  # Incrementa o índice do loop
     li $t5,64  #SIZE * SIZE
     blt $t1, $t5, begin_loop  # Loop até que todas as células sejam verificadas

    # Verifica se todas as células válidas foram reveladas
    subi $t5,$t5,10
    move $t2, $t5  # Número total de células válidas
    beq $t0, $t2, victory  # Se o número de células reveladas for igual ao número total, vá para victory

defeat:
    li $v0, 0  # Retorna 0 para indicar derrota
    j end_check_victory

victory:
    li $v0, 1  # Retorna 1 para indicar vitória

end_check_victory:
    # Restaura o contexto antes de retornar
    restore_context
    jr $ra