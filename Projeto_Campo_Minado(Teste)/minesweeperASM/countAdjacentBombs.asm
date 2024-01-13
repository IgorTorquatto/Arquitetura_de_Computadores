.include "macros.asm"

.globl countAdjacentBombs

countAdjacentBombs:
    save_context
    move $s0, $a0  # Ponteiro para o tabuleiro
    move $s1, $a1  # Linha da c�lula
    move $s2, $a2  # Coluna da c�lula

    li $s3, 0  # Inicializar contador de bombas adjacentes

    # Verificar c�lulas vizinhas
    li $s4, -1  # Iniciar verifica��o da c�lula acima da c�lula atual
    begin_for_i_cab:
        li $t0, 3
        bge $s4, $t0, end_for_i_cab

        li $s5, -1  # Iniciar verifica��o da c�lula � esquerda da c�lula atual
        begin_for_j_cab:
            li $t0, 3
            bge $s5, $t0, end_for_j_cab

            bnez $s4, not_top_row  # Se a c�lula atual n�o estiver na primeira linha
            beqz $s5, not_left_column  # Se a c�lula atual n�o estiver na primeira coluna

            # Se a c�lula atual n�o estiver na primeira linha e coluna
            j check_cell_cab

        not_left_column:
            beqz $s5, not_top_row  # Se a c�lula atual n�o estiver na primeira coluna

            # Se a c�lula atual n�o estiver na primeira coluna
            j check_cell_cab

        not_top_row:
            bnez $s4, end_for_j_cab  # Se a c�lula atual estiver na primeira linha, pule a verifica��o

            # Se a c�lula atual estiver na primeira linha
            beqz $s5, end_for_j_cab  # Pule a verifica��o se a c�lula atual estiver na primeira coluna

        check_cell_cab:
            add $t1, $s1, $s4
            add $t2, $s2, $s5
            sll $t3, $t1, 5
            sll $t4, $t2, 2
            add $t5, $t3, $t4  # Calcular o �ndice da c�lula no tabuleiro
            add $t6, $t5, $s0  # Endere�o da c�lula no tabuleiro

            lw $t7, 0($t6)  # Valor da c�lula no tabuleiro

            li $t8, -1
            beq $t7, $t8, increment_bomb_count  # Se a c�lula cont�m uma bomba, v� para a rotina de "increment_bomb_count"

        not_bottom_row:
            addi $s5, $s5, 1
            j begin_for_i_cab

        increment_bomb_count:
            addi $s3, $s3, 1

    end_for_i_cab:

    # Armazenar o n�mero de bombas no registrador de retorno $v0
    move $v0, $s3

    end_count_adjacent_bombs:
    restore_context
    jr $ra
