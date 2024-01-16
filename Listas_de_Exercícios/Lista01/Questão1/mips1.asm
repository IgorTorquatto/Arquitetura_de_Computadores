#Pretende-se escrever um programa. em linguagem assembly, que implemente a expressão
#aritmética y = 2x + 8. Supondo que o valor de x é passado através do registo $t0 do
#CPU e que o resultado é depositado no registo $t1.
.text
.globl main
main: 
	ori $t0,$0,3 # $t0 = x (substituir val_x pelo # valor de x pretendido) val_x = 3
	ori $t2,$0,8 # $t2 = 8
	add $t1,$t0,$t0 # $t1 = x + x = 2 * x
	add $t1,$t1,$t2 # $t1 = y = 2 * x + 8
	jr $ra # fim do programa