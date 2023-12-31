# g s1 h s2 i s3 j s4 f s0 a $s6 b $s7
#B[8] = A[i-j]

.text
	sub $t0,$s3,$s4 #i-j
	sll $t0,$t0,2 # i-j * 4
	add $t1,$t0,$s6 #adicionar com a base do vetor quer dizer : &A[i-j]
	lw $t2, 0($t1) # A[i-j] valor
	sw $t2, 32($s7) # 8*4


# Em questões com vetor faz o que se quer guardar *4 , com o resultado dessa operação dentro de um registrador ( o que queremos guardar), somamos
# com a base do vetor para montar o endereço e se quisermos usar o valor devemos carregar esse endereço dentro de outro registrador utilizando a instrução lw	