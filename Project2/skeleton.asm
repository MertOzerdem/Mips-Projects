###################################################################
##	TODO: Write YOUR NAME!
##
##	_Lab2main - a program that calls linked list utility functions,
##		 depending on user selection.  _Lab2main outputs a 
##		message, then lists the menu options and get the user
##		selection, then calls the chosen routine, and repeats
##
##	a0 - used for input arguments to syscalls and for passing the 
##		pointer to the linked list to the utility functions
##   

##	TODO: Add other registers and their description as needed!
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


	la $a0, msg2
	li $v0, 4
	syscall

	li $v0,5	# read integer 
	syscall	

	
	



###################################################################
##
#### create_list - a linked list utility routine, 
##			which creates the contents, element 
##			by element, of a linked list
##
##	s0 = linked list head pointer store
##	s1 = used for updating next pointer
##	t0 = list size + 1
##	t1 = list tracer
##	t2 = element value
################################################################## 

create_list:		# entry point for this utility routine

	subi $sp, $sp, 8
	
	sw $s0, 0($sp)
	
	sw $s1, 4($sp)
	
	la $a0, msg4	# list size
	li $v0, 4
	syscall
	
	li $v0,5	# read integer 
	syscall	
	
	addi $t1, $0, 0  # move size
	addi $t0, $v0, 1  # move size + 1 to t0
	
	bne $v0, $0, create_loop  ## what if negative number
	
	li $v0, 0
	j exit
	
	
create_loop: ## go here if size > 0

	la $a0, msg3	#read element
	li $v0, 4
	syscall

	li $v0,5	# read integer 
	syscall	
	
	move $t2, $v0  #relocate element value
	
	addi $t1, $t1, 1
	
	li $a0, 8	# Allocate 8 bytes from heap
	li $v0, 9	
	syscall
	
	move $s0, $v0  #head pointer creation
	move $s1, $v0  #next pointer creation
	
	j create_next_element

create_next_element:

	sw $t2, 4($s0) # put the value in
	
	beq $t0, $t1, exit
	
	la $a0, msg3	#read element
	li $v0, 4
	syscall

	li $v0,5	# read integer 
	syscall	
	
	move $t2, $v0  #relocate element value
	
	

exit:






##################################################################
#### display_list - a linked list utility routine, 
##			which shows the contents, element 
##			by element, of a linked list
##
##	TODO: Add other registers and their description as needed!
##
################################################################# 
  


display_list:		# entry point for this utility routine

	













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

msg1:    .asciiz "The linked list has been completely displayed. \n"

msg2: .asciiz "1. Create a linked list \n2. Display linked list\n3. something\n4. something\n5. Quit\nEnter your choice:\n"

msg3: .asciiz "Enter an element:\n"

msg4: .asciiz "Enter Size:\n"
  
##

## end of main
