.globl main
.globl multiply
.globl done

.data

prompt:		.asciiz		"Enter number: "

.text

#a0 = multiplicand
#a1 = multiplier
#s0 = product
#s1 = perminant multiplicand
#t0 = counter
#t1 = loop check
#t2 = multiplier lsb
#t3 = old multiplicand

main:
	li		$v0,	4					#Print string
	la		$a0,	prompt				#Load prompt
	syscall								#Print prompt
	li		$v0,	5					#Read int
	syscall								#Read multiplicand
	move	$s1,	$v0					#Move multiplicand into s1

	li		$v0,	4					#Print string
	la		$a0,	prompt				#Load prompt
	syscall								#Print prompt

	li		$v0,	5					#Read int
	syscall								#Read multiplier

	move	$a0,	$s1					#Move s1 (multiplicand) into a0
	move	$a1,	$v0					#Move multiplier into a1

	li		$s0,	0					#Init product to 0
	li		$t0,	0					#Init counter to 0

multiply:
	slti	$t1,	$t0,	16			#Finish loop once t0 = 16
	beqz	$t1,	done
	or		$0,		$0,		$0			#NOP

	andi	$t2,	$a1,	1			#t2 = multiplier lsb
	or		$t3,	$0,		$a0			#t3 = multiplicand

	sll		$a0,	$a0,	1			#SLL multiplicand 1 bit
	srl		$a1,	$a1,	1			#SRL multiplier 1 bit

	addi	$t0,	$t0,	1			#Increment counter

	beqz	$t2,	multiply			#Branch back to multiply if lsb is 0
	or		$0,		$0,		$0			#NOP

	add		$s0,	$s0,	$t3			#Product = product + multiplicand
	j 		multiply					#Jump back to multiply
	or		$0,		$0,		$0			#NOP


done:
	li		$v0,	1
	move	$a0,	$s0
	syscall

	li      $v0,    10              	#End Program
    syscall