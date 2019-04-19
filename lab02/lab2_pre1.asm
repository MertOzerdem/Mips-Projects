.data
	octalNo:   .asciiz "17"
.text
	.globl __start
	
__start:
 
	la $a0, octalNo
	jal   convertToDec
	j exit
# result comes in $v0	

convertToDec:

	la $s0, ($a0)
	move $v0, $0
	li $t8, 1 ## digit base count
	li $t9, 0 ## stack counter
	j secondstep
	
secondstep:

	lb $t1, 0($s0)
	beq $t1, 0x0000, turningStep
	blt $t1, 0x0030, wrongInput
	bgt $t1, 0x0038, wrongInput
	
	subi $t1, $t1, 0x0030
	sb $t1, 0($sp) ## stack for further pop
	
	addi $sp, $sp, 1 
	addi $t9, $t9, 1 ## stackcounter +1
	addi $s0, $s0, 1
	
	j secondstep

turningStep:
	addi $sp, $sp, -1
	lb $t1,0($sp)## pops and multiplies it
	addi $t9, $t9, -1
	mul $t1, $t1, $t8
	add $v0, $v0, $t1
	sll $t8, $t8, 3
	bnez $t9, turningStep
	jr $ra
	
wrongInput:

	addi $v0, $v0, -1
	jr $ra

exit:

	move $a0, $v0
	li $v0, 1
	syscall
	
	li $v0,10
	syscall
