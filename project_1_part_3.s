.globl  main
.globl  search
.globl  done

.data

prompt1:    .asciiz     "Enter a string: "
prompt2:    .asciiz     "Enter a character: "
result1:    .asciiz     "The character  "
result2:    .asciiz     " occurs "
result3:    .asciiz     " times in the string  "

.text

#a0 = char to be searched for
#a1 = string pointer
#t0 = string char reference
#t1 = char count

main:
    li      $v0,    4                   #Print string
    la      $a0,    prompt1             #Load prompt1
    syscall                             #Print prompt1

    
    li      $v0,    8                   #Read string
    li      $a0,    0x10010060          #Store string at 0x10010060
    li      $a1,    32                  #Max string length = 32
    syscall
    move    $a1,    $a0                 #Store address of string in a1

    li      $v0,    4                   #Print string
    la      $a0,    prompt2             #Load prompt2
    syscall                             #Print prompt2

    li      $v0,    12                  #Read char
    syscall                             
    move    $a0,    $v0                 #Move char to a0

    li      $t1,    0                   #Set t1 to 0

search:
    lb      $t0,    ($a1)               #Load char from string to t0

    beqz    $t0,    done                #Branch to done if char is null

    addi    $a1,    $a1,    1           #Add 1 to string pointer
    bne     $t0,    $a0,    search      #Branch back to search if char not found

    addi    $t1,    $t1,    1           #Add 1 to count
    j       search                      #Jump back up to search

done:
    move    $t0,    $a0                 #Move char to t0

    li      $v0,    11                  #Print char
    li      $a0,    10                  #Store \n in a0
    syscall

    li      $v0,    4                   #Print string
    la      $a0,    result1             #Load result1
    syscall                             #Print result1

    li      $v0,    11                  #Print char
    li      $a0,    39                  #Store ' in a0
    syscall
    move    $a0,    $t0                 #Store char in a0
    syscall                             #Print char
    li      $a0,    39                  #Store ' in a0
    syscall

    li      $v0,    4                   #Print string
    la      $a0,    result2             #Load result2
    syscall                             #Print result2

    li      $v0,    1                   #Print int
    move    $a0,    $t1                 #Move count to a0
    syscall                             #Print count

    li      $v0,    4                   #Print string
    la      $a0,    result3             #Load result3
    syscall                             #Print result3

    li      $v0,    11                  #Print char
    li      $a0,    34                  #Store " in a0
    syscall

    li      $v0,    4                   #Print string
    li      $a0,    0x10010060          #Load address of string to a0
    syscall

    li      $v0,    11                  #Print char
    li      $a0,    34                  #Store " in a0
    syscall

    li      $a0,    46                  #Store . in a0
    syscall


    li      $v0,    10                  #End Program
    syscall
    
