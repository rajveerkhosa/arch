.data
a: .word 1
b: .word 2

.text
.global main
main: 
	ldr x0, =a
	ldr x1, =b
	
	ldr w2, [x0]
	ldr w3, [x1]

	str w3, [x0]
	str w2, [x1]

	mov x0, #0
	ret
