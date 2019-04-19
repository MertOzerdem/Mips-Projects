.data
	intNumber: .word 0x000000ff
	message: .asciiz "The final result is: "
	
.text
	.globl start
start:
	
	addi $t0, $t0, 50
	addi $t1, $t1, 4
	
	add $t0, $t0, $t1
	sub $t0, $t0, $t1
	
	## division
	div $t0, $t1
	mflo $t0
	mfhi $t1
	
	## mult
	mult $t0, $t1
	mflo $t0
	mfhi $t1
	
	## shifts
	sll $t0, $t0, 3
	srl $t0, $t0, 3
	sra $t0, $t0, 3
	
	## load 32 bit value from mem
	lw $t0, intNumber
	lui $t1, 0xffff
	ori $t1,$t1, 0xfff0
	
	sw $t1, 0($sp)
	lw $t1, intNumber
	lw $t1, 0($sp)
	
	la $a0,message
	li $v0,4
	syscall
	
	move $a0, $t0
	li $v0,1
	syscall
	