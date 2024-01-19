.include "macros.asm"

.globl checkVictory

checkVictory:

  	# Salva o contexto antes de executar a fun��o
  	save_context

  	move $s0, $a0   # $s0 guarda o endere�o da matriz (board)

  	li $t0, 0       # $t0 guarda o n�mero de c�lulas v�lidas reveladas, inicializado com zero

  	# Loop para percorrer todas as c�lulas da matriz
  	li $t1, 0       # $t1 guarda o �ndice do loop (come�a em 0)

begin_loop:
    sll $t2, $t1, 2   # Multiplica o �ndice por 4 (tamanho de uma palavra)
    add $t3, $t2, $s0  # Adiciona o deslocamento ao endere�o da matriz

    lw $t4, 0($t3)  # Carrega o valor da c�lula

    # Verifica se a c�lula � v�lida e j� foi revelada
    bgez $t4, valid_cell
    j skip_cell_check

valid_cell:
      bnez $t4, revealed_cell  # Se a c�lula for v�lida e j� foi revelada, v� para revealed_cell

skip_cell_check:
     addi $t0, $t0, 1  # Incrementa o n�mero de c�lulas v�lidas reveladas

revealed_cell:
     addi $t1, $t1, 1  # Incrementa o �ndice do loop
     li $t5,64  #SIZE * SIZE
     blt $t1, $t5, begin_loop  # Loop at� que todas as c�lulas sejam verificadas

    # Verifica se todas as c�lulas v�lidas foram reveladas
    subi $t5,$t5,10
    move $t2, $t5  # N�mero total de c�lulas v�lidas
    beq $t0, $t2, victory  # Se o n�mero de c�lulas reveladas for igual ao n�mero total, v� para victory

defeat:
    li $v0, 0  # Retorna 0 para indicar derrota
    j end_check_victory

victory:
    li $v0, 1  # Retorna 1 para indicar vit�ria

end_check_victory:
    # Restaura o contexto antes de retornar
    restore_context
    jr $ra