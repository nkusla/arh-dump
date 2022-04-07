# Program koji racuna n-ti steben broja b u dvostrukoj preciznosti

.section .data
b: .quad 0x000000000000aaaa
n: .long 3
rez: .quad 1
greska: .byte 0

.section .text
.global main

main:
	movl n, %esi
petlja:
	cmpl $0, %esi
	je kraj
	
	movl b, %eax
	movl b+4, %ebx
	movl $0, %ecx
	movl $0, %edx

pomnozi:
	cmpl $0, %ebx
	jne dalje
	cmpl $0, %eax
	je sacuvaj_rez

	dalje:
	addl rez, %ecx
	adcl rez+4, %edx
	jc prekoracenje

	subl $1, %eax
	sbbl $0, %ebx
	jmp pomnozi

dec_esi:
	decl %esi
	jmp petlja

sacuvaj_rez:
	movl %ecx, rez
	movl %edx, rez+4
	jmp dec_esi

prekoracenje:
	movl $1, greska

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
