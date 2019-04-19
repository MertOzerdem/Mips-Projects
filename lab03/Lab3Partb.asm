.data

.text

get_rand_FP:
	
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
	
	jr $ra

exit:
	lw $v0 ,0($sp)	
	