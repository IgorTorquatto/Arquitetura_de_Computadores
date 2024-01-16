#Altere o programa que escreveu no ponto 1, de modo a implementar a expressão aritmética
#y = 2x – 8.
#a partir da entrada de valores pelo usuário
.data
	msg1: .asciiz "Digite um número inteiro para execução da função y=2x-8: \n"
	msg2: .asciiz "O número que você digitou foi: \n"
	msg3: .asciiz "\nO resultado da função foi: \n"
	num_user: .word 0
	result: .word 0
.text
	#Imprimindo mensagem para que o usuário digite um número inteiro para a função
	la $a0,msg1 
	ori $v0,$0,4
	syscall
	
	#Recebendo um número inteiro do usuário
	ori $v0,$0,5
	syscall
	
	#Guardando na memória de dados( Caso precise, o número que o usuário digitou)
	add $t0,$v0,$0
	sw $t0,num_user
	
	#Imprimindo para o usuário a mensagem de qual número ele digitou
	la $a0,msg2
	ori $v0,$0,4
	syscall
	
	#Mostrando o número digitado
	ori $v0,$0,1
	add $a0,$0,$t0
	syscall
	
	#Executando a função
	add $t1,$t0,$t0
	ori $t2,$0,8
	sub $t3, $t1, $t2
	
	#Guardando valor na memória de dados
	sw $t3,result
	
	#Imrimindo resultado da função
	la $a0,msg3
	li $v0,4
	syscall
	
	lw $a0,result
	li $v0,1
	syscall
	
	#Finalizando programa
	ori $v0,$0,10
	syscall