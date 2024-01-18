.include "macros.asm"

.globl countAdjacentBombs

countAdjacentBombs:
# your code here
        save_context
	move $s0,$a0 #linha
	move $s1,$a1 #coluna
	move $s2,$a2 #board
	
	