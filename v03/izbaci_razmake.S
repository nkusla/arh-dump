# Izbacivanje razmaka sa kraja i pocetka stringa
# Izmenjeni string se smesta na pocetku pocetnog stringa

.section .data
string: .ascii "   tes.=00+&     \0"

.section .text
.global main

main:
	movl $string, %esi	# indeksni registar
	movl $string, %eax	# adresni registar za prvi elem od pocetka koji nije ' '
	movl $string, %ebx	# adresni registar za prvi elem od kraja koji nije ' '
	
dodji_kraj:
	cmpb $0, (%esi)
	je broj_kraj
	incl %esi
	incl %ebx
	jmp dodji_kraj
	
broj_kraj:
	cmpb $' ', (%esi)
	jne nastavi_1
	decl %esi
	decl %ebx
	jmp broj_kraj

nastavi_1:
	movl $string, %esi
broj_pocetak:
	cmpb $' ', (%esi)
	jne nastavi_2
	incl %esi
	incl %eax
	jmp broj_pocetak

nastavi_2:
	movl $string, %esi
promeni:				# prepisivanje potstring na pocetak pocetnog stringa
	cmpl %ebx, %eax
	je kraj

	movb (%eax), %dl
	movb %dl, (%esi)
	incl %esi
	incl %eax
	jmp promeni

kraj:
	incl %esi
	movb $0, (%esi) # dodavanje \0 na kraj prepisanog potstringa

	movl $1, %eax
	movl $0, %ebx
	int $0x80
