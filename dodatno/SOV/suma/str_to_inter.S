.section .text
.global str_to_inter

konverzija_znaka:
	cmpb $'0', (%esi)
	jb greska_znak

	movb (%esi), %bl
	subl $48, %ebx
	cmpl %ebx, %ecx
	jbe greska_znak
	ret

str_to_inter:
	pushl %ebp
	movl %esp, %ebp
	pushl %esi
	pushl %edi
	pushl %ebx

	movl 8(%ebp), %esi		# sadrzi pocetak stringa
	movl 12(%ebp), %ecx		# sadrzi bazu
	movl $0, %eax			# sadrzi konacnu vrednost konverzije
	movl $0, %edx

petlja:
	cmpb $0, (%esi)
	je obrisi_stek

	mull %ecx
	jc greska_prekoracenje

	call konverzija_znaka
	addl %ebx, %eax
	jc greska_prekoracenje

	incl %esi
	jmp petlja

greska_znak:
	movl 16(%ebp), %esi
	movb $1, (%esi)
	jmp obrisi_stek
greska_prekoracenje:
	movl 16(%ebp), %esi
	movb $2, (%esi)
	jmp obrisi_stek

obrisi_stek:
	popl %ebx
	popl %edi
	popl %esi
	movl %ebp, %esp
	popl %ebp
	ret