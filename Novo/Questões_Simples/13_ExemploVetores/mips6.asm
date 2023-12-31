# g s1 h s2 i s3 j s4 f s0 a $s6 b $s7
# B[g] = A[f] + A [f+1]
.text 
	#vamos primeiramente criar a primeira parte da expressão A[f] 
	sll $t0,$s0,2 #multiplica por 4
	add $t0,$t0,$s6 #soma com a base do vetor,temos o endereço
	lw $t1, 0($t0) # A[f]
	
	#vamos montar agora o B[g]
	sll $t2,$s1,2
	add $t2,$t2,$s7 #&B[g]
	
	#Para fazer a parte do A[f+1] podemos usar o endereço onde A[f] está e somar 4 o que resultaria na expressão A[f+1]
	addi $t3, $t0,4 #&A[f+1]
	lw $t4,0($t3) #A[f+1]
	
	add $t5,$t4,$t1
	sw $t5,0($t2)
	