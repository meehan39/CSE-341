.globl main
.globl multiply
.globl done

.data

prompt:		.asciiz		"Enter a number: "
times:		.asciiz		" * "
plus:		.asciiz		" + "
minus:		.asciiz		" - "
equals:		.asciiz		" = "

.text

#t0 = multiplication counter
#t1 = $t0 < 6
#t2 = s5 * 6
#t3 = s3 - s2
#t4 = temp address
#t6 = 6

main:
	addi	$v0,	$0,		4			#Set v0 to print
	lui		$a0,	0x1001				#Load prompt to a0
	syscall								#Print prompt

	addi	$v0,	$0,		5			#Set v0 to read
	syscall								#Read int
	add		$s5,	$v0,	$0			#Set s5 to input

	addi	$v0,	$0,		4			#Set v0 to print
	syscall								#Print prompt

	addi	$v0,	$0,		5			#Set v0 to read
	syscall								#Read int
	add		$s3,	$v0,	$0			#Set s3 to input

	addi	$v0,	$0,		4			#Set v0 to print
	syscall								#Print prompt

	addi	$v0,	$0,		5			#Set v0 to read
	syscall								#Read int
	add		$s2,	$v0,	$0			#Set s2 to input



	addi	$t6,	$0,		6			#Set t6 = 6
	add		$t2,	$0,		$0			#Set t2 to 0
	j 		multiply					#Jump to mult
	add		$t0,	$0,		$0			#[Delay Slot] Set t0 = 0


multiply:
	slt		$t1,	$t0,	$t6			#t0 < 6
	beqz	$t1,	done				#Branches to done if t1 == 0
	add		$0,		$0,		$0			#NOP
	add		$t2,	$t2,	$s5			#Add t2 = t2 + s5
	j		multiply					#Jump back to mult
	addi	$t0,	$t0,	1			#[Delay Slot] Add 1 to t0, the multiplication counter


done:
	sub		$t3, 	$s3, 	$s2			#Subtract t3 = s3 - s2
	add		$s4,	$t2,	$t3			#Add s4 = s5 + t3

	addi	$v0,	$0,		4			#Set v0 to print
	add		$a0,	$s5,	$0			#Set a0 to s5
	syscall								#Print partial result

	lui		$t4,	0x1001				#Load upper address of " * " to a0
	ori		$a0,	$t4,	0x0010		#Load lower address of " * " to a0
	syscall								#Print " * "

	addi 	$a0,	$0,		6			#Set a0 to 6
	syscall								#print 6

	lui		$t4,	0x1001				#Load upper address of " + " to a0
	ori		$a0,	$t4,	0x0010		#Load lower address of " + " to a0
	syscall								#Print " + "

	add		$a0,	$s3,	$0			#Set a0 to s3
	syscall								#Print s3

	lui		$t4,	0x1001				#Load upper address of " - " to a0
	ori		$a0,	$t4,	0x0010		#Load lower address of " - " to a0
	syscall								#Print " - "

	add		$a0,	$s2,	$0			#Set a0 to s2
	syscall								#Print s2

	lui		$t4,	0x1001				#Load upper address of " = " to a0
	ori		$a0,	$t4,	0x0010		#Load lower address of " = " to a0
	syscall								#Print " = "

	add		$a0,	$s4,	$0			#Set a0 to s4
	syscall

	jr		$ra							#Return
	add		$0,		$0,		$0			#NOP













