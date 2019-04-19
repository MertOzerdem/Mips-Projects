.data

.text

special_case:
	
	li $v0, 5
	syscall
	move $a0, $v0
	
	sw $a0, 0($sp)
	addi $sp, $sp, 4 ## olmasaydýn olurduk
	
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
	
	addi $sp, $sp, -4 ## olmasaydýn olurduk
	lw $a0 ,0($sp)
	
