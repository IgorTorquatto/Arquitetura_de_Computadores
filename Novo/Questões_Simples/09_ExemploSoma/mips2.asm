#a $s1 d $s4
# d[3]=d[2]+a
.text
	
# Carrega o valor de a em $t0
lw $t0, 0($s1)     # Carrega o valor de 'a' em $t0

# Carrega o valor de d[2] em $t1
lw $t1, 8($s4)     # Supondo que cada elemento de d tem 4 bytes de tamanho, carrega o valor de 'd[2]' em $t1

# Soma d[2] com a e armazena em $t1
add $t1, $t1, $t0  # Soma 'a' com 'd[2]' e armazena em $t1

# Armazena o resultado de d[2]+a em d[3]
sw $t1, 12($s4)    # Supondo que cada elemento de d tem 4 bytes de tamanho, armazena o resultado em 'd[3]'
