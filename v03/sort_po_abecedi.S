# Sortiranje stringa po abecednom redu
# Koristi se bubble sort

.section .data
string: .ascii "rotlgfxtddpeoapqkwa\0"

.section .text
.global main

main:
	movl $string, %esi # indeksni registar
	movl $string, %edi # registar za adresu poslednjeg elementa stringa koji nije \0

broj_kraj:
	cmpl $0, (%edi)
	je nastavi
	incl %edi
	jmp broj_kraj

	nastavi:
	decl %edi

bubble_sort:
	movl $string, %esi
	cmpl $string, %edi
	jbe kraj

	jmp petlja
	petlja_nastavi:

	decl %edi	# smanjujemo edi kada sortiramo znak
	jmp bubble_sort

petlja:
	cmpl %edi, %esi
	je petlja_nastavi

	movb (%esi), %ah
	movb 1(%esi), %al

	cmpb %ah, %al	# poredjenje i zamena susedna dva znaka stringa
	jb zameni
	zameni_nastavi:
	
	incl %esi
	jmp petlja

zameni:
	movb %ah, 1(%esi)
	movb %al, (%esi)
	jmp zameni_nastavi

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
