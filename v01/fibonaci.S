# Fibonacijev niz
# 1 1 2 3 5 8 13 21...

.section .text
.global main

main:
	movl $6, %eax
	movl $0, %ebx
	
	movl $1, %ecx
	movl $1, %edx
	
	decl %eax
	decl %eax
petlja:	
	addl %edx, %ecx
	movl %ecx, %ebx
	movl %edx, %ecx
	movl %ebx, %edx
	
	decl %eax
	je kraj
	jmp petlja
	
kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
