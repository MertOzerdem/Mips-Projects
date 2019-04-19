.data

.text

__start:
	li $v0, 5
	syscall
	move $a0, $v0
	
	li $v0, 5
	syscall
	move $a1, $v0 

CompareFP:
	
	sw $a0, 0($sp) ## a0 save
	addi $sp, $sp, 4
	sw $a1, 0($sp) ## a1 save

	srl $t0,$a0,31 ## sign a0
	## exponent + mantissa a0
	sll $t1, $a0, 1
	
	srl  $t2,$a1,31 ## sign a1
	## exponent + mantissa a1
	sll $t3, $a1, 1
	
	j signCompare
	
signCompare:
	bgt $t2, $t0 a1_isBigger
	bgt $t0, $t2 a0_isBigger
	beq $t0, $t2 signAreEqual

signAreEqual:
	beq $t0, 0, signArePosEqual
	beq $t0, 1, signAreNeqEqual	
	
signArePosEqual:
	bgt $t1, $t3 a1_isBigger
	bgt $t3, $t1 a0_isBigger
	beq $t1, $t3 valuesAreEqual
	
a1_isBigger:

	lw $v1, 0($sp) ## move a1
	addi $sp, $sp, -4
	lw $v0, 0($sp) ## move a0
	j exit
	
a0_isBigger:
	lw $v0, 0($sp) ## move a1
	addi $sp, $sp, -4
	lw $v1, 0($sp) ## move a0
	j exit
	
signAreNeqEqual:
	bgt $t3, $t1 a1_isBiggerNeq
	bgt $t1, $t3 a0_isBiggerNeq
	beq $t1, $t3 valuesAreEqual
	
a1_isBiggerNeq:

	lw $v0, 0($sp) ## move a1
	addi $sp, $sp, -4
	lw $v1, 0($sp) ## move a0
	j exit
	
a0_isBiggerNeq:
	lw $v1, 0($sp) ## move a1
	addi $sp, $sp, -4
	lw $v0, 0($sp) ## move a0
	j exit
	
valuesAreEqual:
	## same as a1_isBigger written for clarity
	lw $v0, 0($sp) ## move a1
	addi $sp, $sp, -4
	lw $v1, 0($sp) ## move a0
	j exit
	
exit:
	li $v0,10
	syscall
