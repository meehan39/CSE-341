.globl main
.globl swap
.globl clear

#t0 = s3 < s4
#t3 = s3
#t4 = s4

main:
	add		$t3,	$s3,	$0			#Set t3 = s3
	add		$t4,	$s4,	$0			#Set t4 = s4

	add		$s3,	$0,		$0			#Clear s3
	add		$s4,	$0,		$0			#Clear s4

	slt		$t0,	$t3,	$t4			#t0 = t3 (s3) < t4 (s4)
	beq		$t0,	1,		swap		#Go to swap if t0 == 1 (s3 < s4)
	add		$0,		$0,		$0			#NOP

	jr		$ra							#Return

swap:
	add		$s3,	$t4,	$0			#Set s3 = t4 (s4)
	add		$s4,	$t3,	$0			#Set s3 = t4 (s4)
	
	jr		$ra							#Return
