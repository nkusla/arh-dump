.section .text
.global inter_to_oct_str

inter_to_oct_str:
	pushl %ebp
	movl %esp, %ebp
	pushl %esi
	pushl %edi
	
	movl 8(%ebp), %eax	# broj koji se konvertuje
	movl 12(%ebp), %esi	# adresa pocetka stringa
	movl $0, %edx
	movl $8, %ecx
	decl 16(%ebp)		# smanjujemo zbog '\\0'

petlja:
	divl %ecx
	addl $48, %edx
	movb %dl, (%esi)
	movl $0, %edx
	
	decl 16(%ebp)
	js greska
	incl %esi
	
	cmpl $0, %eax
	jne petlja

	movl $0, (%esi)
	decl %esi	# esi pokazuje na poslednji karakter
	movl 12(%ebp), %edi	# edi pokazuje na pocetak stringa

obrni:
	cmpl %edi, %esi
	jbe obrisi_stek

	movb (%edi), %dl
	xchgb %dl, (%esi)
	movb %dl, (%edi)
	incl %edi
	decl %esi
	jmp obrni
	
greska:
	movl $1, %eax
	
obrisi_stek:	
	popl %edi
	popl %esi
	movl %ebp, %esp 
	popl %ebp
	ret
