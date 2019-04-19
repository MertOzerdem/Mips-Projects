.data
	arraySize: .asciiz "Please enter an array size:\n"
	arrayElement: .asciiz "Please enter an array element:\n"
	endl: .asciiz "\n"
	spread: .asciiz " // "
	medianValue: .asciiz "median number:\n"
	maxValue: .asciiz "Max number:\n"
	minValue: .asciiz "Min number:\n"
.text
	.globl __start

__start:
	


readArray:
		
	la $a0, arraySize
	li $v0, 4
	syscall
	
	## array size
	li $v0, 5
	syscall
	
	move $v1, $v0 ## array size
	
	mul $v0, $v0, 4
	move $t0, $v0
	
	move $a0, $v0
	li $v0, 9 
	syscall
	
	la $t1, ($v0)
	sw $v0, 0($sp)
	jal readArrayloop
	
	lw $v0, 0($sp) ## initial array adress
	
	jal bubbleSort
	move $t1, $v1
	lw $s1, 0($sp)
	
	j minMax
	
readArrayloop:
	
	la $a0, arrayElement
	li $v0, 4
	syscall
	
	## array size
	li $v0, 5
	syscall
	
	sw $v0, 0($t1) 
	
	addi $t1, $t1, 4
	
	addi $t0, $t0, -4
	beqz $t0, finreadArray	
	j readArrayloop
				
finreadArray:				
	jr $ra				
	
###################################################
##### BUBBLESORT
###################################################	

## v0 initial array adress
## v1 array size										
## t1(size)
## t2 (i)
## t3 (j)
## t4 size - i										
bubbleSort:
	
	lw $t0, 0($v0) ## temp
	move $t1, $v1 ## size
	li $t2, -1 ## i
	bnez $t1, bubbleSortloop1
	
	j return
	
return:
	jr $ra
											
bubbleSortloop1:
	
	li $t3, 0 ## j
	addi $t2, $t2, 1 ## i++
	lw $v0, 0($sp) ## adress returns the initial point
	sub $t4, $t1, $t2 ## size - i
	blt $t2,$t1, bubbleSortloop2
	
	bge $t2, $t1, return

bubbleSortloop2:
	
	addi $t3, $t3, 1 # j++
	
	blt $t3, $t4, bubbleSortif
	bge $t3, $t4, bubbleSortloop1
	
bubbleSortif:
	
	lw $s0, 0($v0)
	lw $s1, 4($v0)
	bgt $s0, $s1, bubbleChange
	j bubbleInc 

bubbleChange:

	sw $s1, 0($v0)
	sw $s0, 4($v0)
	
	
bubbleInc:
	addi $v0, $v0, 4
	j bubbleSortloop2	
	
###################################################
##### M�N MAX
###################################################

minMax:
	move $t1, $v1
	lw $v0, 0($sp)
	addi $t1, $t1, -1
	
	lw $t0, 0($v0)
	move $s6, $t0 ##min
	move $s7, $t0 ##max
	
	bnez $t1, minMaxIf
	j median ## jump median
	
minMaxIf:
	beqz $t1, median 
	addi $v0, $v0, 4
	lw $t4, 0($v0) 
	blt $s6, $t4,minimum
	bgt $s7, $t4,maximum
	
	addi $t1, $t1, -1
	j minMaxIf
	
minimum:
	lw $s6, 0($v0)
	addi $t1, $t1, -1
	beqz $t1, median 
	j minMaxIf
maximum:
	lw $s7, 0($v0)
	addi $t1, $t1, -1
	beqz $t1, median 
	j minMaxIf
	
###################################################
##### Median
###################################################

median:
	add $t1,$t1, $v1
	lw $v0, 0($sp)
	li $t2, 2
	div  $t1,$t2
	mflo $t1
	
	mul $t1, $t1, 4
	add $v0, $v0, $t1
	
	lw $s5, ($v0)
	move $t1, $v1
	j display
	
############################
## DISPLAY
###########################

display:
	lw $a0, 0($s1)
	li $v0, 1
	syscall
	
	addi $t1, $t1, -1
	addi $s1, $s1, 4
	
	la $a0, spread
	li $v0, 4
	syscall	
				
	beqz $t1, display2
	j display
	
display2:

	la $a0, endl
	li $v0, 4
	syscall
	
	la $a0, medianValue
	li $v0, 4
	syscall
	
	move $a0, $s5
	li $v0, 1
	syscall
	
	la $a0, endl
	li $v0, 4
	syscall
	
	la $a0, maxValue
	li $v0, 4
	syscall
	
	move $a0, $s6
	li $v0, 1
	syscall
	
	la $a0, endl
	li $v0, 4
	syscall
	
	la $a0, minValue
	li $v0, 4
	syscall
	
	move $a0, $s7
	li $v0, 1
	syscall
	
	j exit

exit:
	
	li $v0,10
	syscall
	
