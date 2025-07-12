    .global sdot
    .type sdot, %function
sdot:
    stp     x29, x30, [sp, -16]!
    mov     x29, sp

    fmov    s0, wzr               // s0 = 0.0f (initialize result)
    mov     w3, #0                // i = 0

    b       .Lcond

.Lloop:
    ldr     s1, [x1], #4          // s1 = *y; y++
    ldr     s2, [x2], #4          // s2 = *x; x++
    fmul    s3, s1, s2            // s3 = x[i] * y[i]
    fadd    s0, s0, s3            // result += s3

    add     w3, w3, #1            // i++
.Lcond:
    cmp     w3, w0                // i < length?
    blt     .Lloop

    ldp     x29, x30, [sp], 16
    ret

