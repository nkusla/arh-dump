# Mnozenje sabiranjem

.section .text
.global main

main:
	movl $5, %eax
	movl $3, %ebx # 5 * 3 = 5 + 5 + 5 = 15
	movl $0, %ecx
petlja:
	addl %eax, %ecx
	dec %ebx
	je kraj
	jmp petlja

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
