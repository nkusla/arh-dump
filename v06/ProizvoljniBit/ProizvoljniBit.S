.section .text
.global ProizvoljniBit

ProizvoljniBit:
	pushl %ebp
	movl %esp, %ebp

	movb 12(%ebp), %cl	# registar za poziciju bita
	movl $0, %edx		# gornji deo maske 000...000
	movl $1, %eax		# donji deo maske  000...001
	
	cmpb $32, %cl 
	jb nastavi

	subb $32, %cl
	movl $0, %eax
	movl $1, %edx
	shll %cl, %edx

nastavi:
	shll %cl, %eax

	movl 8(%ebp), %ecx	# smestanje adrese broja u ecx
	cmpb $0, 16(%ebp)
	je invertuj
	orl %eax, (%ecx) 
	orl %edx, 4(%ecx) 

	jmp obrisi_stek

invertuj:
	not %eax
	not %edx

	andl %eax, (%ecx)
	andl %edx, 4(%ecx)

obrisi_stek:
	movl %ebp, %esp
	popl %ebp
	ret