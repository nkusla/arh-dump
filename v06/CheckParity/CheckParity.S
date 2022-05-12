.section .text
.global CheckParity

CheckParity:
	pushl %ebp
	movl %esp, %ebp
	
	pushl %ecx
	pushl %esi
	pushl %edi
	
	movl $1, %edx		# maska
	movl $0, %ecx		# brojac jedinica
	movl 8(%ebp), %edi	# registar eax pokazuje na broj
	movl $0, %esi		# brojac

petlja:
	cmpl $15, %esi
	je proveri

	testw (%edi), %dx
	jz nastavi
	incl %ecx

	nastavi:
	shll $1, %edx
	incl %esi
	jmp petlja

proveri:
	andl $1, %ecx	# cuvamo samo najmanje znacajan bit
	shll $15, %ecx	# pomeramo ga na 15. poziciju

	movw (%edi), %ax	# stavljamo broj u ax
	andw $0x8000, %ax	# brisemo sve sem prvog bita
	xorw %ax, %cx		# provera dal su bitovi isti
	jnz paritet_netacan 
	movl $1, %eax
	movl $0, %edx

	jmp obrisi_stek

paritet_netacan:
	movl $0, %eax
	movl $0, %edx

obrisi_stek:
	popl %edi
	popl %esi
	popl %ecx

	movl %ebp, %esp
	popl %ebp
	ret