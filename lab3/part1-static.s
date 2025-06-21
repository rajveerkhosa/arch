.data
.global badger
badger:
    .word   7

.global eagle
eagle:
    .word   0

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
.global _start
_start:
    ldr x1, =coyote
    ldr w2, [x1, #8]
    add w2, w2, #100
    str w2, [x1, #8]

    mov x0, #0
    ret

