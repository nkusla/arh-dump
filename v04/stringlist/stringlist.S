# Program koji omogućava unos 10 stringova dužine do 20 znakova,
# nakon čega ih na ekranu ispisuje u obrnutom redosledu.

.section .data
str_unos:   .ascii "Unesite string:\0"
str_ispis:  .ascii "\nObrnuti redosled:\n\0"

str_len = 21    # dužina jednog stringa (20 znakova + Enter)
str_num = 10    # broj stringova
strings:	.fill str_len*str_num,1,42
str_lens:	.fill str_num,4,0	# niz dužina unetih stringova

.section .text
.global main

main:
	movl $0, %esi
unos_petlja:
	cmpl $str_num, %esi
	je promp_ispis

	# Prompt za ispis
	movl $4, %eax
	movl $1, %ebx
	movl $str_unos, %ecx
	movl $16, %edx
	int $0x80

	# Pomeranje na sledeci blok u strings delu
	movl $str_len, %eax
	mull %esi
	movl $strings, %ecx
	addl %eax, %ecx		# nameštanje ecx na pravu adresu za upis

	# Unos jednog stringa
	movl $3, %eax
	movl $0, %ebx
	movl $str_len, %edx
	int $0x80

	# Belezenje duzine unetog stringa
	movl %eax, str_lens(,%esi,4)

	incl %esi
	jmp unos_petlja

promp_ispis:
	movl $4, %eax
	movl $1, %ebx
	movl $str_ispis, %ecx
	movl $20, %edx
	int $0x80

	movl $str_num-1, %esi	# esi je indeks poslednjeg od 10 stringova

ispisi_obrnuto:
	cmpl $-1, %esi
	je kraj

	movl $str_len, %eax
	mull %esi
	movl $strings, %ecx
	addl %eax, %ecx

	movl $4, %eax
	movl $1, %ebx
	movl str_lens(,%esi,4), %edx
	int $0x80

	decl %esi
	jmp ispisi_obrnuto

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
