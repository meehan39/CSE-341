.globl init
.globl rotate
.globl done

.data

prompt1:	.asciiz		"Enter a number: "
prompt2:	.asciiz		"Enter shift amount: "

.text



init:
#s0 = number
#s1 = shift amount
#t0 = counter
	addi	$v0,	$0,		4			#Set v0 to print
	lui		$a0,	0x1001				#Load prompt1 to a0
	syscall								#Print prompt1

	addi	$v0,	$0,		5			#Set v0 to read
	syscall								#Read input
	add		$s0,	$v0,	$0			#Set s0 = input

	addi	$v0,	$0,		4			#Set v0 to print
	lui		$t0,	0x1001				#Load upper address to a0
	ori		$a0,	$t0,	0x0010		#Load lower address
	syscall								#Print prompt2

	addi	$v0,	$0,		5			#Set v0 to read
	syscall								#Read input
	add		$s1,	$v0,	$0			#Set s1 = input

	add		$a0,	$s0,	$0			#Set a0 = s0
	add		$a1,	$s1,	$0			#Set a1 = s1
	add		$t0,	$0,		$0			#Set t0 = 0
	ori		$s1,	$0,		0x00000001	#Set s1 to 0x00000001
	ori		$s2,	$0,		0x80000000	#Set s2 to 0x80000000		
rotate:
#t0 = counter
#t1 = counter < shift amount
#t2 = 1 and last bit
#s0 = shifted a0
#s1 = 0x00000001
#s2 = 0x80000000
	slt		$t1,	$t0,	$a1			#Counter < shift amount
	beqz	$t1,	done
	add		$0,		$0,		$0			#NOP

	and		$t2,	$s0,	$s1			#And s0 with 1
	srl		$s0,	1					#Shift s0 right 1 bit
	beqz	$t2,	rotate
	addi	$t0,	$t0,	1			#[Delay Slot] Add 1 to counter
	or		$s0,	$s0,	$s2			#Set last bit to 1

done:
	addi	$v0,	$0,		4			#Set v0 to print
	or		$a0,	$s0,	$0			#Set a0 to s0
	syscall								#Print result

	or		$v0,	$s0,	$0			#Set v0 = s0
	jr		$ra
	add		$0,		$0,		$0






























