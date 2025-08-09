	.arch armv8-a
	.file	"fgemm.c"
	.text
	.align	2
	.global	fgemm
	.type	fgemm, %function
fgemm:
    stp     x29, x30, [sp, -16]!
    mov     x29, sp

    // x0 = m, x1 = n, x2 = k
    // x3 = A, x4 = B, x5 = C

    mov     x19, #0              // i = 0

outer_i:
    cmp     x19, x0
    bge     done

    mov     x20, #0              // j = 0

outer_j:
    cmp     x20, x1
    bge     next_i

    // s0 = 0.0 (correct init)
    mov     w0, #0
    fmov    s0, w0

    mov     x21, #0              // p = 0

inner_p:
    cmp     x21, x2
    bge     store_result

    // check if >= 4 elements remain
    mov     x22, x2
    sub     x22, x22, x21
    cmp     x22, #4
    blt     cleanup_scalar

    // Load A[i * k + p]
    mul     x6, x19, x2
    add     x6, x6, x21
    lsl     x6, x6, #2
    add     x6, x3, x6
    ld1     {v1.4s}, [x6]

    // Load B[p * n + j] and broadcast
    mul     x7, x21, x1
    add     x7, x7, x20
    lsl     x7, x7, #2
    add     x7, x4, x7
    ld1r    {v2.4s}, [x7]

    // Multiply and reduce manually
    fmul    v3.4s, v1.4s, v2.4s

    mov     s1, v3.s[0]
    mov     s2, v3.s[1]
    mov     s3, v3.s[2]
    mov     s4, v3.s[3]

    fadd    s1, s1, s2
    fadd    s1, s1, s3
    fadd    s1, s1, s4
    fadd    s0, s0, s1

    add     x21, x21, #4
    b       inner_p

cleanup_scalar:
    cmp     x21, x2
    bge     store_result

    // Scalar A[i * k + p]
    mul     x6, x19, x2
    add     x6, x6, x21
    lsl     x6, x6, #2
    add     x6, x3, x6
    ldr     s2, [x6]

    // Scalar B[p * n + j]
    mul     x7, x21, x1
    add     x7, x7, x20
    lsl     x7, x7, #2
    add     x7, x4, x7
    ldr     s3, [x7]

    fmul    s4, s2, s3
    fadd    s0, s0, s4

    add     x21, x21, #1
    b       inner_p

store_result:
    // Store C[i * n + j]
    mul     x6, x19, x1
    add     x6, x6, x20
    lsl     x6, x6, #2
    add     x6, x5, x6
    str     s0, [x6]

    add     x20, x20, #1
    b       outer_j

next_i:
    add     x19, x19, #1
    b       outer_i

done:
    ldp     x29, x30, [sp], 16
    ret
