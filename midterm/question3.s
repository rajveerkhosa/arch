	.arch armv8-a
	.file	"the-exam.c"
	.text
.Ltext0:
	.align	2
	.global	lucas
	.type	lucas, %function
lucas:
.LFB6:
	.file 1 "the-exam.c"
	.loc 1 4 20
	.cfi_startproc
	sub	sp, sp, #16
	.cfi_def_cfa_offset 16
	str	w0, [sp, 12]
	.loc 1 5 9
############ START HERE #######################################################
	mov w1, #2	//	lucas[0] = 2
	mov w2, #1	//	lucas[1] = 1
	mov w3, #2	//	counter
	
	cmp w0, #0
	beq .done_zero

	cmp w0, #1
	beq .done_one

.loop:
	add w4, w1, w2	// w4 = w1 + w2 which is next Lucas number
	mov w1, w2	// shift vals forward
	mov w2, w4
	add w3, w3, #1	// count++
	cmp w3, w0
	ble .loop	// basically if counter <=n it keeps looping 

	mov w0, w4	// result
	b .done


.done_zero:
	mov w0, w4
	b .done

.done_one:
	mov	w0, 1

.done:
############ END HERE #########################################################
	.loc 1 6 1
	add	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE6:
	.size	lucas, .-lucas
	.section	.rodata
	.align	3
.LC0:
	.string	"The %d-st Lucas number is %d\n"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
.LFB7:
	.loc 1 8 18
	.cfi_startproc
	stp	x29, x30, [sp, -32]!
	.cfi_def_cfa_offset 32
	.cfi_offset 29, -32
	.cfi_offset 30, -24
	mov	x29, sp
	.loc 1 9 6
	mov	w0, 20
	str	w0, [sp, 28]
	.loc 1 10 2
	ldr	w0, [sp, 28]
	bl	lucas
	mov	w2, w0
	ldr	w1, [sp, 28]
	adrp	x0, .LC0
	add	x0, x0, :lo12:.LC0
	bl	printf
	.loc 1 11 9
	mov	w0, 0
	.loc 1 12 1
	ldp	x29, x30, [sp], 32
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE7:
	.size	main, .-main
