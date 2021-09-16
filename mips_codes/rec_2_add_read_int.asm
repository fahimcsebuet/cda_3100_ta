# Add two numbers, take input from the user.

.data
first_num_msg: .asciiz "Enter first number: "
second_num_msg: .asciiz "Enter second number: "
output_msg: .asciiz "Result: "

.text

main:

li $v0, 4 # system call code for print_string
la $a0, first_num_msg # address of string to print
syscall # print the string

li $v0, 5
syscall
move $t0, $v0

li $v0, 4 # system call code for print_string
la $a0, second_num_msg # address of string to print
syscall # print the string

li $v0, 5
syscall
move $t1, $v0

# add the value in $t0 and $t1 and store the result in $t2
add $t2, $t0, $t1

li $v0, 4 # system call code for print_string
la $a0, output_msg # address of string to print
syscall # print the string

li $v0, 1 # system call code for print_int
move $a0, $t2 # store the value in $t2 to $a0 argument register
syscall # print the integer

li $v0, 10 # system call code for exit
syscall # terminate program
