# w0 - Arg 1 - Integer, length of the vectors 'n'. It is 'w' because of integer
#	type.
# x1 - Arg 2 - Single precision pointer to vector x. It is an 'x' register bc
#	pointers are 64 bit. Note that it starts at x1 because 'w' regs are the
#	lower half of an 'x' register. Using 'x0' here would be the same reg-
#	ister as the first argument. 
# x2 - Arg 3 - Single precision pointer to vector y
# x3 - Arg 4 - Single precision pointer to vector of result
.text

.global faxpy
.text
faxpy:
    // x0 = n (length)
    // x1 = x[]
    // x2 = y[]
    // x3 = result[]

    mov w5, wzr        // loop counter = 0

looptop:
    cmp w5, w0         // if i >= n, exit loop
    b.ge done

    ld1 {v0.4s}, [x1], 16   // load x[i]..x[i+3] into v0
    ld1 {v1.4s}, [x2], 16   // load y[i]..y[i+3] into v1

    fadd v2.4s, v0.4s, v1.4s // v2 = x + y

    st1 {v2.4s}, [x3], 16   // store result to result[i]..result[i+3]

    add w5, w5, 4           // i += 4
    b looptop

done:
    ret

