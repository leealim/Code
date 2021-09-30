.text
lui $t1,100
add $t2,$t1,$0
sw $t2,100
lw $t3,100
addiu $t4,$t3,100
xori $t5,$t4,1




ADD	000000	100000	rd=rs+rt
LW	100011	/	LW rt, offset(base)
SW	101011	/	SW rt, offset(base)
ADDIU	001001	/	rd=rs+im£¨ÎÞ·ûºÅÊý£©
BEQ	000100	/	PC=(rs==rt)?PC+im<<2:PC
J	000010	/	PC={(PC+4)[31,28],addr,00}
LUI	001111	/	rt=im*65536
XORI	001110	/	rd=rs xor im
