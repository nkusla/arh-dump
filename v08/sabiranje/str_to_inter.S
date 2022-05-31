.section .text
.global str_to_inter

convert_to_small:
	cmpb $'A', %bl
	jb dalje
	cmpb $'Z', %bl
	ja dalje
	addb $32, %bl

	dalje:
	ret

convert_char:
	# Provera dal je cifra 0-9
	cmpb $'0', %bl
	jb greska_znak
	cmpb $'9', %bl
	ja slovo
	subb $48, %bl
	jmp provera

	# Provera dal je malo slovo
	slovo:
	cmpb $'a', %bl
	jb greska_znak
	cmpb $'z', %bl
	ja greska_znak
	subb $87, %bl

	# Provera dal je manje od baze
	provera:
	cmpl %ebx, %ecx
	jbe greska_znak

	ret

str_to_inter:
	pushl %ebp
	movl %esp, %ebp
	pushl %esi
	pushl %ebx

	# Namestanje greske na 0
	movl 16(%ebp), %esi
	movl $0, (%esi)

	# Registri
	movl 8(%ebp), %esi		# pokazuje na pocetak stringa
	movl 12(%ebp), %ecx		# sadrzi bazu brojnog sistema
	movl $0, %eax			# visi i nizi povratnog internog broja
	movl $0, %edx

	# Provera prazan string
	cmpb $10, (%esi)
	je greska_znak

petlja:
	cmpb $10, (%esi)
	je obrisi_stek

	movb (%esi), %bl
	call convert_to_small
	call convert_char

	# Mnozenje sa bazom
	mull %ecx
	cmpl $0, %edx
	jne greska_prekoracenje
	
	# Dodavanje konvertovanog znaka
	addl %ebx, %eax
	jc greska_prekoracenje

	incl %esi
	jmp petlja

### GRESKE ###
greska_znak:
	movl 16(%ebp), %esi
	movl $1, (%esi)
	jmp obrisi_stek
greska_prekoracenje:
	movl 16(%ebp), %esi
	movl $2, (%esi)
	jmp obrisi_stek

obrisi_stek:
	popl %ebx
	popl %esi
	movl %ebp, %esp
	popl %ebp
	ret