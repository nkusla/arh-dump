.section .text
.global BrojJedinica

BrojJedinica:
	pushl %ebp
	movl %esp, %ebp
	pushl %ebx

	movl $0x80000000, %edx # visi deo maske
	movl $0, %ebx	# nizi deo maska
	movl $0, %ecx	# brojac jedinica

	jmp petlja

# Premestanje bita iz viseg u nizi deo
premesti_bit:
	movl $0x80000000, %ebx
	jmp petlja

petlja:
	# Poredjenje viseg dela
	testl 8(%ebp), %edx
	jnz inkrement
	# Poredjenje nizeg dela
	testl 12(%ebp), %ebx
	jz shift

	inkrement:
	incl %ecx

	shift:
	shrl $1, %edx
	jnz petlja
	jc premesti_bit	# ako bit skoci u carry treba ga prebaciti u nizi deo
	shrl $1, %ebx
	jnz petlja

obrisi_stek:
	movl %ecx, %eax
	movl $0, %edx

	popl %ebx
	movl %ebp, %esp
	popl %ebp
	ret