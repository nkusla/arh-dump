.section .text
.global fibonaci

fibonaci:
	# Namestanje steka
	pushl %ebp
	movl %esp, %ebp

	# Cuvanje vrednosti esi registra
	pushl %esi

	# Namestanje registara
	movl $2, %esi
	movl $1, %eax
	movl $1, %ecx
	movl $0, %edx

	# Provera dal je n nevalidno (n <= 0)
	cmpl $0, 8(%ebp)
	jle greska

	# Provera dal je n <= 2
	cmpl $2, 8(%ebp)
	jle sacuvaj

petlja:
	cmpl 8(%ebp), %esi
	je sacuvaj

	pushl %ecx
	addl %eax, %ecx
	popl %eax
	jc greska

	incl %esi
	jmp petlja 

sacuvaj:
	movl 12(%ebp), %eax
	movl %ecx, (%eax) 
	movl $0, %eax
	jmp ocisti_stek

greska:
	movl $1, %eax

ocisti_stek:
	popl %esi
	popl %ebp
	ret