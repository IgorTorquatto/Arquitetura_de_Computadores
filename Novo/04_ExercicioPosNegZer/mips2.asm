#Verificar se um n�mero � positivo, negativo ou zero:
.data
	msg1: .asciiz "O n�mero � positivo"
	msg2: .asciiz "O n�mero � negativo"
	msg3: .asciiz "O n�mero � zero"
	ask: .asciiz "Digite um n�mero inteiro: \n"
	
.text
	#Pergunta ao usu�rio qual o n�mero
	li $v0,4
	la $a0,ask
	syscall
	
	#Aguarda a resposta de um n�mero inteiro
	li $v0,5
	syscall
	
	#Guarda o valor em um registrador
	add $t0,$v0,$zero
	
	#
	slt $t1,$t0,$zero # t0<0 (negativo) grava 1 em t1
	li $t2,1
	beq $t1,$t2,_negativo
	
_negativo:
	li $v0,4
	la $a0,msg2
	syscall
	
	
	