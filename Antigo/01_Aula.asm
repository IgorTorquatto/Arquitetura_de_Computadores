#dados:
.data
	A: .word 3 
	B: .word 5
#começando código
.text 
	la $s1, A
	#carregamos em s1 o valor que está em A
	lw $t0,0($s1)
	#load:dentro de t0  colocamos o valor que está dentro do  registrador s1 somado com o imediato 0, o valor é um endereço e ficará em t0
	la $s1, B
	#carregamos em s1 o valor que está em B
	lw $t1,0($s1)
	#load:dentro de t1  colocamos o valor que está dentro do  registrador s1 somado com o imediato 0, o valor é um endereço e ficará em t1
	add $s1,$t0,$t1
	#operação de soma entre t0 e t1
	addi $v0, $zero,1
	move $a0,$s1
	syscall