# Implementacija funkcije a = 2b + c/3
# koriste se komande mul i div za mnozenje i deljenje

.section .data
a: .long 0x0
b: .long 0x9
c: .long 0xc
const1 = 2
const2 = 3
# a = 2*9 + 12/3 = 22

.section .text
.global main

main:
	movl $const1, %eax
	mull b
	addl %eax, a

	movl c, %eax
	movl $const2, %ecx
	divl %ecx
	addl %eax, a

	movl a, %eax

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80