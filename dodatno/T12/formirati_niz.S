.section .data
SIZE = 7
a:	.quad 0x5, 0x000000012A05F200, 0x0000000000010101, 0x0000000000000AAA, 0x0123, 0x7FFFFFFFFFFFFFFF, 0x0000000000000001
b:	.quad 0x4, 0x000000012A05F200, 0xF00000012A05F200, 0x00000000000FFFFF, 0x0ABC, 0x7FFFFFFFFFFFFFFF, 0x8000000000000000
c:	.fill SIZE, 8, 0
greska: .long 0

.section .text
.global main

main:
	movl $0, %esi
petlja:
	cmpl $SIZE, %esi
	je kraj

	# Poredjenje visa 4 bajta
	movl a+4(,%esi,8), %eax
	movl b+4(,%esi,8), %ebx
	cmpl %ebx, %eax
	jg oduzmi
	jne saberi

	# Poredjenje niza 4 bajta
	movl a(,%esi,8), %eax
	movl b(,%esi,8), %ebx
	cmpl %ebx, %eax
	jg oduzmi

	jmp saberi

	dalje:
	incl %esi
	jmp petlja

saberi:
	movl a(,%esi,8), %eax
	movl b(,%esi,8), %ebx
	addl %ebx, %eax
	movl %eax, c(,%esi,8)

	movl a+4(,%esi,8), %eax
	movl b+4(,%esi,8), %ebx
	adcl %ebx, %eax
	movl %eax, c+4(,%esi,8)

	jo prekoracenje
	jmp dalje
oduzmi:
	movl a(,%esi,8), %eax
	movl b(,%esi,8), %ebx
	subl %ebx, %eax
	movl %eax, c(,%esi,8)

	movl a+4(,%esi,8), %eax
	movl b+4(,%esi,8), %ebx
	sbbl %ebx, %eax
	movl %eax, c+4(,%esi,8)

	jo prekoracenje
	jmp dalje

prekoracenje:
	incl greska
	jmp dalje

kraj:
	movl $1, %eax
	movl greska, %ebx
	int $0x80