.text
.global main
main:
    mov x1, #6
    mov x2, #2
    mov x3, #1
    mov x4, #2

    add x5, x3, x4    // x5 = 1 + 2 = 3
    udiv x0, x1, x2   // x0 = 6 / 2 = 3
    mul x0, x0, x5    // x0 = 3 * 3 = 9 

    ret
