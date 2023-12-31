# f= (g+h) - (i+j)
# g s1 h s2 i s3 j s4 f s0

.text
	add $t0,$s3,$s4
	add $t1, $s1,$s2
	sub $s0,$t1,$t0