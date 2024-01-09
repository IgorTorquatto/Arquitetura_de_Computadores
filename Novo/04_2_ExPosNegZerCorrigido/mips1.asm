.data
    msg1: .asciiz "O número é positivo.\n"
    msg2: .asciiz "O número é negativo.\n"
    msg3: .asciiz "O número é zero.\n"
    ask: .asciiz "Digite um número inteiro: \n"

.text
    #Imprime a mensagem para o usuário digitar algum número
    li $v0, 4
    la $a0, ask
    syscall

    #Comando para ler um número inteiro
    li $v0, 5
    syscall
    
    #Guarda o valor que o usuário entregou de v0 para t0
    add $t0, $v0, $zero

    slt $t1, $t0, $zero   # Verifica se é negativo
    beq $t1, $zero, _check_zero # Se t1==1 é porque  t0 é negativo se t1==0 ou t0 é 0 ou é positivo

    # Se for negativo, imprime a mensagem correspondente e termina o programa
    # Se não tiver saltado ainda, é porque t0 só pode ser negativo
    li $v0, 4
    la $a0, msg2
    syscall
    j _end_program

_check_zero:
    beq $t0, $zero, _zero   # Se for zero, imprime a mensagem correspondente
    bgt $t0, $zero, _positive   # Se for positivo, imprime a mensagem correspondente

_positive:
    li $v0, 4
    la $a0, msg1
    syscall
    j _end_program

_zero:
    li $v0, 4
    la $a0, msg3
    syscall

_end_program:
    li $v0, 10
    syscall
