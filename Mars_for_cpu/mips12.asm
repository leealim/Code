.data
.text 
main:
	lui $t1,1
	lui $t2,2
	lui $t3,10
	add $t2,$t1,$t3
	sw $t1,($t2)
	lw $t1,($t2)
	
	j loop
exit:
	syscall
	
loop:
	addiu $t1,$t3,8
	ori $t2,$t3,12
	beq $t1,$t2,exit
	 

	


	
