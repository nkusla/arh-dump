# Deljenje 64-bitnih brojeva koriscenjem oduzimanja i pamcenje ostatka

.section .data
a: .quad 0x001adbd442312acc # 7560054084545228
b: .quad 0xfffff # 1048575
c: .quad 0x0
ostatak: .quad 0x0 # a = b*c + ostatak

.section .text
.global main

main:
	movl a, %eax
	movl a+4, %ebx
	movl $0, %ecx
	movl $0, %edx

petlja:
	cmpl b+4, %ebx
	jb kraj
	je provera

nastavi:
	subl b, %eax
	sbbl b+4, %ebx

	# Brojac
	addl $1, %ecx
	adcl $0, %edx

	jmp petlja

provera:
	cmpl b, %eax
	jae nastavi

kraj:
	movl %ecx, c
	movl %edx, c+4
	movl %eax, ostatak
	movl %ebx, ostatak+4

	movl $1, %eax
	movl $0, %ebx
	int $0x80