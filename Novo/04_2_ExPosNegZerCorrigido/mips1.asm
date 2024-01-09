.data
    msg1: .asciiz "O n�mero � positivo.\n"
    msg2: .asciiz "O n�mero � negativo.\n"
    msg3: .asciiz "O n�mero � zero.\n"
    ask: .asciiz "Digite um n�mero inteiro: \n"

.text
    #Imprime a mensagem para o usu�rio digitar algum n�mero
    li $v0, 4
    la $a0, ask
    syscall

    #Comando para ler um n�mero inteiro
    li $v0, 5
    syscall
    
    #Guarda o valor que o usu�rio entregou de v0 para t0
    add $t0, $v0, $zero

    slt $t1, $t0, $zero   # Verifica se � negativo
    beq $t1, $zero, _check_zero # Se t1==1 � porque  t0 � negativo se t1==0 ou t0 � 0 ou � positivo

    # Se for negativo, imprime a mensagem correspondente e termina o programa
    # Se n�o tiver saltado ainda, � porque t0 s� pode ser negativo
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
