#B[8] = A[i] + A[j]

sll $s3,$s3,2
add $t0,$s3,$s6  #t0= &
lw $t1,0($t0)  t1= A[i]

sll $s4,$s4,2
add $t2,$s4,$s6  #t2= &
lw $t3,0($t2)  t3= A[j]

add $t4,$t1,$t3
sw $t4,32($s7)