.section .text
.global saberi_niz

saberi_niz:
	pushl %ebp
	movl %esp, %ebp
	pushl %esi
	pushl %edi

	movl $0, %esi

petlja:
	cmpl %esi, 20(%ebp)
	je izlaz

	# Sabiranje donja 4 bajta
	movl 8(%ebp), %edi
	movl (%edi, %esi, 8), %eax

	movl 12(%ebp), %edi
	addl (%edi, %esi, 8), %eax
	
	movl 16(%ebp), %edi
	movl %eax, (%edi, %esi, 8)

	# Sabiranje gornja 4 bajta
	movl 8(%ebp), %edi
	movl 4(%edi, %esi, 8), %eax

	movl 12(%ebp), %edi
	adcl 4(%edi, %esi, 8), %eax 
	jo greska
	
	movl 16(%ebp), %edi
	movl %eax, 4(%edi, %esi, 8)

	incl %esi
	jmp petlja

greska:
	movl $1, %eax
	movl $0, %edx
	jmp ocisti_stek

izlaz:
	movl $0, %eax
	movl $0, %edx

ocisti_stek:
	popl %edi
	popl %esi
	movl %ebp, %esp
	popl %ebp
	ret
