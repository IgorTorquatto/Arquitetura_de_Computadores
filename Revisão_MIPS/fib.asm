fib:
  addi $sp, $sp, -8        # alocar espaço na pilha para $ra e $s0
  sw   $ra, 0($sp)         # armazenar $ra na pilha
  sw   $s0, 4($sp)         # armazenar $s0 na pilha
  move $s0, $a0            # armazenar o argumento $a0 em $s0

  # comparar $s0 com 0
  beq  $s0, $zero, fib0    # se $s0 == 0, vá para fib0
  addi $t0, $zero, 1       # senão, configurar $t0 = 1
  beq  $s0, $t0, fib1      # se $s0 == 1, vá para fib1

  # chamar fib(n-1)
  addi $sp, $sp, -4        # alocar espaço na pilha para $a0
  addi $s0, $s0, -1        # calcular n-1
  move $a0, $s0            # passar n-1 como argumento
  jal  fib                 # chamar fib(n-1)
  addi $sp, $sp, 4         # desalocar espaço da pilha
  move $t0, $v0            # armazenar o resultado em $t0

  # chamar fib(n-2)
  addi $sp, $sp, -4        # alocar espaço na pilha para $a0
  addi $s0, $s0, -2        # calcular n-2
  move $a0, $s0            # passar n-2 como argumento
  jal  fib                 # chamar fib(n-2)
  addi $sp, $sp, 4         # desalocar espaço da pilha

  # somar os resultados
  add  $v0, $t0, $v0       # v0 = fib(n-1) + fib(n-2)

  # restaurar $ra e $s0 da pilha e retornar
  lw   $ra, 0($sp)
  lw   $s0, 4($sp)
  addi $sp, $sp, 8
  jr   $ra

fib0:
  addi $v0, $zero, 0       # se n == 0, retornar 0
  j    end

fib1:
  addi $v0, $zero, 1       # se n == 1, retornar 1
  j    end

end:
  jr   $ra