###################################################################
##	Mert Özerdem
##	Lab02 section:2
##
##	_Lab2main - a program that calls linked list utility functions,
##		 depending on user selection.  _Lab2main outputs a 
##		message, then lists the menu options and get the user
##		selection, then calls the chosen routine, and repeats
##
##	a0 - used for input arguments to syscalls and for passing the 
##		pointer to the linked list to the utility functions
##   	v0 = used for return values and for syscall
##	s0 = nextPointer and update value current pointer
##	s1 = nextPointer and update value current pointer
##	s2 = safe storage for headpointer
##
##
##
##
##      linked list consists of 0 or more elements, in 

##		dynamic memory segment (i.e. heap)

##	elements of the linked list contain 2 parts:

##		at address z: pointerToNext element (unsigned integer), 4 bytes

##		at address z+4: value of the element (signed integer), 4 bytes

##
##

###################################################################
#
#					 	
#
#		text segment			
#
#						
#
####################################################################


	
	.text		
 	
	.globl _Lab2main
 

_Lab2main:		# execution starts here

	##li $s0, 0
	##li $s1, 0

	la $a0, msg2
	li $v0, 4
	syscall

	li $v0,5	# read integer 
	syscall	

	## Menu option check
	beq $v0, 1, option1
	beq $v0, 2, option2
	beq $v0, 3, option3
	beq $v0, 4, option4
	beq $v0, 5, option5
	
	## wrong input
	la $a0, msg8
	li $v0, 4
	syscall
	## return to main
	j _Lab2main

## list create function	
option1:
	jal create_list
	## may add more storage here
	addi $s2, $v0, 0 ## create list returns head pointer inside the v0 need this for future iterations
	j _Lab2main

## display function	
option2:
	
	addi $a0, $s2, 0 ## moves s0 headpointer to a0 as argument to display function
	
	jal display_list
	
	
	j _Lab2main

option3:
	
	
	j _Lab2main

option4:
	
	
	j _Lab2main

## exit function
option5:
	li $v0, 10
	syscall

###################################################################
##
#### create_list - a linked list utility routine, 
##			which creates the contents , element 
##			by element, of a linked list
##
##	s0 = linked list head pointer store
##	s1 = used for updating next pointer
##	t0 = list size + 1
##	t1 = list tracer
##	t2 = element value
##	t9 = used as temp nextPointer
##	v0 = as return value of head pointer
################################################################## 

create_list:		# entry point for this utility routine
	
	## save previous s0 and s1 values
	subi $sp, $sp, 8
	
	sw $s1, 4($sp)
	
	sw $s0, 0($sp)
	
	
	#################
	
	la $a0, msg4	# list size
	li $v0, 4
	syscall
	
	li $v0,5	# read integer 
	syscall	
	 
	addi $t0, $v0, 1 ## size + 1 tracer
	
	bgtz $v0, create_loop ## branch if size is bigger than 0
	
	li $s0, 0
	j create_exit
	
create_loop: ## go here if size > 0
	
	li $a0, 8	# Allocate 8 bytes from heap
	li $v0, 9	
	syscall
	
	li $t1, 1	# list location
	
	move $s0, $v0	# head pointer
	move $s1, $v0	# nextPointer temp
	j create_elements
	
create_elements:
	
	la $a0, msg3	#read element
	li $v0, 4
	syscall

	li $v0,5	# read integer 
	syscall	
	
	addi $t1, $t1, 1
	sw $v0, 4($s1) 
	
	bne $t0, $t1, create_continue
	
	sw $0, 0($s1)	# null pointer for last element
	j create_exit
	
create_continue:

	move $t9, $s1	#moves s1 values into t9
	
	li $a0, 8	# Allocate 8 bytes from heap
	li $v0, 9	
	syscall
	
	move $s1, $v0	#move address of allocated space to s1
	
	sw $s1, 0($t9)	#temp nextPointer create
	
	j create_elements
	
create_exit:

	addi $v0, $s0, 0 ## v0 as return value (v0 returns addres of head pointer)
	
	## load preivious s1 and s0 values 
	lw $s1, 4($sp)
	
	lw $s0, 0($sp)
	
	addi $sp, $sp, 8
	
	
	jr $ra ## returns to caller v0 as return value
	



##################################################################
#### display_list - a linked list utility routine, 
##			which shows the contents, element 
##			by element, of a linked list
##
##	s0 = nextPointer value update register
##	s1 = current pointer
##	a0 = argument value and address of the head pointer
##	v0 = for syscall
##
################################################################# 
  


display_list:		# entry point for this utility routine

	## save previous s0 and s1
	subi $sp, $sp, 8
	
	sw $s1, 4($sp)
	
	sw $s0, 0($sp)
	#####################
	
	## set head pointer
	move $s0, $a0
	move $s1, $a0

	la $a0, msg5
	li $v0, 4
	syscall
	
	j list_displayer

list_displayer:
	
	beqz $s1, display_exit ## control for null Pointer
	
	la $a0, msg6 ## nextPointer prompt
	li $v0, 4
	syscall
	
	## nextPointer print syscall 34 hexadecimal value form
	lw $t0, 0($s0)
	move $a0, $t0
	li $v0, 34
	syscall
	
	la $a0, msg7 ## value prompt
	li $v0, 4
	syscall
	
	# integer print value of current node
	lw $a0, 4($s0)
	li $v0, 1
	syscall
	
	lw $s0, 0($s1)	#loads the nextPointer address inside s0
	move $s1, $s0	#loads updates pointer
	bnez $s1, list_displayer ## control for null Pointer
	
	j display_exit
	
	
	
display_exit:

	## restores previous data and dealllocates stack
	lw $s1, 4($sp)
	lw $s0, 0($sp)
	addi $sp, $sp, 8
	
	jr $ra




################################################
#
#
#
#     	 	data segment			
#
#						
#
#
################################################


	 .data

msg1: .asciiz "The linked list has been completely displayed. \n"

msg2: .asciiz "\n1. Create a linked list \n2. Display linked list\n3. something\n4. something\n5. Quit\nEnter your choice:\n"

msg3: .asciiz "Enter an element:\n"

msg4: .asciiz "Enter Size:\n"

msg5: .asciiz "Linked list is displayed below with its contents\n"

msg6: .asciiz "\nNode's nextPointer:\t"

msg7: .asciiz "\tNode's value:\t"

msg8: .asciiz "wrong input try again\n" 
##

## end of main
