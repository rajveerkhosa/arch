.text
.global main
main:
    mov x2, #1
    mov x3, #2
    mov x4, #3

    eor x0, x2, x2     // x0 = 1 ⊕ 1 = 0
    eor x0, x0, x3     // x0 = 0 ⊕ 2 = 2
    eor x0, x0, x3     // x0 = 2 ⊕ 2 = 0
    eor x0, x0, x4     // x0 = 0 ⊕ 3 = 3

alldone:
    mov x0, #0
    ret

