.data 
	msg1: .asciiz "Digite um n�mero inteiro. \n"
	msg2: .asciiz "O n�mero � negativo \n"
	msg3: .asciiz "O n�mero � positivo \n"
	msg4: .asciiz "O n�mero � zero \n"
	
.text
	li $v0,4
	la $a0,msg1
	syscall
	
	li $v0,5
	syscall
	
	add $t0,$v0,$zero
	
	slt $t1,$t0,$zero #t1==1 t0 negativo t1==0 t0 zero ou positivo
	li $t2,1 #auxiliar
	beq $t1,$t2,_negativo
	beq $t0,$zero,_zero
	
	#Se n�o for nenhum dos anteriores t0 s� pode ser positivo
	li $v0,4
	la $a0,msg3
	syscall
	
	j _fim_programa

_zero:
	li $v0,4
	la $a0,msg4
	syscall
	
	j _fim_programa

_negativo:
	li $v0,4
	la $a0,msg2
	syscall
	
	j _fim_programa

_fim_programa:
	li $v0,10
	syscall	