# Mnozenje 64-bitnih brojeva
# a = 2b + c/3

.section .data
a: .quad 0x2
b: .quad 0x00001111ffffffff
greska: .byte 0

.section .text
.global main

main:
	movb $0, greska
	
petlja:
	movl a, %eax
	movl b, %ebx
	addl %eax, %ebx
	adcl %ebx, b+4
	decl %eax
	sbbl $0, %ebx
	cmpl $0, %ebx
	je provera_nizeg
	jmp petlja

provera_nizeg:
	cmpl $0, %eax
	je kraj
	jmp petlja

kraj:
	movl b, %eax
	movl b+4, %ebx 

	movl $1, %eax
	movl $0, %ebx
	int $0x80
