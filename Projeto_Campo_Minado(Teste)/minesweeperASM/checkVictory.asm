.include "macros.asm"

.globl checkVictory

checkVictory:
    save_context
    move $s0, $a0  # Ponteiro para o tabuleiro

    li $s1, 0  # Inicializar contador de c�lulas reveladas

    li $s2, 0  # i = 0
    begin_for_i_cv:
        li $t0, SIZE
        bge $s2, $t0, end_for_i_cv

        li $s3, 0  # j = 0
        begin_for_j_cv:
            li $t0, SIZE
            bge $s3, $t0, end_for_j_cv

            sll $t1, $s2, 5
            sll $t2, $s3, 2
            add $t3, $t1, $t2  # Calcular o �ndice da c�lula no tabuleiro
            add $t4, $t3, $s0  # Endere�o da c�lula no tabuleiro

            lw $t5, 0($t4)  # Valor da c�lula no tabuleiro

            li $t6, -2
            bne $t5, $t6, cell_revealed  # Se a c�lula n�o foi revelada, v� para a rotina de "cell_revealed"

            addi $s1, $s1, 1  # Incrementar contador de c�lulas reveladas

        cell_revealed:
            addi $s3, $s3, 1
            j begin_for_j_cv

        end_for_j_cv:
        addi $s2, $s2, 1
        j begin_for_i_cv

    end_for_i_cv:
    li $t7, SIZE
    mul $t8, $t7, $t7  # N�mero total de c�lulas no tabuleiro

    beq $s1, $t8, victory  # Se todas as c�lulas foram reveladas, v� para a rotina de "victory"

    li $v0, 0  # Sinalizar que o jogo ainda n�o foi vencido
    j end_check_victory

victory:
    li $v0, 1  # Sinalizar que o jogo foi vencido

end_check_victory:
    restore_context
    jr $ra
