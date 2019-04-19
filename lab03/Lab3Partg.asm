.data

.text

arraySize:
	li $v0, 5
	syscall
	move $a0, $v0
	move $t9, $v0	

fillArray:
	
	sw $a0, 0($sp)
	move $t1, $a0 # array size
	
	sll $a0, $a0, 2 ## get real size of array
	li $v0, 9
	syscall
	la $t0, 0($v0) # array adress
	la $t2, 0($v0) # array adress
	
	#addi $sp, $sp, 4
	#sw $v0, 0($sp)
	j fillTillExhaust
	
fillTillExhaust:
	
	jal get_rand_FP
        sw $v0,0($t0) # into the block
        
        addi $t0, $t0, 4 ## array word forward
        addi $t1, $t1, -1 ## size decr
        
        bnez $t1, fillTillExhaust
        
        j finishedArray
        
finishedArray:
	
	#addi $sp, $sp, -8
	la $v0, 0($t2)
        j returnArrayAdress
        
get_rand_FP:
	
	sw $ra, 0($sp)
	addi $sp, $sp, 4
	
	li $v0, 42  # generates random integer
	li $a1, 2147483647 # maximum integer value that can be represented with 32 bits
	syscall
	sw $a0, 0($sp)
	addi $sp, $sp, 4
	jal special_case
	beq $v0, 1, get_rand_FP
	j exit
	
special_case:
	
	sw $a0, 0($sp)
	addi $sp, $sp, 4 ## olmasaydýn olurduk
	sw $ra, 0($sp)
	
	sll $a0, $a0, 1
	srl $a0, $a0, 24
	
	beqz $a0, special
	beq $a0, 255, special
	j nonSpecial
	
special:
	li $v0, 1
	j case_return
	
nonSpecial:
	li $v0, 0
	j case_return
	
case_return:
	
	lw $ra, 0($sp)
	addi $sp, $sp, -4 ## olmasaydýn olurduk
	lw $a0 ,0($sp)
	addi $sp, $sp, -4 
	 
	jr $ra

exit:
	lw $v0 ,0($sp)	
	addi $sp, $sp, -4
	lw $ra, 0($sp)
	jr $ra
	
## main menu
returnArrayAdress:
	move $a0 ,$v0
	move $a1, $t9