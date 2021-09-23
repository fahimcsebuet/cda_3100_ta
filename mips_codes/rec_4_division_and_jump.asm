# Add two numbers, take input from the user.

.data
dividend_msg: .asciiz "Enter dividend number: "
divisor_msg: .asciiz "Enter divisor number: "
quotient_msg: .asciiz "Quotient: "
remainder_msg: .asciiz ", Remainder: "
gt_msg: .asciiz "; Quotient is greater than 4;"

.text

print_gt_msg:

li $v0, 4 # system call code for print_string
la $a0, gt_msg # address of string to print
syscall # print the string

j exit

main:

li $v0, 4 # system call code for print_string
la $a0, dividend_msg # address of string to print
syscall # print the string

li $v0, 5
syscall
move $t0, $v0 # t0 has the dividend

li $v0, 4 # system call code for print_string
la $a0, divisor_msg # address of string to print
syscall # print the string

li $v0, 5
syscall
move $t1, $v0 # t1 has the divisor

# add the value in $t0 and $t1 and store the result in $t2
div $t0, $t1 # quotient is in LO, remainder is in HI

mflo $t0 # $t0 has the quotient
mfhi $t1 # $t1 has the remainder

li $v0, 4 # system call code for print_string
la $a0, quotient_msg # address of string to print
syscall # print the string

li $v0, 1 # system call code for print_int
move $a0, $t0 # store the value in $t2 to $a0 argument register
syscall # print the integer

li $v0, 4 # system call code for print_string
la $a0, remainder_msg # address of string to print
syscall # print the string

li $v0, 1 # system call code for print_int
move $a0, $t1 # store the value in $t2 to $a0 argument register
syscall # print the integer

li $t1, 4
bgt $t0, $t1, print_gt_msg

exit:

li $v0, 10 # system call code for exit
syscall # terminate program
