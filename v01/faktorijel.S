# Faktorijel broja

.section .text
.global main

main:
	movl $5, %eax # 5! = 120
	movl $1, %ebx
	movl $0, %ecx

fakt:
	jmp mnozenje
nastavi:
	movl %ecx, %ebx
	movl $0, %ecx

	dec %eax
	je kraj
	jmp fakt
		
mnozenje:
	addl %eax, %ecx
	dec %ebx
	je nastavi
	jmp mnozenje

kraj:
	movl %ebx, %ecx

	movl $1, %eax
	movl $0, %ebx
	int $0x80
