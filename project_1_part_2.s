.globl  main
.globl  sum
.globl  done

.data

prompt:     .asciiz     "Enter a number: "
result:     .asciiz     "The sum is "

.text

#t0 = loop counter
#t1 = counter < 5
#s0 = sum
#a0 = address of prompt

main:
    or      $t0,    $0,     $0          #Set t0 = 0
    or      $s0,    $0,     $0          #Set s0 = 0
    lui     $a0,    0x1001              #Load address 0x10010000 to a0

sum:
    slti    $t1,    $t0,    5           #Checks if counter < 5
    beqz    $t1,    done                #Branches to done when counter reaches 5
    addi    $t0,    $t0,    1           #[Delay Slot] Adds 1 to counter

    ori     $v0,    $0,     4           #Set v0 to print string
    syscall                             #Print prompt

    ori     $v0,    $0,     5           #Set v0 to read
    syscall                             #Get user input
    add     $s0,    $s0,    $v0         #Adds input to sum

    j       sum                         #Jump back up to sum
    or      $0,     $0,     $0          #NOP

done:
    ori     $a0,    $a0,    0x0011      #Load address 0x10010010 to a0
    ori     $v0,    $0,     4           #Set v0 to print string
    syscall                             #Print result
    ori     $v0,    $0,     1           #Set v0 to print int
    or      $a0,    $0,     $s0         #Set a0 = sum
    syscall                             #Print sum
    or      $v0,    $s0,    $0          #Set v0 to sum
    jr      $ra                         #End program
    or      $0,     $0,     $0          #NOP