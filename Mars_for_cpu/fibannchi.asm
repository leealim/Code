.text
addiu $t1,$0,5
addiu $t2,$0,2
addiu $t3,$0,1
addiu $t4,$0,1
start:
beq $t1,$t2,end
add $t5,$t3,$t4
add $t3,$0,$t4
add $t4,$0,$t5
addiu $t2,$t2,1
j start
end:
add $t5,$0,$t4
xori $t6,$t5,10000
lui $t7,100
sw $t4,0
lw $t8,0
