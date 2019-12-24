.globl main
.globl divide
.globl continue
.globl done

.data

prompt:		.asciiz		"Enter number: "

.text

#a0 = dividend
#a1 = divisor
#s0 = quotient
#s1 = remainder
#t0 = counter
#t1 = loop check
#t2 = quotient lsb
#t3 = remainder < 0

main:
	li		$v0,	4					#Print string
	la		$a0,	prompt				#Load prompt
	syscall								#Print prompt
	li		$v0,	5					#Read int
	syscall								#Read dividend
	move	$t0,	$v0					#Move dividend into s1

	li		$v0,	4					#Print string
	la		$a0,	prompt				#Load prompt
	syscall								#Print prompt

	li		$v0,	5					#Read int
	syscall								#Read multiplier

	move	$a0,	$t0					#Move s1 (dividend) into a0
	move	$a1,	$v0					#Move divisor into a1

	sll		$a1,	$a1,	16			#SLL divisor 16 bits

	li		$s0,	0					#Init product to 0
	li		$t0,	16					#Init counter to 0
	or		$s1,	$0,		$a0			#Init remainder to dividend

divide:
	sub		$s1,	$s1,	$a1			#Remainder = remainder - divisor
	slt		$t3,	$s1,	$0			#Remainder < 0
	sll		$s0,	$s0,	1			#SLL quotient 1 bit
	ori		$t2,	$0,		1			#Quotient lsb will be set to 1
	beqz	$t3,	continue			#Branch if remainder >= 0
	or		$0,		$0,		$0			#NOP

	add		$s1,	$s1,	$a1			#Remainder = remainder + divisor
	or		$t2,	$0,		$0			#Quotient lsb will be set to 0

continue:
	or		$s0,	$s0,	$t2			#Set quotient lsb to 0 or 1
	srl		$a1,	$a1,	1			#SRL divisor 1 bit
	addi	$t0,	$t0,	-1			#Decrement counter
	slti	$t3,	$t0,	0			#counter < 0
	beqz	$t3,	divide				#Branch to divide
	or		$0,		$0,		$0			#NOP

done:
	li		$v0,	1
	move	$a0,	$s0
	syscall

	li      $v0,    10              	#End Program
    syscall

















