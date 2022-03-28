# Pronalaze se samoglasnici u stringu i upisuju u novi string
# potom se novi string obrne. Koristi se indirektno adresiranje

.section .data
samogl: .string "AEIOUaeiou"	# string samoglasnika (asembler sam dodaje '\0' na kraj)
string: .ascii "MaQAkLdxoIMoyeLFURQnbI\0"
novi_string: .zero 25	# alocira se 25 bajtova tako da su svi ispunjeni nulama

.section .text
.global main

main:
	movl $string, %esi		# indeksni reg koji se pomera kroz string
	movl $novi_string, %edi	# indeksni reg za novi string

nadji:
	movb (%esi), %ch
	cmpb $0, %ch
	je restart_esi

	movl $samogl, %eax	# indeksni registar koji prolazi kroz string samoglasnika

	petlja:
	cmpl $samogl+10, %eax	# +10 jer imamo 10 samoglasnika
	je inc_esi

	movb (%esi), %ch
	cmpb (%eax), %ch
	je dodaj

	incl %eax
	jmp petlja

dodaj:
	movb %ch, (%edi)
	incl %edi
inc_esi:
	incl %esi
	jmp nadji

restart_esi:
	movl $novi_string, %esi
	decl %edi	# edi onda pokazuje na pretposlednji znak stringa (koji nije '\0')
obrni:
	cmpl %esi, %edi
	jbe kraj

	# zamena
	movb (%esi), %ch
	xchg %ch, (%edi)
	movb %ch, (%esi)

	inc %esi
	decl %edi
	jmp obrni

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80