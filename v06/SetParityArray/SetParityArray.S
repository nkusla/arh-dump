.section .text
.global SetParityArray

SetParityArray:
	pushl %ebp
	movl %esp, %ebp
	pushl %esi

	movl $0, %esi		# esi je brojac
	movl $0, %ecx		# ecx broji koliko borjeva ima upaljen bit pariteta
	movl 8(%ebp), %edx	# edx sadrzi pokazivac na prvi elem niza
	subl $2, %edx

petlja:
	cmpl 12(%ebp), %esi
	je obrisi_stek

	pushl %ecx
	addl $2, %edx # pomeramo edx za 2 bajta (jer su brojevi 16-bitni)
	pushl %edx

	call SetParity # Nalazi se u ../SetParity/SetParity.S
	popl %edx
	popl %ecx

	testl $1, %eax # ako je poslednji bit 1, brojac se poveca za 1
	jz nastavi
	incl %ecx

	nastavi:
	incl %esi
	jmp petlja

obrisi_stek:
	movl %ecx, %eax # cuvanje povratne vrednosti u eax
	movl $0, %edx

	popl %esi
	movl %ebp, %esp
	popl %ebp
	ret