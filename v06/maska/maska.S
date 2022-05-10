.section .text
.global maska

maska:
	pushl %ebp
	movl %esp, %ebp
	
	# Provera n
	cmpl $31, 8(%ebp)
	ja greska
	
	# Provera v
	cmpl $1, 12(%ebp)
	ja greska
	
	# Priprema registara
	xorl %eax, %eax
	orl $1, %eax
	movb 8(%ebp), %cl
	
	shll %cl, %eax
	
	cmpl $1, 12(%ebp)
	je obrisi_stek
	
	# Invertovanje ako je v=0
	notl %eax
	jmp obrisi_stek
	
greska:
	xorl %eax, %eax	

obrisi_stek:
	xorl %edx, %edx
	movl %ebp, %esp 
	popl %ebp
	ret
	
