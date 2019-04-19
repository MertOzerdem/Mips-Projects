.data
	message: .asciiz "enter a number: "
	
	
.text
	.globl __start
	
__start:
	
	la $a0, message
	li $v0,4
	syscall
	
	li $v0, 5
	syscall
	
	move $t0, $v0 # x variable
	
	la $a0, message
	li $v0,4
	syscall
	
	li $v0, 5
	syscall
	
	move $t1, $v0 # y variable
	
	sub $t0, $t0, $t1
	sra $t0, $t0, 2
	
	move $a0, $t0
	
	li $v0,1
	syscall
	
	li $v0,10
	syscall