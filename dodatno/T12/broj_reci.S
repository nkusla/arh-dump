# Program koji broji koliko reci ima u stringu. Rec se nalazi izmedju razmaka
# String moze da ima razmake na pocetku, na kraju i izmedju svake reci moze da bude
# vise od jednog razmaka. String ima maksimalno 50 znakova.

.section .data
SIZE = 51
str_unos: .ascii "Unesite string: \0"
string:	.fill SIZE, 1, 42
br_reci: .byte 0

.section .text
.global main

main:
	movl $4, %eax
	movl $1, %ebx
	movl $str_unos, %ecx
	movl $17, %edx
	int $0x80

	movl $3, %eax
	movl $0, %ebx
	movl $string, %ecx
	movl $SIZE, %edx
	int $0x80

	movl %eax, %edi
	decl %edi
	movl $0, %esi

postavi_pocetak:
	cmpl $SIZE, %esi
	je kraj
	cmpb $' ', string(,%esi,1)
	jne postavi_kraj
	incl %esi
	jmp postavi_pocetak

postavi_kraj:
	cmpb $' ', string(,%edi,1)
	jne petlja
	decl %edi
	jmp postavi_kraj

petlja:
	cmpl %esi, %edi
	jbe kraj

	movb string(,%esi,1), %cl
	cmpb $' ', %cl
	jne broj_rec

	incl %esi
	jmp petlja

broj_rec:
	cmpl %esi, %edi
	jbe inc_brojac
	movb string(,%esi,1), %cl
	cmpb $' ', %cl
	je inc_brojac

	incl %esi
	jmp broj_rec
inc_brojac:
	incl br_reci
	jmp petlja

kraj:
	movl $1, %eax
	movl br_reci, %ebx
	int $0x80