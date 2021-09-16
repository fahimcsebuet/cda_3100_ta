# Add 10 and 5

.data
msg: .asciiz "Result: "

.text

main:
li $t0, 10 # load value 10 into register $t0
li $t1, 5 # load value 5 into register $t1

# add the value in $t0 and $t1 and store the result in $t2
add $t2, $t0, $t1

li $v0, 4 # system call code for print_string
la $a1, msg # address of string to print
syscall # print the string

li $v0, 1 # system call code for print_int
move $a0, $t2 # store the value in $t2 to $a0 argument register
syscall # print the integer

li $v0, 10 # system call code for exit
syscall # terminate program
