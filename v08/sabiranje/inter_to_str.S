.section .text
.global inter_to_str

convert_num:
	cmpb $9, %dl
	ja dalje
	addb $48, %dl
	ret

	dalje:
	addb $87, %dl
	ret

inter_to_str:
	pushl %ebp
	movl %esp, %ebp
	pushl %esi
	pushl %edi

	# Registri
	movl 8(%ebp), %eax	# sadrzi broj koji se konvertuje
	movl 12(%ebp), %ecx	# sadrzi bazu
	movl 16(%ebp), %esi # sadrzi adresu pocetka stringa u koji se upisuje
	movl $0, %edx

petlja:
	cmpl $0, %eax
	je reset

	divl %ecx
	call convert_num
	movb %dl, (%esi)
	movl $0, %edx

	incl %esi
	jmp petlja

reset:
	movb $10, (%esi)
	movl 16(%ebp), %edi
	decl %esi
obrni:
	cmpl %esi, %edi
	jae obrisi_stek

	# Zamena
	movb (%esi), %al
	xchgb %al, (%edi)
	movb %al, (%esi)

	decl %esi
	incl %edi
	jmp obrni

obrisi_stek:
	popl %edi
	popl %esi
	movl %ebp, %esp
	popl %ebp
	ret