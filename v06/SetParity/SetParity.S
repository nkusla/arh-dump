.section .text
.global SetParity

SetParity:
	pushl %ebp
	movl %esp, %ebp
	pushl %ebx

	# Brisanje vrednosti registara
	xorl %eax, %eax	# koristi se kao brojac jedinica u broju
	xorl %ebx, %ebx	# koristi za masku
	xorl %edx, %edx # koristi kao pokazivac na element
	xorl %ecx, %ecx	# koristi kao brojac za petlju

	movl 8(%ebp), %edx		# prebacivanje adrese broja u edx
	andw $0x7fff, (%edx)	# postavljanje najznacajnijeg bita na 0
	
	orl $0x80000000, %ebx	# maska je 10000000 00000000
	
petlja:
	cmpl $16, %ecx
	je promeni_paritet

	incl %ecx
	roll $1, %ebx

	testl (%edx), %ebx
	jz petlja
	incl %eax
 
	jmp petlja 	
	
promeni_paritet:
	andl $1, %eax		# sve osim poslednjeg bita (bita pariteta) obrisemo 
	roll $15, %eax		# stavljanje poslednjeg bita na 16 mesto
	orl %eax, (%edx)	# postavljanje najznacajnige bita
	
obrisi_stek:
	xorl %edx, %edx
	rorl $15, %eax # vracanje bita pariteta na pocetak

	pop %ebx
	movl %ebp, %esp
	popl %ebp
	ret
