.include "macros.asm"

.globl play

play:
    save_context
    move $s0, $a0  # Ponteiro para o tabuleiro
    move $s1, $a1  # Linha da jogada
    move $s2, $a2  # Coluna da jogada

    sll $t0, $s1, 5
    sll $t1, $s2, 2
    add $t2, $t0, $t1  # Calcular o índice da célula no tabuleiro
    add $t3, $t2, $s0  # Endereço da célula no tabuleiro

    lw $t4, 0($t3)  # Valor da célula no tabuleiro

    li $t5, -1
    beq $t4, $t5, hit_bomb  # Se a célula contém uma bomba, vá para a rotina de "hit_bomb"

    li $v0, 1
    move $a0, $t4
    syscall  # Imprimir o valor da célula

    li $v0, 10
    j end_play

hit_bomb:
    li $v0, 0  # Sinalizar que a jogada atingiu uma bomba
    j end_play

end_play:
    restore_context
    jr $ra
