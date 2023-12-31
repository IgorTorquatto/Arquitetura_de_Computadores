#while (save[i] == k) i+=1
# i em $s3 k em $s5 e save em $s6
.text
_loop:
	sll $t0,$s3,2
	add $t0,$t0,$s6
	lw $t1,0($t0)
	bne $t1,$s5,_exit
	addi $s3,$s3,1
	j _loop

_exit:
	