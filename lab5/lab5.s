.data
.global fibInput
fibInput: .dword 13             // Input value for Fibonacci calculation

.global outputFmt
outputFmt: .ascii "%d\n\0"      // Output format string for printf

.text
.extern printf

.global main
main:
    ldr x10, =fibInput          // Load address of fibInput
    ldr x0, [x10]               // Load value into x0 (argument)
    bl fib                      // Call fib function

print_result:
    mov x1, x0                  // Move result to x1 for printf
    ldr x0, =outputFmt
    bl printf

exit_program:
    mov x0, 0
    mov x8, #93
    svc #0

.global fib
fib:
    // Stack frame setup
    stp x29, x30, [sp, -32]!
    mov x29, sp

    // Base case: if n <= 1 return n
    cmp x0, #1
    ble end_fib

    // Save original n to stack
    str x0, [sp, 16]

    // Recursive call fib(n-2)
    sub x0, x0, #2
    bl fib
    mov x12, x0
    str x12, [sp, 24]

    // Restore original n and call fib(n-1)
    ldr x0, [sp, 16]
    sub x0, x0, #1
    bl fib
    mov x13, x0

    // Add results from fib(n-1) and fib(n-2)
    ldr x12, [sp, 24]
    add x0, x12, x13

end_fib:
    ldp x29, x30, [sp], 32
    ret

