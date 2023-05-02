#A = C[0] << 4;

lw $t0, 0 ($s1)
sll $t0,$t0,4
sw $t0, 0 ($t1)
