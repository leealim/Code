.data
	tmp: .word 0
	ans: .word 0
.text
main:
	lui	$t1, 1
	sw	$t1, tmp
	add	$t0, $0, $0
	addi $t1, $0, 1
	add $t2, $0, $t1
	addi $t3, $0, 11
forbegin:
	beq $t2, $t3, forend
	nop
	add $t0, $t0, $t1
	sll $t1, $t1, 1
	addi $t2, $t2, 1
	j	forbegin
	nop
forend:
	lw  $t1, tmp
	sub $t0, $t1, $t0
	sw  $t0, ans