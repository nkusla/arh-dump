.section .text
.global ucitaj_u_bafer

# Ucitamo potstring u bafer da bismo mogli da ga konvertujemo
ucitaj_u_bafer:
	pushl %ebp
	movl %esp, %ebp
	pushl %ebx

	movl 12(%ebp), %eax				# adresni registar stringa iz kog se ucitava potstring
	movl 8(%ebp), %ebx				# adresni registar bafera

	pomeri:
		cmpb $10, (%eax)
		je dalje
		cmpb $' ', (%eax)
		je dalje

		movb (%eax), %cl	# upisivanje znaka u bafer
		movb %cl, (%ebx)

		incl %eax
		incl %ebx
	jmp pomeri

	dalje:
	cmpb $10, (%eax)	# ako smo dosli do '\n' ne pomeramo eax
	je obrisi_stek
	incl %eax			# pomerimo se na sledeci znak koji nije razmak

obrisi_stek:
	movb $0, (%ebx)		# dodamo '\0' u bafer na kraj ucitanog potstringa

	popl %ebx
	movl %ebp, %esp
	popl %ebp
	ret