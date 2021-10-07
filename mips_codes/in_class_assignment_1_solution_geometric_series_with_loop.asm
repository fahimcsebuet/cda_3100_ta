.data
test_array: .word 3, 9, 27, 81, 243 # constructs an array of 5 32-bit integers in memory
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
move $t1, $zero # use $t1 as the counter of the loop
li $t2, 16 # use $t2 for keeping the maximum value of the counter
lw $t3, 0($t0) # load the first word (32-bit number) of the array
lw $t6, 4($t0) # load the second word (32-bit number) of the array
div $t6, $t3 # division to find the common ratio
mfhi $t6 # load remainder in $t6
bne $t6, $zero, invalid_input_handler # if remainder is non zero, r is not an integer.
mflo $t6 # reuse $t6 for keeping the ratio of first two numbers for future use.

loop: # loop label
addi $t1, $t1, 4 # increment counter
addi $t0, $t0, 4 # increment the address value to access the next numbers.
lw $t4, 0($t0) # load the current number in $t4. Note, previous number is in $t3
div $t4, $t3 # divide the current number by the previous one. 
move $t3, $t4 # move the current number to $t3, so that we can use it in the next iteration.
mflo $t4 # load the quotient in $t4
mfhi $t5 # load the remainder in $t5
bne $t5, $zero, invalid_input_handler # check if input is invalid.
bne $t4, $t6, failure_handler # check if current ratio does not match the one between first two numbers.
blt $t1, $t2, loop # loop until we do not reach the maximum value of the counter.

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
move $a0, $t6
syscall

# exit label so we can directly jump to exit in case of invalid input or failure cases.
exit:
li $v0, 10
syscall
