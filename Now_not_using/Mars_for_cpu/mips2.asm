.text
main:
	lui	$t1, 1
	sw	$t1, 0
	add	$t0, $0, $0
	addiu $t1, $0, 1
l2:
	beq $t1, $t3, l1
	nop
	j	l2
	nop
l1:
	lw  $t1, 1