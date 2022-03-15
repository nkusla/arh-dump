# Suma prvih ne brojeva

.section .text
.globl main

main:
	movl $10, %eax
	movl $0, %ebx
petlja:
	addl %eax, %ebx
	subl $1, %eax
	je kraj
	jmp petlja

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
