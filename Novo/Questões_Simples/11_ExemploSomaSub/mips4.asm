# g s1 h s2 i s3 j s4 f s0
# f=g+(h-5)

.text 
	addi $t0,$zero,5
	sub $s2,$s2,$t0
	add $s0,$s2,$s1
	