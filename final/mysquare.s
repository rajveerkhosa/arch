	.arch armv8-a
	.file	"mysquare.c"
	.text
	.align	2
	.global	mysquare
	.type	mysquare, %function
mysquare:
	stp x29, x30, [sp, -16]!
	mov x29,sp

	mov x2, x0	//x2 = n
	mov x3, x1	
	mov x4, #0	//i=0

loop_start: 
	cmp x4, x2
	bge loop_end 

	// a[i], a[i +1]
	ld1	{v0.2s}, [x3]	
	fmul	v0.2s, v0.2s,  v0.2s
	st1 	{v0.2s}, [x3]

	add x5, x3, #8

	// a[i+2], a[i+3]
	ld1	{v1.2s}, [x5]	
	fmul	v1.2s, v1.2s,  v1.2s
	st1 	{v1.2s}, [x5]


	add x3, x3, #16
	add x4, x4, #4
	b loop_start

loop_end:
	ldp x29, x30, [sp], 16
	ret 
