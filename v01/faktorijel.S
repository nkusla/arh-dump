# faktorijel broja

.section .text
.global main

main:
	movl $4, %eax
	movl $1, %ebx
	movl $0, %ecx

fakt:
	jmp mnozenje
umanji:
	dec %eax
	je kraj
	jmp fakt
	
reset:
	movl %ecx, %ebx
	jmp umanji
	
mnozenje:
	addl %eax, %ecx
	dec %ebx
	je reset
	jmp mnozenje

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
