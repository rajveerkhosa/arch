.data
.global badger
badger:
    .word   7

.global eagle
eagle:
    .word 0

.global coyote
coyote:
    .word   0
    .word   2
    .word   4
    .word   6
    .word   8
    .word   10

.global fox
.comm fox, 200, 4

.section .rodata
.global hello
hello: 
    .asciz "Hello, world!\n"

.text
.global main
main:
    mov x8, 222
    mov x0, 0
    mov x1, 24
    mov x2, 3
    mov x3, 34
    mov x4, -1
    mov x5, 0
    svc 0
    
    mov x9, x0
    ldr x10, =coyote
    
    ldr w1, [x10]
    str w1, [x9]
    
    ldr w1, [x10, #4]
    str w1, [x9, #4]
    
    ldr w1, [x10, #8]
    str w1, [x9, #8]
    
    ldr w1, [x10, #12]
    str w1, [x9, #12]
    
    ldr w1, [x10, #16]
    str w1, [x9, #16]
    
    ldr w1, [x10, #20]
    str w1, [x9, #20]
    
    mov x8, 215
    mov x0, x9
    mov x1, 24
    svc 0
    
    mov x0, 0
    ret
