sub $t0,$s3,$s4
sll $t0,$t0,2
add $t1,$t0,$s6
lw $t2, 0($t1)
sw $t2, 32($s7)