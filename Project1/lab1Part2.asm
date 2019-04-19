.data
	charSize: .space 100
	notPalindrome: .asciiz "Not a palindrome"
	isPalindrome: .asciiz "Is an palindrome"
.text
	li $v0, 8        # string read
   	la $a0, charSize   # location
    	li $a1, 100       # size
    	syscall
    	
    	li $t7, 0
    	
    	la $s0, ($a0)
    	la $s2, ($a0)
    	j size
    	
size:
	lb $s1, 0($s0)
	addi $s0, $s0, 1
	addi $t7, $t7, 1 ## char size
	bne $s1, 0x000a , size
	
	addi $t7, $t7, -2 ## minus 1 null char
	add $s2, $s2, $t7 ## last char
	la $s0, ($a0) ## adress again
	j isPalin
	
isPalin:
	## first char
	lb $s1, 0($s0)
	addi $s0, $s0, 1
	
	## sec char
	lb $s3 , 0($s2)
	addi $s2, $s2, -1
	
	bne $s1, $s3, notPalindrome2
	j palindrome
	
notPalindrome2:

	la $a0, notPalindrome
	li $v0, 4
	syscall
	
	li $v0, 10
	syscall
	
palindrome:

	la $a0, isPalindrome
	li $v0, 4
	syscall
	
	li $v0, 10
	syscall