.section .text
.global inter_to_str

inter_to_str:
	pushl %ebp
	movl %esp, %ebp
	pushl %esi
	pushl %edi
	pushl %ebx

	movl 8(%ebp), %eax 	# sadrzi broj
	movl 12(%ebp), %esi	# pokazivac stringa
	movl $0, %edx
	movl $8, %ecx		# baza
	movl $0, %ebx		# brojac

petlja:
	divl %ecx
	addl $48, %edx
	movb %dl, (%esi)
	movl $0, %edx
	incl %ebx
	incl %esi

	cmpl $0, %eax
	je dalje
	jmp petlja

dalje:
	incl %ebx
	movb $10, (%esi)
	movl 12(%ebp), %edi
	decl %esi
obrni:
	cmpl %esi, %edi
	jae obrisi_stek

	movb (%esi), %cl
	xchgb %cl, (%edi)
	movb %cl, (%esi)

	decl %esi
	incl %edi
	jmp obrni

obrisi_stek:
	movl %ebx, %eax

	popl %ebx
	popl %edi
	popl %esi
	movl %ebp, %esp
	popl %ebp
	ret