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
	ja oduzmi
	
	subl %eax, b
	movl %eax, a
	movl b, %eax
	cmpl $0, %eax
	je sacuvaj_2
	movl a, %eax
	jmp petlja

oduzmi:
	subl b, %eax
	je sacuvaj_1
	jmp petlja
	
sacuvaj_1:
	movl b, %eax
	jmp kraj
sacuvaj_2:
	movl a, %eax
	jmp kraj
	
kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
