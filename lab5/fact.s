CMPS 3240 Lab: Stack Linkage with ARMv8
Objectives
During this lab you will:

Learn about ARMv8 stack linkage
Use gcc to assemble examples of ARM stack linkage
Implement a recursive version of Fibonacci
Prerequisites
This lab assumes you have read or are familiar with the following topics:

Different parts of memory
The stack
The idea of stack linkage
The idea of stack frames / frame records
ARM64 stack linkage1
Please study these topics if you are not familiar with them so that the lab can be completed in a timely manner.

Requirements
The following is a list of requirements to complete the lab. Some labs can completed on any machine, whereas some require you to use a specific departmental teaching server. You will find this information here.

Software
We will use the following programs:

gcc
git
gdb
Compatability
This lab requires the departmental ARM server. It will not work on odin.cs.csubak.edu, sleipnir.cs.csubak.edu, other PCs, etc. that have x86 processors. It may work on a Raspberry Pi or similar system on chip with ARM, but it must be ARMv8-a.

Linux	Mac	Windows
Limited	No	No
Background
The purpose of this lab is to understand stack linkage (also called calling convention or call convention). A stack linkage defines how processes (or subroutines) interact with each other. It defines how the stack should be used, what the caller and callee behaviors are, and how the registers should be used. So, which stack linkage should be used? A process uses a specific linkage depending on the instruction set architecture (ISA) being used, and what operating system you're using. Some examples are Microsoft x64 calling convention and System V AMD64 ABI for x86-64 ISAs. With low-level systems applications, a project may implement their own stack linkage and long-running, legacy projects may have multiple stack linkages within the same project.

For ARMv8, the specific linkage we will discuss is largely defined by the ARMv8 ABI (often called AArch64 or ARM64), which in Linux-based systems aligns with the AArch64 ELF (System V) ABI used by GCC.1 This will be the topic of the lab today.

A stack linkage (or calling convention) specifies the following:

A stack linkage specifies the following:

How registers should be used: which registers are used to pass arguments, which registers are preserved by callees, etc.
How the stack should be used: including where to store local variables, saved registers, and alignment rules.
Behavior of how a subroutine (callee) is called by another subroutine (caller).
For this lab, the number of arguments passed between the callee and caller should be known and fixed. It is possible to have a variable number of arguments, but we will not cover this.

Registers
In ARMv8 (AArch64) System V ABI, registers have specific roles regarding whether they must be preserved by the callee or not:

Callee-saved (must be restored by the callee if modified)

x19 to x28
x29: Frame pointer, also known as FP
x30: Link register, also known as LR. Used when saving for non-leaf functions.
The stack pointer ((sp)) is also conceptually callee-saved and must always point to the current stack top.
Caller-saved (free to clobber)

x0 to x7 are used for passing up to 8 integer/pointer arguments to functions.
x8 is often used as an indirect result location register or for other scratch purposes, depending on the ABI.
x9 to x15 are also caller-saved (scratch) registers.
Return value

For integer/pointer return values, x0 is used to return the result of the function. Note this is the biggest difference from MIPS as discussed in class. MIPS has separate sets of registers for input and output. ARMv8 will use the same register.
Caller-saved means the caller must preserve those registers if it needs them later. Callee-saved means the callee must preserve (push/pop) them if it modifies them. Typically, since you are coding from the perspective of the caller, you do not need to save caller-saved registers.

Stack
The stack lives in memory and generally starts at a high address and grows downward. The stack pointer points to the end (bottom) of the stack; addresses above sp contain valid data, while addresses below sp contain garbage. When a process or function needs stack space, it allocates by subtracting from the stack pointer, reserving that space for local variables, spill slots, or saved registers. This area is often called a stack frame or stack record.

Specific to the ARMv8 ABI (and to keep consistency with tools like GDB), the frame pointer x29 typically shadows the stack pointer (points to the base of the current frame). At the function entry, the old frame pointer is saved on the stack, and the new frame pointer is set to the current sp—this forms a linked list of stack frames.

The ARMv8 ABI also mandates:

The lowest addressed double-word in the frame record should contain the old frame pointer x29.
The second lowest addressed double-word in the frame record should contain the old link register x30 (the return address passed from the caller).
The stack must be 16-byte (quad-word) aligned at all externally visible call boundaries. Failing to do so will cause a bus error on runtime and crash your program--I learned this the hard way during a classroom demonstration.
To save values on the stack, you must first move (subtract) the stack pointer. Then you can use str, stp (store pair), or pre-indexed addressing to place values relative to sp.
To restore values from the stack, you can use ldr, ldp, or post-indexed addressing to pull values back into registers and move sp back up.
# Simple example
sub sp, sp, 16
str x0, [sp, 16]
Another example using pre-indexing:

# Recall that pre-index modifies the pointer before dereference
str x0, [sp, 16]!
This instruction combines both of the previous operations in a single hardware-level instruciton.

Caller Notes
Things the caller should do before jumping to the callee with bl:

The first 8 arguments are passed in registers, in order. The first argument is stored in 0, the second argument is stored in 1 and so on.The size of the argument dicatates which register to use (w or x)
If there are more than 8 arguments, the rest go on the stack in reverse order (so the last argument ends up at the highest address).
Ensure that the stack is correctly aligned (16-byte alignment), if stack is used.
After the above, the caller calls the callee with branch-and-link (bl) which automatically saves the return address to the link register x30.

Callee Notes
Things the callee should do the following:

Set up its frame record. If this is a leaf function--it call no other subroutines--the first instruction is often to move the stack pointer sp with a sub instruction. Example, if this is a leaf function:

myfunc:
sub sp, sp, 32
...
add sp, sp, 32
ret
No need to save the old frame pointer or link register if we aren’t calling further subroutines (and if we’re not using x29 for anything).

