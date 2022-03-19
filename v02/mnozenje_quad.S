# Mnozenje 64-bitnih brojeva preko sabiranja

.section .data
a: .quad 0xc # 12
b: .quad 0x00001111ffffffff # 18769007083519
greska: .byte 0

.section .text
.global main

main:
	movb $0, greska
	movl a, %eax
	movl a+4, %ebx

	movl $0, %ecx
	movl $0, %edx

petlja:
	addl b, %ecx
	adcl b+4, %edx
	jc prekoracenje

	decl %eax
	je proveri
	jmp petlja

proveri:
	cmpl $0, %ebx
	je kraj
	sbbl $0, %ebx
	jmp petlja

prekoracenje:
	movb $1, greska

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
