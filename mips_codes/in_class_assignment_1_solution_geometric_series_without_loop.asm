.data
test_array: .word 2, 4, 4, 8, 16 # constructs an array of 5 32-bit integers in memory
invalid_input_msg: .asciiz "ERROR: the input is invalid.\n"
failure_msg: .asciiz "ERROR: the given array does not belong to a geometric series.\n"
success_msg: .asciiz "SUCCESS: the given array belongs to a geometric series.\n"
common_ratio_msg: .asciiz "Common ratio: "

.text
# handles if the input array has non-integer r.
# this is invalid according to the problem specification.
# Not required for the actual assignment.
invalid_input_handler:
li $v0, 4
la $a0, invalid_input_msg
syscall
j exit

# handles the failure case, where the array cannot be a part of geometric series.
failure_handler:
li $v0, 4
la $a0, failure_msg
syscall
j exit

main:
la $t0, test_array # load the address of the starting number of test_array into $t0

lw $t1, 0($t0) # load the first number in $t1

lw $t2, 4($t0) # load the second number in $t2
div $t2, $t1 # divide the second number by the first number
mflo $t1 # load the quotient in $t1
mfhi $t3 # load the remainder in $t3
# if remainder is non-zero,
# the ratio is not integer,
# which is invalid according to the problem specification.
bne $t3, $zero, invalid_input_handler

lw $t3, 8($t0) # load the third number in $t3
div $t3, $t2 # divide the third number by the second number
mflo $t4 # load the quotient in $t4
mfhi $t2 # load the remainder in $t2
bne $t2, $zero, invalid_input_handler # check if input is invalid.
bne $t1, $t4, failure_handler # check if current ratio does not match the one between first two numbers.

# do the same for the fourth and third number.
# *** Note how the registers are reused if not needed.
lw $t2, 12($t0)
div $t2, $t3
mflo $t4
mfhi $t3
bne $t3, $zero, invalid_input_handler
bne $t1, $t4, failure_handler

# do the same for the fifth and fourth number.
# *** Note how the registers are reused if not needed.
lw $t3, 16($t0)
div $t3, $t2
mflo $t4
mfhi $t2
bne $t2, $zero, invalid_input_handler
bne $t1, $t4, failure_handler

# print success message
li $v0, 4
la $a0, success_msg
syscall

# print common ratio message
li $v0, 4
la $a0, common_ratio_msg
syscall

# print the value of the common ratio
li $v0, 1
move $a0, $t1
syscall

# exit label so we can directly jump to exit in case of invalid input or failure cases.
exit:
li $v0, 10
syscall
