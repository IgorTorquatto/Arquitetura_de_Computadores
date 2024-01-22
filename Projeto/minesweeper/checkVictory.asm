.include "macros.asm"

.globl checkVictory

checkVictory:
    save_context

    move $s0, $a0  # board

    li $t0, 0      # count = 0
    li $t1, 0      # i = 0

    laco_i_checkVictory:
        li $t2, SIZE
        bge $t1, $t2, final_laco_i_checkVictory

        li $t3, 0  # j = 0

        laco_j_checkVictory:
            li $t2, SIZE
            bge $t3, $t2, final_laco_j_checkVictory

            sll $t4, $t1, 5  # multiplica i por 32 (tamanho de uma linha)
            sll $t5, $t3, 2  # multiplica j por 4 (tamanho de uma palavra)
            add $t6, $t4, $t5  # soma os dois resultados
            add $t6, $t6, $s0  # montando board[i][j] ao somar com o endereço base do tabuleiro

            blt $t6, $zero, else_lacos_checkVictory

            addi $t0, $t0, 1
            addi $t3, $t3, 1
            j laco_j_checkVictory

        final_laco_j_checkVictory:
        addi $t1, $t1, 1  # i aumenta 1
        j laco_i_checkVictory

    final_laco_i_checkVictory:
    li $t2, SIZE
    li $t7, BOMB_COUNT
    mul $t2, $t2, $t2  # SIZE * SIZE
    sub $t2, $t2, $t7  # SIZE * SIZE - BOMB_COUNT

    blt $t0, $t2, else_lacos_checkVictory

    li $v0, 1        # Se chegou aqui, então a vitória foi alcançada, retorna 1
    j final_checkVictory

    else_lacos_checkVictory:
    li $v0, 0        # Se chegou aqui, então a vitória não foi alcançada, retorna 0

    final_checkVictory:
    restore_context
    jr $ra
