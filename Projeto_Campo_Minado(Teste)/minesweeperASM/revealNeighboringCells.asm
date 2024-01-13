.include "macros.asm"

.globl revealNeighboringCells

revealNeighboringCells:
    save_context
    move $s0, $a0  # Ponteiro para o tabuleiro
    move $s1, $a1  # Linha da c�lula a ser revelada
    move $s2, $a2  # Coluna da c�lula a ser revelada

    jal revealCell  # Revelar a c�lula atual
    beqz $v0, end_reveal_cells  # Se a c�lula cont�m uma bomba, saia

    # Verificar c�lulas vizinhas
    li $s3, -1  # Iniciar verifica��o da c�lula acima da c�lula atual
    begin_for_i_rc:
        li $t0, 3
        bge $s3, $t0, end_for_i_rc

        li $s4, -1  # Iniciar verifica��o da c�lula � esquerda da c�lula atual
        begin_for_j_rc:
            li $t0, 3
            bge $s4, $t0, end_for_j_rc

            bnez $s3, not_top_row  # Se a c�lula atual n�o estiver na primeira linha
            beqz $s4, not_left_column  # Se a c�lula atual n�o estiver na primeira coluna

            # Se a c�lula atual n�o estiver na primeira linha e coluna
            j check_cell_rc

        not_left_column:
            beqz $s4, not_top_row  # Se a c�lula atual n�o estiver na primeira coluna

            # Se a c�lula atual n�o estiver na primeira coluna
            j check_cell_rc

        not_top_row:
            bnez $s3, end_for_j_rc  # Se a c�lula atual estiver na primeira linha, pule a verifica��o

            # Se a c�lula atual estiver na primeira linha
            beqz $s4, end_for_j_rc  # Pule a verifica��o se a c�lula atual estiver na primeira coluna

        check_cell_rc:
            add $t1, $s1, $s3
            add $t2, $s2, $s4
            jal revealCell  # Revelar a c�lula vizinha

        not_bottom_row:
            addi $s3, $s3, 1
            j begin_for_i_rc

    end_for_i_rc:

end_reveal_cells:
    restore_context
    jr $ra
