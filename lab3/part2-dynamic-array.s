.data
.global coyote
coyote:
    .word 0
    .word 2
    .word 4
    .word 6
    .word 8
    .word 10

.text
.global _start
_start:
    mov x8, #222
    mov x0, #0
    mov x1, #4096
    mov x2, #3
    mov x3, #0x22
    mov x4, #0
    mov x5, #0
    svc #0

    mov x9, x0

    ldr x10, =coyote
    ldr w11, [x10]
    str w11, [x9]
    ldr w11, [x10, #4]
    str w11, [x9, #4]
    ldr w11, [x10, #8]
    str w11, [x9, #8]
    ldr w11, [x10, #12]
    str w11, [x9, #12]
    ldr w11, [x10, #16]
    str w11, [x9, #16]
    ldr w11, [x10, #20]
    str w11, [x9, #20]

    mov x8, #215
    mov x0, x9
    mov x1, #4096
    svc #0

    mov x8, #93
    mov x0, #0
    svc #0

