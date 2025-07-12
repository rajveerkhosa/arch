    .global iaxpy
    .type iaxpy, %function
iaxpy:
    stp     x29, x30, [sp, -16]!
    mov     x29, sp

    mov     w5, #0                 // i = 0
    b       .Lcond

.Lloop:
    sxtw    x6, w5                 // promote i to x6

    ldr     w7, [x2, x6, lsl #2]   // w7 = x[i]
    ldr     w8, [x3, x6, lsl #2]   // w8 = y[i]
    mul     w9, w1, w7             // w9 = a * x[i]
    add     w9, w9, w8             // w9 = a * x[i] + y[i]
    str     w9, [x4, x6, lsl #2]   // result[i] = w9

    add     w5, w5, #1             // i++
.Lcond:
    cmp     w5, w0
    blt     .Lloop

    ldp     x29, x30, [sp], 16
    ret

