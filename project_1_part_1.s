.globl	main
.globl	done

.data

name:		.asciiz		"Brendan Meehan\n"
username:	.asciiz		"brmeehan\n"

.text

main:
	ori		$v0,	$0,		4		#Set v0 to print
    lui		$a0,	0x1001			#Load name to a0
    syscall							#Print name

    ori		$a0,	$a0,	0x0010	#Load username to a0
   	syscall							#Print username

   	jr		$ra						#End program
done:     
	or  	$0,		$0,		$0      #NOP
