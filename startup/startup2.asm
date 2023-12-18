	.text 
	.globl main

main:
	li $v0,1 #imprima um valor inteiro que estiver em $a0
	li $a0, 5
	syscall
	jr $ra