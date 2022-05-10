.section .text
.global maska64

maska64:
	pushl %ebp
	movl %esp, %ebp
	
	xorl %eax, %eax
	xorl %edx, %edx

	# Provera n
	cmpl $63, 8(%ebp)
	ja obrisi_stek
	
	# Provera v
	cmpl $1, 12(%ebp)
	ja obrisi_stek
	
	movb 8(%ebp), %cl
	cmpb $31, %cl
	ja pomeri_visi
	
	orl $1, %eax
	shll %cl, %eax
	jmp nastavi
	
pomeri_visi:
	orl $1, %edx
	subb $32, %cl	
	shll %cl, %edx

nastavi:
	cmpl $1, 12(%ebp)
	je obrisi_stek
	
	# Invertovanje ako je v=0
	notl %eax
	notl %edx
	
obrisi_stek:
	movl %ebp, %esp
	popl %ebp
	ret
	
