.section .text
.global inter_to_str

inter_to_str:
	pushl %ebp
	movl %esp, %ebp
	pushl %esi
	pushl %edi
	pushl %ebx

	movl 8(%ebp), %eax			# sadrzi broj
	movl $0, %edx				# visi deo uvek 0
	movl 12(%ebp), %esi			# sadrzi pocetak bafera
	movl $10, %ecx				# izlaz je uvek u dekadnom obliku
	movl $0, %ebx				# brojac upisanih znakova u string

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
	movb $10, (%esi)
	incl %ebx
	decl %esi
	movl 12(%ebp), %edi
obrni:
	cmpl %esi, %edi
	jae obrisi_stek

	movb (%esi), %bl
	xchgb %bl, (%edi)
	movb %bl, (%esi)

	decl %esi
	incl %edi
	jmp obrni

obrisi_stek:
	movl %ebx, %eax	# povratna vrednost

	popl %ebx
	popl %edi
	popl %esi
	movl %ebp, %esp
	popl %ebp
	ret