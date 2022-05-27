.section .text
.global inter_to_str_base

inter_to_str_base:
	pushl %ebp
	movl %esp, %ebp
	pushl %esi
	pushl %edi
	pushl %ebx
	
	movl 8(%ebp), %eax		# u eax ide broj koji se konvertuje
	movl 12(%ebp), %esi		# u esi ide adresa pocetka stringa
	movl 20(%ebp), %ebx		# ebx sadrzi bazu sistema u koji se konvertuje
	movl $0, %edx

edge_case:
	cmpl $36, %ebx			# baza mora biti iz opsega 2-36
	ja greska
	cmpl $2, %ebx
	jb greska

	cmpl $0, 16(%ebp)		# specijalan slucaj ako je duzina = 0
	je greska

provera_neg:
	cmpl $0, %eax
	jge petlja
	neg %eax
	movb $'-', (%esi)
	incl %esi
	decl 16(%ebp)
	jz greska
	incl 12(%ebp)		# pomeramo pokazivac pocetka stringa

petlja:
	cmpl $0, %eax
	je reset

	divl %ebx

	movl $48, %ecx		# u ecx ide offset (kontanta pomeranja)
	cmpl $9, %edx
	jbe convert
	movl $55, %ecx		# ako je broj veci od 10 onda se on mora predstaviti slovom od A-Z

	convert:
	addl %ecx, %edx
	movb %dl, (%esi)
	incl %esi
	decl 16(%ebp)
	jz greska

	movl $0, %edx
	jmp petlja

reset:
	movl $0, (%esi)			# dodajemo '\\0' na kraj stringa
	decl %esi				# esi pokazuje na poslednju cifru
	movl 12(%ebp), %edi		# edi pokazuje na prvu cifru
obrni:
	cmpl %esi, %edi
	jae obrisi_stek

	movb (%esi), %cl
	xchgb %cl, (%edi)
	movb %cl, (%esi)

	decl %esi
	incl %edi
	jmp obrni

greska:
	movl $1, %eax

obrisi_stek:
	popl %ebx
	popl %edi
	popl %esi
	movl %ebp, %esp
	popl %ebp
	ret