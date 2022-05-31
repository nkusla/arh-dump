.section .text
.global inter_to_oct_str_float

upisi_cifru:
	addl $48, %eax
	movb %al, (%esi)
	incl %esi
	ret

inter_to_oct_str_float:
	pushl %ebp
	movl %esp, %ebp
	pushl %esi
	pushl %ebx

	movl 8(%ebp), %eax		# eax sadrzi razlomljeni broj
	movl 12(%ebp), %esi		# esi sadrzi adresu pocetka stringa
	movl $0, %edx
	movl $8, %ebx			# baza oktalnog sistema
	movl $100000000, %ecx	# konstanta skaliranja 10^8

	cmpl $4, 16(%ebp)	# provera duzine
	jb greska

	decl 16(%ebp)		# umanjujemo duzinu zbog '\\0'

namestanje_str:
	movb $'0', (%esi)
	movb $'.', 1(%esi)
	addl $2, %esi
	subl $2, 16(%ebp)

petlja:
	cmpl $0, 16(%ebp)
	je povratna_vrednost
	
	mull %ebx
	divl %ecx			# posle deljenja u eax je cifra koja treba da se upise, a u edx ostatak
	call upisi_cifru
	cmpl $0, %edx		# provera dal su sve cifre konvertovane (skace ako su samo ostale 0 u broju)
	je povratna_vrednost

	movl %edx, %eax		# vracamo ostatak u eax da bi ponovo mnozili
	movl $0, %edx

	decl 16(%ebp)
	jmp petlja

povratna_vrednost:
	movb $0, (%esi)		# dodavanje '\\0' na kraj izlaznoh stringa
	movl $0, %eax
	jmp obrisi_stek
greska:
	movl $1, %eax

obrisi_stek:
	popl %ebx
	popl %esi
	movl %ebp, %esp
	popl %ebp
	ret