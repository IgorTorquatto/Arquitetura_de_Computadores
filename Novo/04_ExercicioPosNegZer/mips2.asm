#Verificar se um número é positivo, negativo ou zero:
.data
	msg1: .asciiz "O número é positivo"
	msg2: .asciiz "O número é negativo"
	msg3: .asciiz "O número é zero"
	ask: .asciiz "Digite um número inteiro: \n"
	
.text
	#Pergunta ao usuário qual o número
	li $v0,4
	la $a0,ask
	syscall
	
	#Aguarda a resposta de um número inteiro
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
	
	
	