.globl	main
.globl	timesFour
.globl	done

.data



.text

#t0 = multiplication counter
#t1 = t0 < 4
#t2 = a2 * 4
#t4 = 4

main:
	addi	$t4,	$0,		4			#Set t4 = 4
	j		timesFour					#Jump to timesFour
	add		$t0,	$0,		$0			#[Delay Slot] Set t0 = 0

timesFour:
	slt		$t1,	$t0,	$t4			#Set t1 to t0 < 4
	beqz	$t1,	done				#If t0 < 4, branch to done
	add		$0,		$0,		$0			#NOP
	add		$t2,	$t2,	$a2			#Add t2 = t2 + a2
	j		timesFour					#Jump back up to timesFour
	addi	$t0,	$t0,	1			#[Delay Slot] Add 1 to counter

done:
	add		$v0,	$t2,	$a1			#Set v0 = t2 + a1
	addi	$v0,	$v0,	-7			#Sub v0 = v0 - 7
	add		$v0,	$v0,	$a0			#Add v0 = v0 + a0
	
	jr		$ra							#Return
	add		$0,		$0,		$0			#NOP
