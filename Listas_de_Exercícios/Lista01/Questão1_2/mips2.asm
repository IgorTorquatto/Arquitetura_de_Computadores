#Altere o programa que escreveu no ponto 1, de modo a implementar a expressão aritmética
#y = 2x – 8.
#a) Execute o programa para x=2, 3, 4 e 5 e observe os resultados no registo $t1.
.text
.globl main
main: 
	ori $t0,$0,5 # $t0 = x (substituir val_x pelo # valor de x pretendido) val_x = 5
	ori $t2,$0,8 # $t2 = 8
	add $t1,$t0,$t0 # $t1 = x + x = 2 * x
	sub $t1,$t1,$t2 # $t1 = y = 2 * x + 8
	jr $ra # fim do programa
	
#Fazer um ori do registrador $0 com qualquer outro imeidato salva o valor do imediato no registrador de destino de ori
#$t1 =2  (10-8)