However, if it is a non-leaf function, it must comply with the points we discussed above. Here is an example that adheres to everything:

myfunction:
# Suppose we want to pre-allocate 128 bytes. The stack pointer is placed
# at the bottom of the frame record:
str x29, [sp, -128]!
# Use pre-index to requisition stack space before saving x29. The link register is copied just above it:
str x30, [sp, 8]
# Set the current frame pointer. This seems weird but it is by convention. The frame records must form a link listed and point to each other
add x29, sp, 0
Note this is not unique. You could also use the stp for a more elegant but perhaps less understandable code:

myfunction:
stp x29, x30, [sp, -128]!
add x29, sp, 0
Shadow the first 8 input arguments onto the stack (if your convention or project guidelines require it). The System V ABI for AArch64 does not strictly require shadowing unless you need to modify/spill them, but many coding guidelines or debuggers assume this is done, especially for easier debugging or if you might need the original arguments later. Example:

myfunction:
// Suppose we want to pre-allocate 128 bytes. 
stp x29, x30, [sp, -128]!
add x29, sp, 0

str w0, [sp, 16]
str w1, [sp, 20]
...
The above example assumes the function was passed to int arguments. Then, perform the intended logic of the subroutine

When quitting, the callee should restore the stack pointer, link pointer and frame pointer to its original values before returning (ret). Example:

myfunction:
stp x29, x30, [sp, -128]!
add x29, sp, 0
...
ldp x29, x30, [sp], 128
ret
using ldp and post-indexing to both restore all the values and pop the stack (revert the pointer to its original value).

Examples
In the following section, we go over some examples provided in this repository that should affirm everything we've covered so far.

main.c
For these first two examples we will use gcc to generate assembly code for us. Normally we prefer to work from the ground up, but gcc generates code that must adhere to the calling convention, and should generate compliant example code for us.

The first example we will look at is main.c that contains three functions that call each other and print a number to the screen. main() calls foo(), which calls bar() and then a number is printed to the screen. Open up main.c in a text editor:

$ vim main.c
Study it for a bit, then use the Make target main.s to generate the assembly code, then open the assembly code with your favorite text editor:

$ make main.s
gcc -O0 -Wall -S main.c -o main.s
$ vim main.s
bar is pretty simple, it just returns the literal 43 through w0. The 0 register is the return register, and note that w is used because 43 is an integer which is only 32-bits.

foo is the first function to implement a frame record. Note that it uses an stp instruction with pre-indexing to store both the old frame pointer and the link register:

stp x29, x30, [sp, -16]!
add x29, sp, 0
...
ldp x29, x30, [sp], 16
ret
Beyond that it does not really allocate additional stack space. The ldp instruction, using a post-index, both restores the link register and frame pointer and reverts the stack pointer (also called popping the stack). You should also look at main, it does something similar.

manyargs.c
This example contains a function that demonstrates passing arguments. A function adds 11 numbers together, which exceeds the number of registers designated as argument registers. We should see behavior for the callee expecting arguments on the stack. Open up manyargs.c:

$ vim manyargs.c
Note that there is no main(), this example just details how to pass arguments. Also note that this is a leaf function, so setting up a frame record isn't required. Fire the correct make target and take a look at the source code:

$ make manyargs.s
gcc -Wall -S manyargs.c -o manyargs.s
$ vim manyargs.s
Note that shadowing the link pointer and the frame pointer are not required because this is a leaf function. However, by convention, we still shadow the input arguments to the stack, so we still decrement sp. The first set of str operations store the arguments in x0 thru x7 into consecutive positions on the stack. The compiler does a weird thing here. Even though the registers x0 thru x7 already contain the input arguments, it wastes operations here bringing the values from the stack into scratch registers. This is an example of how the compiler is not perfect and there is always room for improvement of the code at a low-level. Also note that arguments 9-11 are passed on the stack and the callee pulls them off the stack in the order described by the background section.

fact.s
This is the first non-trivial example, ARM code for a recursive function that implements the following C-language code snipet:

int fact( int n ) {
	if (n <= 1)
		return 1;
	else
		return n * fact( n - 1 );
}
Carefully study this code. You may want to do a hand-trace to understand it.

Technical Approach
In a previous lab we implemented an interative version of Fibonacci code. We were not able to implement a recursive version because we had not yet covered how to generate function scope (the underlying frame record). In this lab, using fact.s as a baseline code, modify the code to generate a Fibonacci number. For reference, here is the C-language code:

int fib( int n ) {
	if (n == 0)
		return 0;
	else if (n == 1)
		return 1;
	else {
		return fib( n - 2 ) + fib( n - 1 );
	}
}
Alternatively, you can condense the first two if blocks to if (n <= 1) { return n; }. Though you are using gcc to assemble and link your code, it is not permitted to have gcc generate your Fibonacci code for you. Your work must be original.

Check off
For full credit, show the instructor that your code can calculate the 13th Fibonacci number.

References
1http://infocenter.arm.com/help/topic/com.arm.doc.ihi0055b/IHI0055B_aapcs64.pdf

Footnotes
aIf you ever wondered why you can't run a Windows binary on a Linux machine even if they both have an x86 processor, this is one of the many reasons

bThis happens often with military and aerospace applications

cThis document may use different register prefixes from what is used with Linux ARM mnemonics. E.g., r vs. x.

dVariadic subroutines--varying number of arguments--are allowed in ARM, but we do not cover them in this class

eSystem calls use a reduced number of registers for passing arguments

fFor example, with MIPS, the frame pointer should only point to the top of the current frame record

gBe careful getting help on the internet here, previous versions of ARM had push and pop instructions that no longer exist with ARM64