.Letext0:
	.file 2 "/usr/lib/gcc/aarch64-linux-gnu/9/include/stddef.h"
	.file 3 "/usr/include/aarch64-linux-gnu/bits/types.h"
	.file 4 "/usr/include/aarch64-linux-gnu/bits/types/struct_FILE.h"
	.file 5 "/usr/include/aarch64-linux-gnu/bits/types/FILE.h"
	.file 6 "/usr/include/stdio.h"
	.file 7 "/usr/include/aarch64-linux-gnu/bits/sys_errlist.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.4byte	0x349
	.2byte	0x4
	.4byte	.Ldebug_abbrev0
	.byte	0x8
	.uleb128 0x1
	.4byte	.LASF51
	.byte	0xc
	.4byte	.LASF52
	.4byte	.LASF53
	.8byte	.Ltext0
	.8byte	.Letext0-.Ltext0
	.4byte	.Ldebug_line0
	.uleb128 0x2
	.4byte	.LASF7
	.byte	0x2
	.byte	0xd1
	.byte	0x17
	.4byte	0x39
	.uleb128 0x3
	.byte	0x8
	.byte	0x7
	.4byte	.LASF0
	.uleb128 0x4
	.byte	0x8
	.uleb128 0x5
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0x3
	.byte	0x1
	.byte	0x8
	.4byte	.LASF1
	.uleb128 0x3
	.byte	0x2
	.byte	0x7
	.4byte	.LASF2
	.uleb128 0x3
	.byte	0x4
	.byte	0x7
	.4byte	.LASF3
	.uleb128 0x3
	.byte	0x1
	.byte	0x6
	.4byte	.LASF4
	.uleb128 0x3
	.byte	0x2
	.byte	0x5
	.4byte	.LASF5
	.uleb128 0x3
	.byte	0x8
	.byte	0x5
	.4byte	.LASF6
	.uleb128 0x2
	.4byte	.LASF8
	.byte	0x3
	.byte	0x98
	.byte	0x19
	.4byte	0x6c
	.uleb128 0x2
	.4byte	.LASF9
	.byte	0x3
	.byte	0x99
	.byte	0x1b
	.4byte	0x6c
	.uleb128 0x6
	.byte	0x8
	.4byte	0x91
	.uleb128 0x3
	.byte	0x1
	.byte	0x8
	.4byte	.LASF10
	.uleb128 0x7
	.4byte	0x91
	.uleb128 0x8
	.4byte	.LASF54
	.byte	0xd8
	.byte	0x4
	.byte	0x31
	.byte	0x8
	.4byte	0x224
	.uleb128 0x9
	.4byte	.LASF11
	.byte	0x4
	.byte	0x33
	.byte	0x7
	.4byte	0x42
	.byte	0
	.uleb128 0x9
	.4byte	.LASF12
	.byte	0x4
	.byte	0x36
	.byte	0x9
	.4byte	0x8b
	.byte	0x8
	.uleb128 0x9
	.4byte	.LASF13
	.byte	0x4
	.byte	0x37
	.byte	0x9
	.4byte	0x8b
	.byte	0x10
	.uleb128 0x9
	.4byte	.LASF14
	.byte	0x4
	.byte	0x38
	.byte	0x9
	.4byte	0x8b
	.byte	0x18
	.uleb128 0x9
	.4byte	.LASF15
	.byte	0x4
	.byte	0x39
	.byte	0x9
	.4byte	0x8b
	.byte	0x20
	.uleb128 0x9
	.4byte	.LASF16
	.byte	0x4
	.byte	0x3a
	.byte	0x9
	.4byte	0x8b
	.byte	0x28
	.uleb128 0x9
	.4byte	.LASF17
	.byte	0x4
	.byte	0x3b
	.byte	0x9
	.4byte	0x8b
	.byte	0x30
	.uleb128 0x9
	.4byte	.LASF18
	.byte	0x4
	.byte	0x3c
	.byte	0x9
	.4byte	0x8b
	.byte	0x38
	.uleb128 0x9
	.4byte	.LASF19
	.byte	0x4
	.byte	0x3d
	.byte	0x9
	.4byte	0x8b
	.byte	0x40
	.uleb128 0x9
	.4byte	.LASF20
	.byte	0x4
	.byte	0x40
	.byte	0x9
	.4byte	0x8b
	.byte	0x48
	.uleb128 0x9
	.4byte	.LASF21
	.byte	0x4
	.byte	0x41
	.byte	0x9
	.4byte	0x8b
	.byte	0x50
	.uleb128 0x9
	.4byte	.LASF22
	.byte	0x4
	.byte	0x42
	.byte	0x9
	.4byte	0x8b
	.byte	0x58
	.uleb128 0x9
	.4byte	.LASF23
	.byte	0x4
	.byte	0x44
	.byte	0x16
	.4byte	0x23d
	.byte	0x60
	.uleb128 0x9
	.4byte	.LASF24
	.byte	0x4
	.byte	0x46
	.byte	0x14
	.4byte	0x243
	.byte	0x68
	.uleb128 0x9
	.4byte	.LASF25
	.byte	0x4
	.byte	0x48
	.byte	0x7
	.4byte	0x42
	.byte	0x70
	.uleb128 0x9
	.4byte	.LASF26
	.byte	0x4
	.byte	0x49
	.byte	0x7
	.4byte	0x42
	.byte	0x74
	.uleb128 0x9
	.4byte	.LASF27
	.byte	0x4
	.byte	0x4a
	.byte	0xb
	.4byte	0x73
	.byte	0x78
	.uleb128 0x9
	.4byte	.LASF28
	.byte	0x4
	.byte	0x4d
	.byte	0x12
	.4byte	0x50
	.byte	0x80
	.uleb128 0x9
	.4byte	.LASF29
	.byte	0x4
	.byte	0x4e
	.byte	0xf
	.4byte	0x5e
	.byte	0x82
	.uleb128 0x9
	.4byte	.LASF30
	.byte	0x4
	.byte	0x4f
	.byte	0x8
	.4byte	0x249
	.byte	0x83
	.uleb128 0x9
	.4byte	.LASF31
	.byte	0x4
	.byte	0x51
	.byte	0xf
	.4byte	0x259
	.byte	0x88
	.uleb128 0x9
	.4byte	.LASF32
	.byte	0x4
	.byte	0x59
	.byte	0xd
	.4byte	0x7f
	.byte	0x90
	.uleb128 0x9
	.4byte	.LASF33
	.byte	0x4
	.byte	0x5b
	.byte	0x17
	.4byte	0x264
	.byte	0x98
	.uleb128 0x9
	.4byte	.LASF34
	.byte	0x4
	.byte	0x5c
	.byte	0x19
	.4byte	0x26f
	.byte	0xa0
	.uleb128 0x9
	.4byte	.LASF35
	.byte	0x4
	.byte	0x5d
	.byte	0x14
	.4byte	0x243
	.byte	0xa8
	.uleb128 0x9
	.4byte	.LASF36
	.byte	0x4
	.byte	0x5e
	.byte	0x9
	.4byte	0x40
	.byte	0xb0
	.uleb128 0x9
	.4byte	.LASF37
	.byte	0x4
	.byte	0x5f
	.byte	0xa
	.4byte	0x2d
	.byte	0xb8
	.uleb128 0x9
	.4byte	.LASF38
	.byte	0x4
	.byte	0x60
	.byte	0x7
	.4byte	0x42
	.byte	0xc0
	.uleb128 0x9
	.4byte	.LASF39
	.byte	0x4
	.byte	0x62
	.byte	0x8
	.4byte	0x275
	.byte	0xc4
	.byte	0
	.uleb128 0x2
	.4byte	.LASF40
	.byte	0x5
	.byte	0x7
	.byte	0x19
	.4byte	0x9d
	.uleb128 0xa
	.4byte	.LASF55
	.byte	0x4
	.byte	0x2b
	.byte	0xe
	.uleb128 0xb
	.4byte	.LASF41
	.uleb128 0x6
	.byte	0x8
	.4byte	0x238
	.uleb128 0x6
	.byte	0x8
	.4byte	0x9d
	.uleb128 0xc
	.4byte	0x91
	.4byte	0x259
	.uleb128 0xd
	.4byte	0x39
	.byte	0
	.byte	0
	.uleb128 0x6
	.byte	0x8
	.4byte	0x230
	.uleb128 0xb
	.4byte	.LASF42
	.uleb128 0x6
	.byte	0x8
	.4byte	0x25f
	.uleb128 0xb
	.4byte	.LASF43
	.uleb128 0x6
	.byte	0x8
	.4byte	0x26a
	.uleb128 0xc
	.4byte	0x91
	.4byte	0x285
	.uleb128 0xd
	.4byte	0x39
	.byte	0x13
	.byte	0
	.uleb128 0xe
	.4byte	.LASF44
	.byte	0x6
	.byte	0x89
	.byte	0xe
	.4byte	0x291
	.uleb128 0x6
	.byte	0x8
	.4byte	0x224
	.uleb128 0xe
	.4byte	.LASF45
	.byte	0x6
	.byte	0x8a
	.byte	0xe
	.4byte	0x291
	.uleb128 0xe
	.4byte	.LASF46
	.byte	0x6
	.byte	0x8b
	.byte	0xe
	.4byte	0x291
	.uleb128 0xe
	.4byte	.LASF47
	.byte	0x7
	.byte	0x1a
	.byte	0xc
	.4byte	0x42
	.uleb128 0xc
	.4byte	0x2d1
	.4byte	0x2c6
	.uleb128 0xf
	.byte	0
	.uleb128 0x7
	.4byte	0x2bb
	.uleb128 0x6
	.byte	0x8
	.4byte	0x98
	.uleb128 0x7
	.4byte	0x2cb
	.uleb128 0xe
	.4byte	.LASF48
	.byte	0x7
	.byte	0x1b
	.byte	0x1a
	.4byte	0x2c6
	.uleb128 0x3
	.byte	0x8
	.byte	0x5
	.4byte	.LASF49
	.uleb128 0x3
	.byte	0x8
	.byte	0x7
	.4byte	.LASF50
	.uleb128 0x10
	.4byte	.LASF56
	.byte	0x1
	.byte	0x8
	.byte	0x5
	.4byte	0x42
	.8byte	.LFB7
	.8byte	.LFE7-.LFB7
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x320
	.uleb128 0x11
	.string	"n"
	.byte	0x1
	.byte	0x9
	.byte	0x6
	.4byte	0x42
	.uleb128 0x2
	.byte	0x91
	.sleb128 -4
	.byte	0
	.uleb128 0x12
	.4byte	.LASF57
	.byte	0x1
	.byte	0x4
	.byte	0x5
	.4byte	0x42
	.8byte	.LFB6
	.8byte	.LFE6-.LFB6
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x13
	.string	"n"
	.byte	0x1
	.byte	0x4
	.byte	0x10
	.4byte	0x42
	.uleb128 0x2
	.byte	0x91
	.sleb128 -4
	.byte	0
	.byte	0
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1b
	.uleb128 0xe
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x10
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0x13
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0x21
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_aranges,"",@progbits
	.4byte	0x2c
	.2byte	0x2
	.4byte	.Ldebug_info0
	.byte	0x8
	.byte	0
	.2byte	0
	.2byte	0
	.8byte	.Ltext0
	.8byte	.Letext0-.Ltext0
	.8byte	0
	.8byte	0
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF9:
	.string	"__off64_t"
