	.text
	.globl __start #faz com que essa label seja visível a todos os arquivos na mesma pasta desse arquivo
__start:
	jal main #salta para a main e salv a em $ra o endereço da instrução seguinte
	nop

	li $v0 10
	syscall			# syscall 10 (exit)
