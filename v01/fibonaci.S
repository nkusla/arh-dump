# Fibonacijev niz
# 1 1 2 3 5 8 13 21...

.section .text
.global main

main:
	movl $9, %eax	# redni broj elemnta u Fibonacijevom nizu
	movl $0, %ebx	# registar u koji se smešta konačna vrednost
	
	movl $1, %ecx
	movl $1, %edx
	
	decl %eax
	je dodaj	# Zbog graničnog slučaja kada se traži 1 ili 2 elem niza
	decl %eax
	je dodaj
petlja:	
	addl %edx, %ecx
	movl %ecx, %ebx
	movl %edx, %ecx
	movl %ebx, %edx
	
	decl %eax
	je kraj
	jmp petlja

dodaj:
	movl $1, %ebx
kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
