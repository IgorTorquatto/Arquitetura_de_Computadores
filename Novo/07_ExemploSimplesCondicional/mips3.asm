.data
    a: .word 3
    b: .word 4
    m: .word 6

.text
    # Carregando valores das vari�veis em registradores
    lw $t0, a
    lw $t1, b
    lw $t2, m

    # Para fazer m = a, podemos simplesmente salvar a word de a em m
    sw $t0, m

    # Comparando b e m
    slt $t3, $t1, $t2  # $t3 = 1 se b < m, sen�o $t3 = 0

    # Se $t3 for 1 (ou seja, b < m), ent�o m = b
    beq $t3, $zero, skip  # Pula a instru��o se $t3 for zero (b >= m)  	(Se b n�o for menor do que m ele leva para uma label que n�o tem nada escrito)
    sw $t1, m  # Armazena o valor de b em m  	(Se b<m isso ser� executado m=b)

skip:
    
