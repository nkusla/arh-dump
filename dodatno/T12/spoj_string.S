# Program koji spaja dva stringa (ulazni stringovi su dužine do 50 karaktera, izlazni 100)

.section .data
SIZE = 50
str1: 	.fill SIZE, 1, 42
str2:	.fill SIZE, 1, 42
str1_size: .long 0
str2_size: .long 0

unos_1:	.ascii "Unesite prvi string: \0"
unos_2:	.ascii "Unesite drugi string: \0"
izlaz:	.ascii "Spojeno: \0"

.section .text
.global main

main:
	# Unos prvog stringa
	movl $4, %eax
	movl $1, %ebx
	movl $unos_1, %ecx
	movl $22, %edx
	int $0x80

	movl $3, %eax
	movl $0, %ebx
	movl $str1, %ecx
	movl $SIZE, %edx
	int $0x80
	movl %eax, str1_size
	decl str1_size

	# Unos drugog stringa
	movl $4, %eax
	movl $1, %ebx
	movl $unos_2, %ecx
	movl $23, %edx
	int $0x80

	movl $3, %eax
	movl $0, %ebx
	movl $str2, %ecx
	movl $SIZE, %edx
	int $0x80
	movl %eax, str2_size

	# Ispis spojenog stringa
	movl $4, %eax
	movl $1, %ebx
	movl $izlaz, %ecx
	movl $9, %edx
	int $0x80

	movl $4, %eax
	movl $1, %ebx
	movl $str1, %ecx
	movl str1_size, %edx
	int $0x80
	movl $4, %eax
	movl $1, %ebx
	movl $str2, %ecx
	movl str2_size, %edx
	int $0x80

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
