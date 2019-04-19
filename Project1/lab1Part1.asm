.data
	array: .space 80
	mess: .asciiz "Enter a number of elements: "
	mess2: .asciiz "Enter an element: "
	whiteSpace: .asciiz "	"
	whiteSpace2: .asciiz "\n"
	
.text
	.globl start

start:
	li $v0, 9
	syscall
	
	la $a0, mess
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	
	li $t5, 0 #average t5
	
	beq $v0,$t0, exit
	move $t0, $v0
	move $s2, $t0 # number of elements s2
	sll $t0, $t0, 2
	move $t1, $t0
	
loop:
	
	la $a0, mess2
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	
	sw $v0, array($t1)
	addi $t1, $t1, -4
	
	bne $t1, $0, loop
	################
	move $t1, $t0
	j display
	################
display:
	
	la $a0, whiteSpace
	li $v0, 4
	syscall
	
	lw $a0, array($t1)
	li $v0, 1
	syscall
	
	add $t5, $t5, $a0
	
	addi $t1, $t1, -4
	
	bne $t1, $0, display
	
	################
	div $t5, $s2
	mflo $t5
	move $t1, $t0
	la $a0, whiteSpace2
	li $v0, 4
	syscall
	
	j display2
	################
	
display2:
	
	la $a0, whiteSpace
	li $v0, 4
	syscall
	
	lw $a0, array($t1)
	sub $a0, $a0, $t5
	li $v0, 1
	syscall
	
	addi $t1, $t1, -4
	
	bne $t1, $0, display2
	
	j exit


exit:	

	li $v0, 10
	syscall