.data
get_input_string: .asciz "Enter two decimal integers and an operator (+ - / *):\n"
invalid_operand_string: .asciz "Error: invalid operator \n"
divide_by_zero_string: .asciz "Error: divide by zero \n"
result_string: .asciz "Result: %d\n"
charFormat:     .asciz "%c"
intFormat:      .asciz "%d"
stringFormat:   .asciz "%s"
inputFormat:    .asciz "%d %d %s"


int1:            .space 4
int2:            .space 4
sign:            .space 1
output:          .space 8


.text
.global main

main:

# Print the prompt
ldr x0, = get_input_string
bl printf

# Make room on the stack for the three operands
# not sure if this is actually needed
sub sp, sp, 4
sub sp, sp, 4
sub sp, sp, 1
sub sp, sp, 8

# Load the operands into registers and call scanf
ldr x0, = inputFormat
ldr x1, = int1
ldr x2, = int2
ldr x3, = sign
bl scanf

# Load registers x5 & x6 with integers and x7 with the ascii sign
ldr x1, = int1
ldr x2, = int2
ldr x3, = sign
ldr x5, [x1]
ldr x6, [x2]
ldr x7, [x3]

# branch to add if '+' is in x7. ascii + is 43
cmp x7, #43
b.eq add
b exit


add:
add x1, x5, x6
ldr x0, = result_string
bl printf

# system call (success)
exit:
    mov x0, #0
    mov x8, #93
    svc #0
