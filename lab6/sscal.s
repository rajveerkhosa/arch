    .arch armv8-a
    .file   "sscal.c"
    .text
    .section    .rodata
    .align  3
.LC0:
    .string "Running SSCAL operation of size %d x 1\n"
    .text
    .align  2
    .global main
    .type   main, %function
main:
.LFB6:
    .cfi_startproc
    stp     x29, x30, [sp, -48]!
    .cfi_def_cfa_offset 48
    .cfi_offset 29, -48
    .cfi_offset 30, -40
    mov     x29, sp
    mov     w0, 49664
    movk    w0, 0xbeb, lsl 16
    str     w0, [sp, 28]
    ldr     w1, [sp, 28]
    adrp    x0, .LC0
    add     x0, x0, :lo12:.LC0
    bl      printf
    mov     w0, 13
    str     w0, [sp, 32]
    ldrsw   x0, [sp, 28]
    lsl     x0, x0, 2
    bl      malloc
    str     x0, [sp, 40]
    mov     w0, 2
    str     w0, [sp, 36]
    ldr     w0, [sp, 36]
    ldr     x2, [sp, 40]
    ldr     w1, [sp, 32]
    ldr     w3, [sp, 28]
    bl      sscal
    ldr     x0, [sp, 40]
    bl      free
    mov     w0, 0
    ldp     x29, x30, [sp], 48
    .cfi_restore 30
    .cfi_restore 29
    .cfi_def_cfa_offset 0
    ret
    .cfi_endproc
.LFE6:
    .size   main, .-main
    .align  2
    .global sscal
    .type   sscal, %function
sscal:
    stp     x29, x30, [sp, -16]!
    mov     x29, sp

    mov     w4, #0              // i = 0
    b       .Lcond

.Lloop:
    sxtw    x5, w4              // promote i to 64-bit
    sxtw x7, w3      // Promote stride to 64-bit
    mul x5, x5, x7   // Now both operands are 64-bit

    lsl     x5, x5, #2          // x5 *= 4 (bytes for float)
    add     x6, x2, x5          // x6 = address of x[i * stride]

    ldr     s1, [x6]            // load x[i * stride]
    scvtf   s2, w1              // convert a to float
    fmul    s1, s1, s2          // multiply
    str     s1, [x6]            // store result

    add     w4, w4, #1          // i++
.Lcond:
    cmp     w4, w0              // compare i < length
    blt     .Lloop              // loop if true

    ldp     x29, x30, [sp], 16
    ret
.LFE7:
    .size   sscal, .-sscal
    .ident  "GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.2) 9.4.0"
    .section    .note.GNU-stack,"",@progbits

