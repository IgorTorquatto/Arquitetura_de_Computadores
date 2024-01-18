.include "macros.asm"

.text
.globl inicialializeBoard

 inicialializeBoard:

  #Salva o conteúdo dos registradores usando a função de macros.asm
  save_context
  
  move $s0, $a0  #recebe a board como argumento e guarda em $s0
  li $s1,0 # i = 0
  
  begin_for_i_it:						# for (int i = 0; i < SIZE; ++i) {
  li $t0,SIZE
  bge $s1,$t0,end_for_i_it  # se i>=8 branch para end_for_i_it ( acaba os for's)
  li $s2,0 # j = 0  #senão é porque i<8, vamos guardar em $s2 0 para inicializar o j
  
  begin_for_j_it:						# for (int j = 0; j < SIZE; ++j) {
  li $t0,SIZE
  bge $s2,$t0,end_for_j_it
  sll $t0, $s1, 5 # i*8
  sll $t1, $s2, 2 # j
  add $t0, $t0, $t1
  add $t0, $t0, $s0
  li $t1, -2
  sw $t1,0($t0)							# board[i][j] = -2; // -2 means no bomb
  addi $s2,$s2,1
  j begin_for_j_it
  
  end_for_j_it:
  addi $s1, $s1, 1
  j begin_for_i_it
  
  end_for_i_it:
  restore_context
  jr $ra 
