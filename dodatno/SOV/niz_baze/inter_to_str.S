.section .text
.global inter_to_str

### Pomocne rutine ##############
konvertuj_cifru:
	cmpb $9, %dl
	ja dalje
	addb $48, %dl
	ret

	dalje:
	addb $87, %dl
	ret

### MAIN ##########################
inter_to_str:
	pushl %ebp
	movl %esp, %ebp
	pushl %esi
	pushl %edi
	pushl %ebx

	movl 8(%ebp), %esi	# sadrzi pocetak stringa u koji se upisuje
	movl 12(%ebp), %eax	# sadrzi broj koji se konvertuje
	movl $0, %edx
	movl $16, %ecx		# baza
	movl $0, %edx		# brojac znakova u konvertovanom stringu

petlja:
	divl %ecx
	call konvertuj_cifru
	movb %dl, (%esi)
	movl $0, %edx
	incl %ebx
	incl %esi

	cmpl $0, %eax
	je nastavi
	jmp petlja

nastavi:
	movb $10, (%esi)
	decl %esi
	movl 8(%ebp), %edi

obrni:
	cmpl %esi, %edi
	jae sacuvaj

	movb (%esi), %cl
	xchgb %cl, (%edi)
	movb %cl, (%esi)
	
	decl %esi
	incl %edi
	jmp obrni

sacuvaj:
	incl %ebx			# uvecamo zbog \n
	movl %ebx, %eax		# sacuvamo kao povratnu vrednost

obrisi_stek:
	pushl %ebx
	pushl %edi
	pushl %esi
	movl %ebp, %esp
	popl %ebp
	ret