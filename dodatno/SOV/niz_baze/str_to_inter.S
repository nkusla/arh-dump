.section .text
.global str_to_inter

### Pomocne rutine ##############
konvertuj_u_malo:
	cmpb $'A', %bl
	jb dalje
	cmpb $'Z', %bl
	ja dalje
	addb $32, %bl
	dalje:
	ret

konvertuj_znak:
	cmpb $'0', %bl
	jb greska_znak
	cmpb $'9', %bl
	ja slovo
	subb $48, %bl
	jmp provera

	slovo:
	cmpb $'a', %bl
	jb greska_znak
	cmpb $'z', %bl
	ja greska_znak
	subb $87, %bl

	provera:
	cmpl %ebx, %ecx
	jbe greska_znak
	ret

### MAIN ##########################
str_to_inter:
	pushl %ebp
	movl %esp, %ebp
	pushl %esi
	pushl %edi
	pushl %ebx

	movl 8(%ebp), %esi	# sadrzi adresu stringa
	movl 12(%ebp), %ecx	# sadrzi bazu

	# Namestimo registre
	movl $0, %eax	# koristi se za mnozenje
	movl $0, %edx
	movl $0, %ebx	# cuva trenutnu ucitan znak

petlja:
	cmpb $0, (%esi)
	je obrisi_stek

	# Ucitamo jedan znak i konvertujemo
	movb (%esi), %bl
	call konvertuj_u_malo
	call konvertuj_znak

	# Dodamo u registar broj
	mull %ecx
	cmpl $0, %edx
	jne greska_prekoracenje
	addl %ebx, %eax
	jc greska_prekoracenje

	incl %esi
	jmp petlja

### GRESKE ###########
greska_prekoracenje:
	movl 16(%ebp), %edi
	movl $1, (%edi)
	jmp obrisi_stek
greska_znak:
	movl 16(%ebp), %edi
	movl $2, (%edi)
######################

obrisi_stek:
	popl %ebx
	popl %edi
	popl %esi
	movl %ebp, %esp
	popl %ebp
	ret