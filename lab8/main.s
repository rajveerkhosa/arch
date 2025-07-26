	.arch armv8-a
	.file	"main.c"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
.LFB6:
	.cfi_startproc
	stp	x29, x30, [sp, -64]!
	.cfi_def_cfa_offset 64
	.cfi_offset 29, -64
	.cfi_offset 30, -56
	mov	x29, sp
	str	w0, [sp, 28]
	str	x1, [sp, 16]
	mov	w0, 49664
	movk	w0, 0xbeb, lsl 16
	str	w0, [sp, 44]
	ldrsw	x0, [sp, 44]
	lsl	x0, x0, 2
	bl	malloc
	str	x0, [sp, 48]
	ldrsw	x0, [sp, 44]
	lsl	x0, x0, 2
	bl	malloc
	str	x0, [sp, 56]
	str	wzr, [sp, 40]
	b	.L2
.L3:
    // i -> x0
    ldrsw   x0, [sp, 40]
    lsl     x0, x0, 2

    // b -> x1
    ldr     x1, [sp, 56]
    add     x2, x1, x0           // address of b[i]
    ldr     w3, [x2]             // w3 = b[i]
    ldr     w4, [x2, 4]          // w4 = b[i+1]

    // a -> x1
    ldr     x1, [sp, 48]
    add     x2, x1, x0           // address of a[i]
    mul     w5, w3, w3           // b[i]*b[i]
    str     w5, [x2]             // a[i] = b[i]*b[i]
    mul     w6, w4, w4           // b[i+1]*b[i+1]
    str     w6, [x2, 4]          // a[i+1] = b[i+1]*b[i+1]

    // i += 2
    ldr     w0, [sp, 40]
    add     w0, w0, 2
    str     w0, [sp, 40]
    b       .L2

.L2:
	ldr	w1, [sp, 40]
	ldr	w0, [sp, 44]
	cmp	w1, w0
	blt	.L3
	ldr	x0, [sp, 48]
	bl	free
	ldr	x0, [sp, 56]
	bl	free
	mov	w0, 0
	ldp	x29, x30, [sp], 64
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE6:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.2) 9.4.0"
	.section	.note.GNU-stack,"",@progbits
