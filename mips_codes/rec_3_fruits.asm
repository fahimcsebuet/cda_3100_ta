# You went to the market to buy fruits. You buy x apples and y oranges.
# On the way back home, you ate 4 apples and 3 oranges,
# because you were too hungry and wanted to eat healthy.
# How many fruits do you have left?

# Take the value of x and y from console
# While entering the values, make sure x >= 4 and y >= 3. No need to check.
# We’ll learn if-else conditions later in the course!


.data
apple_msg: .asciiz "How many apples did you buy? "
orange_msg: .asciiz "How many oranges did you buy? "
output_msg: .asciiz "Fruits left for future: "

.text
main:

li $v0, 4
la $a0, apple_msg
syscall

li $v0, 5
syscall
move $t0, $v0 # number of apples in $t0

li $v0, 4
la $a0, orange_msg
syscall

li $v0, 5
syscall
move $t1, $v0 # number of oranges in $t1

li $t2, 4
li $t3, 3

sub $t0, $t0, $t2
sub $t1, $t1, $t3

add $t0, $t0, $t1

li $v0, 4
la $a0, output_msg
syscall

li $v0, 1
move $a0, $t0
syscall

li $v0, 10
syscall
