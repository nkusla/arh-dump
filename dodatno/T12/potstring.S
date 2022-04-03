# Program koji broji koliko puta se jedan string pojavljuje u drugom
# Broj pojavljivanja se vraca kao izlazni kod programa
#
# Radi nad svim granicnim slucajevima:
# 1) slucaj nanananana i nana program vraca 4
# 2) slucaj ananananana i ana program vraca 5
# 3) slucaj ananana i a program vraca 4

.section .data
max_size = 21
unos_str: .ascii "Unesite string: \0"
unos_pstr: .ascii "Unesite potstring: \0"

string: .fill 20,1,42
string_size: .long 0
pstring: .fill 20,1,42
pstring_size: .long 0

.section .text
.global main

main:
	movl $4, %eax
	movl $1, %ebx
	movl $unos_str, %ecx
	movl $17, %edx
	int $0x80

	# Unos stinga
	movl $3, %eax
	movl $0, %ebx
	movl $string, %ecx
	movl $max_size, %edx
	int $0x80
	decl %eax	# zbog '\n'
	movl %eax, string_size

	movl $4, %eax
	movl $1, %ebx
	movl $unos_pstr, %ecx
	movl $20, %edx
	int $0x80
	
	# Unos potstringa
	movl $3, %eax
	movl $0, %ebx
	movl $pstring, %ecx
	movl $max_size, %edx
	int $0x80
	decl %eax	# zbog '\n'
	movl %eax, pstring_size

	movl $0, %esi	# indeksni reg za glavni string
	movl $0, %ebx	# broji pojavljivanja

prolazak_string:
	movl $0, %edi	# indeksni reg za potstring
	cmpl string_size, %esi
	je kraj

	# Provera prvog znaka
	movb string(,%esi,1), %cl
	cmpb pstring, %cl
	jne nastavi

	# Udje u petlju ako se prvi znak poklapa
	movl %esi, %eax
	petlja:
		cmpl pstring_size, %edi
		je inc_brojac

		movb string(,%eax,1), %cl 
		cmpb pstring(,%edi,1), %cl
		jne nastavi

		incl %eax
		incl %edi
	jmp petlja

	nastavi:
	incl %esi
	jmp prolazak_string

inc_brojac:
	incl %ebx
	incl %esi
	jmp prolazak_string

kraj:
	movl $1, %eax
	int $0x80