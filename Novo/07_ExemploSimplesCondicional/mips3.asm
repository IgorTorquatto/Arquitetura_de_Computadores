.data
    a: .word 3
    b: .word 4
    m: .word 6

.text
    # Carregando valores das variáveis em registradores
    lw $t0, a
    lw $t1, b
    lw $t2, m

    # Para fazer m = a, podemos simplesmente salvar a word de a em m
    sw $t0, m

    # Comparando b e m
    slt $t3, $t1, $t2  # $t3 = 1 se b < m, senão $t3 = 0

    # Se $t3 for 1 (ou seja, b < m), então m = b
    beq $t3, $zero, skip  # Pula a instrução se $t3 for zero (b >= m)  	(Se b não for menor do que m ele leva para uma label que não tem nada escrito)
    sw $t1, m  # Armazena o valor de b em m  	(Se b<m isso será executado m=b)

skip:
    
