# Racunanje najveceg zajednickog delioca

.section .data
a: .long 12
b: .long 8

.section .text
.global main

main:
	movl a, %eax
	
petlja:
	cmpl b, %eax
	je kraj
	ja oduzmi
	
	subl %eax, b
	jmp petlja

oduzmi:
	subl b, %eax
	jmp petlja
	
kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
