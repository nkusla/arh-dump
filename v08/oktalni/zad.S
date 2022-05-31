.section .text
.global oct_str_to_inter

oct_str_to_inter:
	pushl %ebp
	movl %esp, %ebp
	pushl %esi
	pushl %ebx
	
	# Pocetna vrednost greske je 0
	movl 12(%ebp), %esi
	movl $0, (%esi)
	
	# Priprema registara
	movl 8(%ebp), %esi
	movl $8, %ecx
	movl $0, %eax
	movl $0, %edx
	movl $0, %ebx
	
	# Provera dal je string prazan
	cmpb $0, (%esi)
	je greska_znak
	
petlja:
	cmpb $0, (%esi)
	je obrisi_stek
	
	# Provera karaktera
	cmpb $'0', (%esi)
	jb greska_znak
	cmpb $'7, (%esi)
	ja greska_znak
	
	# Algoritam konverzije
	movb (%esi), %bl
	subl $'0', %ebx
	mull %ecx
	
	cmpl $0, %edx		# provera prekoracenja mnozenjem
	jne greska_prekoracenje
	addl %ebx, %eax		# provera prekoracenja sabiranjem
	jc greska_prekoracenje
	
	incl %esi
	jmp petlja
	
greska_prekoracenje:
	movl 12(%ebp), %esi
	movl $2, (%esi)
	jmp obrisi_stek
greska_znak:
	movl 12(%ebp), %esi
	movl $1, (%esi)
	jmp obrisi_stek

obrisi_stek:
	popl %ebx
	popl %esi
	movl %ebp, %esp
	popl %ebp 
	ret
