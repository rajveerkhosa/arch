.text
.global _start
_start:
    mov x8, 222
    mov x0, 0
    mov x1, 4
    mov x2, 7
    mov x3, 0x22
    mov x4, 0
    mov x5, 0
    svc 0

    mov x9, x0

    mov w0, 7
    str w0, [x9]

    ldr w2, [x9]
    add w2, w2, #3
    str w2, [x9]

    mov x8, 215
    mov x0, x9
    mov x1, 16
    svc 0

    mov x0, 0
    ret