.LASF51:
	.string	"GNU C17 9.4.0 -mlittle-endian -mabi=lp64 -g -O0 -fasynchronous-unwind-tables -fstack-protector-strong -fstack-clash-protection"
.LASF13:
	.string	"_IO_read_end"
.LASF7:
	.string	"size_t"
.LASF54:
	.string	"_IO_FILE"
.LASF46:
	.string	"stderr"
.LASF15:
	.string	"_IO_write_base"
.LASF19:
	.string	"_IO_buf_end"
.LASF12:
	.string	"_IO_read_ptr"
.LASF37:
	.string	"__pad5"
.LASF3:
	.string	"unsigned int"
.LASF32:
	.string	"_offset"
.LASF38:
	.string	"_mode"
.LASF48:
	.string	"sys_errlist"
.LASF24:
	.string	"_chain"
.LASF20:
	.string	"_IO_save_base"
.LASF1:
	.string	"unsigned char"
.LASF36:
	.string	"_freeres_buf"
.LASF47:
	.string	"sys_nerr"
.LASF0:
	.string	"long unsigned int"
.LASF2:
	.string	"short unsigned int"
.LASF44:
	.string	"stdin"
.LASF22:
	.string	"_IO_save_end"
.LASF55:
	.string	"_IO_lock_t"
