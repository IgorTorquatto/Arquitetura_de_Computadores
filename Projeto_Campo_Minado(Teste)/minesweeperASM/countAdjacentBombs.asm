.include "macros.asm"

.globl countAdjacentBombs

countAdjacentBombs:
    save_context
    move $s0, $a0  # Ponteiro para o tabuleiro
    move $s1, $a1  # Linha da célula
    move $s2, $a2  # Coluna da célula

    li $s3, 0  # Inicializar contador de bombas adjacentes

    # Verificar células vizinhas
    li $s4, -1  # Iniciar verificação da célula acima da célula atual
    begin_for_i_cab:
        li $t0, 3
        bge $s4, $t0, end_for_i_cab

        li $s5, -1  # Iniciar verificação da célula à esquerda da célula atual
        begin_for_j_cab:
            li $t0, 3
            bge $s5, $t0, end_for_j_cab

            bnez $s4, not_top_row  # Se a célula atual não estiver na primeira linha
            beqz $s5, not_left_column  # Se a célula atual não estiver na primeira coluna

            # Se a célula atual não estiver na primeira linha e coluna
            j check_cell_cab

        not_left_column:
            beqz $s5, not_top_row  # Se a célula atual não estiver na primeira coluna

            # Se a célula atual não estiver na primeira coluna
            j check_cell_cab

        not_top_row:
            bnez $s4, end_for_j_cab  # Se a célula atual estiver na primeira linha, pule a verificação

            # Se a célula atual estiver na primeira linha
            beqz $s5, end_for_j_cab  # Pule a verificação se a célula atual estiver na primeira coluna

        check_cell_cab:
            add $t1, $s1, $s4
            add $t2, $s2, $s5
            sll $t3, $t1, 5
            sll $t4, $t2, 2
            add $t5, $t3, $t4  # Calcular o índice da célula no tabuleiro
            add $t6, $t5, $s0  # Endereço da célula no tabuleiro

            lw $t7, 0($t6)  # Valor da célula no tabuleiro

            li $t8, -1
            beq $t7, $t8, increment_bomb_count  # Se a célula contém uma bomba, vá para a rotina de "increment_bomb_count"

        not_bottom_row:
            addi $s5, $s5, 1
            j begin_for_i_cab

        increment_bomb_count:
            addi $s3, $s3, 1

    end_for_i_cab:

    # Armazenar o número de bombas no registrador de retorno $v0
    move $v0, $s3

    end_count_adjacent_bombs:
    restore_context
    jr $ra
