# Print Hellow World!

.data
str: .asciiz "Hello World!\n"

.text
main:
li $v0, 4 # system call code for print_string
la $a0, str # address of string to print
syscall # print the string

li $v0, 10 # system call code for exit
syscall # terminate program
