# By Nemanja Zekanović

.section .text
.globl pescaniSat

pescaniSat:
	pushl %ebp
	movl %esp, %ebp

	pushl %edi
	pushl %esi
	pushl %ebx

	movl 8(%ebp), %edi
	movl 12(%ebp), %esi
	movl %esi, %ebx

	movw $0x8000, %cx
	movw $1, %dx
	
	movl $0, %eax #brojac za napred  

deljenje_sa_dva:
	shrl $1, %esi #podelim %esi sa 2

petlja1:
	cmpl %ebx, %esi
	je pre_petlja2
	orw %cx, (%edi, %eax, 2)
	orw %dx, (%edi, %eax, 2)

	incl %eax
	decl %ebx 

	shrw %cx
	shlw %dx

	jmp petlja1

pre_petlja2:
	shlw %cx
	shrw %dx


petlja2:
	cmpl $0, %ebx
	je kraj
	orw %cx, (%edi, %eax, 2)
	orw %dx, (%edi, %eax, 2)
	
	incl %eax
	decl %ebx

	shlw %cx
	shrw %dx

	jmp petlja2
		
kraj:
	popl %ebx	
	popl %esi
	popl %edi

	movl %ebp, %esp
	popl %ebp
	ret	
