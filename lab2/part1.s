.text
.global main
main:
	mov x0, #1
	mov x1, #4
	mov x3, #3
	mov x4, #2
a1:
	mul x5, x3, x1
	udiv x6, x5, x4
	add x2, x5, x0

	mov x0, 0
	ret
