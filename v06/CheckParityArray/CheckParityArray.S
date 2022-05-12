.section .text
.global CheckParityArray

CheckParityArray:
	pushl %ebp
	movl %esp, %ebp
	pushl %esi
	pushl %edi

	movl $0, %esi		# brojac petlje
	movl 8(%ebp), %edi	# pokazivac na prvi elem niza
	movl $0, %ecx		# brojac elemenata sa dobrim paritetom
	
petlja:
	cmpl 12(%ebp), %esi
	je obrisi_stek

	pushl %edi
	call CheckParity	# ../CheckParity/CheckParity.S
	popl %edi

	cmpl $1, %eax
	jne nastavi
	incl %ecx

	nastavi:
	incl %esi
	addl $2, %edi
	jmp petlja

obrisi_stek:
	movl %ecx, %eax	# cuvanje povratne vrednosti
	movl $0, %edx

	popl %edi
	popl %esi
	movl %ebp, %esp
	popl %ebp
	ret