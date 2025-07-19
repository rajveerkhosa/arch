# x0 = Arg 1 – int length
# x1 = Arg 2 – Single precision pointer to vector x
# x2 = Arg 3 – Single precision pointer to vector y
# x3 = Arg 4 – Single precision pointer to vector of result
.text

.global faxpy

# void faxpy( int length, float* x, float* y, float* result )
faxpy:
    # Set up stack frame. This is a leaf function so we're not going to
    # shadow input arguments to the stack, just set up the frame record
    # as required by convention.
    stp x29, x30, [sp, -16]!
    add x29, sp, 0

    # Counter 'i', it's an integer
    mov w5, 0

_looptop:
    cmp w5, w0
    beq _loopquit

    # Dereference the pointers:
    # s1 = x[i] ; s2 = y[i]
    ld1 {v0.2s}, [x1], 8
    ld1 {v1.2s}, [x2], 8

    # Do the math ... fadd is addition for floating points
    fadd v0.2s, v0.2s, v1.2s

    # Store them into result, loop cleanup
    st1 {v0.2s}, [x3], 8
    add w5, w5, 2

    # Jump to looptop
    b _looptop

_loopquit:
    # Frame record cleanup
    ldp x29, x30, [sp], 16
    ret

