# Pogram koji traži unos stringa str1 (maks duzine 100 bajtova) i nalazi
# koliko znakova u unetom stringu nisu alfanumerici (nisu ni slovo i nisu cifra). Svaki od
# tih znakova zameniti znakom '0' (nula) i ispisati tako dobijeni string, a broj
# zamenjenih karaktera postaviti u 8-bitnu promenljivu not_alphanum i vratiti ga kao
# izlazni kod programa.

.section .data
unos_str: .ascii "Unesite string: \0"
unos_size = . - unos_str
ispravljeni_str: .ascii "Ispravljeni string je: \0"
ispravljeni_size = . - ispravljeni_str

max_size = 100
str1: .fill max_size, 1, 42
not_alphanum: .byte 0

.section .text
.global main

main:
	# Unos prompt
	movl $4, %eax
	movl $1, %ebx
	movl $unos_str, %ecx
	movl $unos_size, %edx
	int $0x80

	# Unos stringa
	movl $3, %eax
	movl $0, %ebx
	movl $str1, %ecx
	movl $max_size, %edx
	int $0x80
	decl %eax		# eax pamti broj znakova stringa, dekrement zbog '\n'

	movl $0, %esi	# indeksni reg stringa

petlja:
	cmpl %eax, %esi
	je ispis

	movb str1(,%esi,1), %cl

	# Provera cifre
	cmpb $'0', %cl
	jnae promeni
	cmpb $'9', %cl
	jbe dalje

	# Provera velikog slova
	cmpb $'A', %cl
	jnae promeni
	cmpb $'Z', %cl
	jbe dalje

	# Provera malog slova
	cmpb $'a', %cl
	jnae promeni
	cmpb $'z', %cl
	jbe dalje

	promeni:
	movb $'0', str1(,%esi,1)
	incl not_alphanum

	dalje:
	incl %esi
	jmp petlja

ispis:
	# Ispis prompt
	movl $4, %eax
	movl $1, %ebx
	movl $ispravljeni_str, %ecx
	movl $ispravljeni_size, %edx
	int $0x80

	# Ispis novog stringa
	movl $4, %eax
	movl $1, %ebx
	movl $str1, %ecx
	movl %esi, %edx		# eax je promenjen, ali esi porlse petlje sadrzi broj znakova stringa
	int $0x80

kraj:
	movl $1, %eax
	movl not_alphanum, %ebx
	int $0x80