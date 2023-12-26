fibonacci:
    addi $sp, $sp, -8      # Decrementa o ponteiro de pilha para alocar espaço para $ra e $s0
    sw $ra, 4($sp)         # Salva o endereço de retorno na pilha
    sw $s0, 0($sp)         # Salva o valor de $s0 na pilha

    move $s0, $a0          # Move o valor de entrada (n) para $s0
    li $t0, 0              # Inicializa o primeiro termo como 0
    li $t1, 1              # Inicializa o segundo termo como 1

    beq $s0, 0, fim        # Se o n-ésimo termo for zero, pula para o fim

loop:
    bne $s0, 1, next       # Se o n-ésimo termo não for 1, pula para next

    # Caso contrário, $t1 contém o valor do primeiro termo
    add $v0, $t1, $0       # Coloca o valor de $t1 em $v0
    j fim                  # Pula para o fim da função

next:
    add $t2, $t0, $t1      # Soma os dois termos anteriores para obter o próximo termo
    add $t0, $t1, $0       # Move o segundo termo para o primeiro termo
    add $t1, $t2, $0       # Move o próximo termo para o segundo termo
    addi $s0, $s0, -1      # Decrementa o contador de iteração

    bne $s0, 0, loop       # Se o contador não for zero, pula de volta para o loop

fim:
    lw $s0, 0($sp)         # Restaura o valor de $s0 da pilha
    lw $ra, 4($sp)         # Restaura o endereço de retorno da pilha
    addi $sp, $sp, 8       # Incrementa o ponteiro de pilha para liberar espaço
    jr $ra                 # Retorna para o endereço de chamada
