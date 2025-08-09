	.arch armv8-a
	.file	"myfma.c"
	.text
	.align	2
	.global	myFMA
	.type	myFMA, %function
myFMA:
    stp     x29, x30, [sp, -16]!   // prologue
    mov     x29, sp

    mov     x4, #0                 // i = 0

.loop:
    cmp     x4, x0                 // if i >= length, exit
    bge     .done

    // First SIMD pair
    lsl     x5, x4, #2             // x5 = i * 4
    ldr     q1, [x1, x5]           // a[i]
    ldr     q2, [x2, x5]           // b[i]
    ldr     q3, [x3, x5]           // c[i]
    fmul    v4.2s, v1.2s, v2.2s
    fadd    v4.2s, v4.2s, v3.2s
    str     q4, [x1, x5]           // a[i] = a[i]*b[i] + c[i]

    add     x4, x4, #2             // i += 2

    cmp     x4, x0                 // if i >= length, exit
    bge     .done

    // Second SIMD pair (unrolled)
    lsl     x5, x4, #2             // x5 = i * 4
    ldr     q1, [x1, x5]
    ldr     q2, [x2, x5]
    ldr     q3, [x3, x5]
    fmul    v4.2s, v1.2s, v2.2s
    fadd    v4.2s, v4.2s, v3.2s
    str     q4, [x1, x5]

    add     x4, x4, #2             // i += 2

    b       .loop

.done:
    ldp     x29, x30, [sp], 16     // epilogue
    ret
