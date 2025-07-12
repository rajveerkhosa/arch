.text
.extern printf
.global main

main:
    mov x19, #0      // a
    mov x20, #1      // b
    mov x21, #0      // i
    mov x22, #10     // limit

_looptop:
    ldr x0, =string1
    mov x1, x19
    bl printf

    add x23, x19, x20
    mov x19, x20
    mov x20, x23

    add x21, x21, #1
    cmp x21, x22
    blt _looptop

_exit:
    mov x8, #93
    mov x0, #0
    svc #0

.data
.global string1
string1:
    .ascii "%d\n"

