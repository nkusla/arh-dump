.section .text
.global fibonaci

fibonaci:
	pushl %ebp
	movl %esp, %ebp	
	pushl %esi

	# Provera da li je n nevalidno (n <= 0)
	cmpl $0, 8(%ebp)
	jle ocisti_stek

	# Namestanje parametara i registara
	movl 12(%ebp), %esi
	movl $0, (%esi)
	movl $0, %eax
	movl $0, %edx

	pushl 12(%ebp)
	pushl 8(%ebp)
	call rekurzija

	jmp ocisti_stek

rekurzija:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	pushl %esi

	movl $0, -4(%ebp)

	# Provera da li je doslo do greske
	movl 12(%ebp), %esi
	cmpl $1, (%esi)
	je ocisti_stek

	# Izlaz iz rekurzije
	cmpl $2, 8(%ebp)
	jle izlaz

	# Poziv fibonaci(n-1, g)
	movl 8(%ebp), %esi
	subl $1, %esi
	pushl 12(%ebp)
	pushl %esi
	call fibonaci
	
	addl %eax, -4(%ebp)
	jc greska

	# Poziv fibonaci(n-2, g)
	movl 8(%ebp), %esi
	subl $2, %esi
	pushl 12(%ebp)
	pushl %esi
	call fibonaci

	addl %eax, -4(%ebp)
	jc greska

	movl -4(%ebp), %eax

	jmp ocisti_stek

greska:
	movl 12(%ebp), %esi
	movl $1, (%esi)
	jmp ocisti_stek

izlaz:
	movl $1, %eax

ocisti_stek:
	pop %esi
	movl %ebp, %esp
	pop %ebp
	ret