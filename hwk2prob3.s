.globl	init
.globl	count
.globl	max
.globl	done

.data



.text

#s0 = a0 count
#s1 = a1 count
#s2 = a2 count
#s3 = a3 count
#s4 = 32
#t0 = a0 and 0x0001
#t1 = a1 and 0x0001
#t2 = a2 and 0x0001
#t3 = a3 and 0x0001
#t4 = loop count
#t5 = count < 32


init:
	addi	$s0,	$0,		32			#Set s0 = 32
	addi	$s1,	$0,		32			#Set s1 = 32
	addi	$s2,	$0,		32			#Set s2 = 32
	addi	$s3,	$0,		32			#Set s3 = 32
	addi	$s4,	$0,		32			#Set s4 = 32
	add		$t4,	$0,		$0			#Set t4 = 0

count:
	slt		$t5,	$t4,	$s4			#Check if count < 32
	beqz	$t5,	max					#If Count >= 0, go to max
	add		$t0,	$0,		$0			#[Delay Slot] Set t0 = 0

	andi	$t0,	$a0,	0x0001		#And a0 && 1
	andi	$t1,	$a1,	0x0001		#And a0 && 1
	andi	$t2,	$a2,	0x0001		#And a0 && 1
	andi	$t3,	$a3,	0x0001		#And a0 && 1

	sub		$s0,	$s0,	$t0			#Sub s0 = s0 - t0
	sub		$s1,	$s1,	$t1			#Sub s1 = s1 - t1
	sub		$s2,	$s2,	$t2			#Sub s2 = s2 - t2
	sub		$s3,	$s3,	$t3			#Sub s3 = s3 - t3

	srl		$a0,	$a0,	1			#Shift a0 right 1 bit
	srl		$a1,	$a1,	1			#Shift a1 right 1 bit
	srl		$a2,	$a2,	1			#Shift a2 right 1 bit
	srl		$a3,	$a3,	1			#Shift a3 right 1 bit

	j		count						#Jump back up to count
	addi	$t4,	$t4,	1			#Add 1 to loop count

max:
	#t0 = max register
	#t1 = test 1
	#t2 = test 2
	#t3 = test 3
	#t4 = t1 OR t2
	#t5 = t4 OR t3

	slt		$t1,	$s0,	$s1			#Check if s0 < s1
	slt		$t2,	$s0,	$s2			#Check if s0 < s2
	slt		$t3,	$s0,	$s3			#Check if s0 < s3
	or		$t4,	$t1,	$t2			#t1 OR t2
	or		$t5,	$t4,	$t3			#t4 OR t3
	beqz	$t5,	done
	add		$0,		$0,		$0			#NOP
	addi	$t0,	$t0,	1			#t0 = t0 + 1

	slt		$t1,	$s1,	$s0			#Check if s0 < s1
	slt		$t2,	$s1,	$s2			#Check if s0 < s2
	slt		$t3,	$s1,	$s3			#Check if s0 < s3
	or		$t4,	$t1,	$t2			#t1 OR t2
	or		$t5,	$t4,	$t3			#t4 OR t3
	beqz	$t5,	done
	add		$0,		$0,		$0			#NOP
	addi	$t0,	$t0,	1			#t0 = t0 + 1

	slt		$t1,	$s2,	$s0			#Check if s0 < s1
	slt		$t2,	$s2,	$s1			#Check if s0 < s2
	slt		$t3,	$s2,	$s3			#Check if s0 < s3
	or		$t4,	$t1,	$t2			#t1 OR t2
	or		$t5,	$t4,	$t3			#t4 OR t3
	beqz	$t5,	done
	add		$0,		$0,		$0			#NOP
	addi	$t0,	$t0,	1			#t0 = t0 + 1

done:
	add		$v0,	$t0,	$0			#Set v0 = t0
	jr 		$ra							#Return
	add		$0,		$0,		$0			#NOP





