.LASF23:
	.string	"_markers"
.LASF57:
	.string	"lucas"
.LASF56:
	.string	"main"
.LASF40:
	.string	"FILE"
.LASF26:
	.string	"_flags2"
.LASF27:
	.string	"_old_offset"
.LASF31:
	.string	"_lock"
.LASF41:
	.string	"_IO_marker"
.LASF28:
	.string	"_cur_column"
.LASF50:
	.string	"long long unsigned int"
.LASF42:
	.string	"_IO_codecvt"
.LASF25:
	.string	"_fileno"
.LASF18:
	.string	"_IO_buf_base"
.LASF52:
	.string	"the-exam.c"
.LASF29:
	.string	"_vtable_offset"
.LASF33:
	.string	"_codecvt"
.LASF35:
	.string	"_freeres_list"
.LASF8:
	.string	"__off_t"
.LASF39:
	.string	"_unused2"
.LASF49:
	.string	"long long int"
.LASF45:
	.string	"stdout"
.LASF10:
	.string	"char"
.LASF53:
	.string	"/home/albert"
.LASF17:
	.string	"_IO_write_end"
.LASF5:
	.string	"short int"
.LASF21:
	.string	"_IO_backup_base"
.LASF11:
	.string	"_flags"
.LASF34:
	.string	"_wide_data"
.LASF6:
	.string	"long int"
.LASF16:
	.string	"_IO_write_ptr"
.LASF43:
	.string	"_IO_wide_data"
.LASF4:
	.string	"signed char"
.LASF14:
	.string	"_IO_read_base"
.LASF30:
	.string	"_shortbuf"
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.2) 9.4.0"
	.section	.note.GNU-stack,"",@progbits
