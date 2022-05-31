# Program za sabiranje dva broja u proizvoljnoj bazi
# Imenko Prezimić ra1234

# Napisati asemblerski program koji, koristeći potprograme za konverziju
# za bilo koju bazu 2‑36, vrši sabiranje dva neoznačena cela broja data u
# znakovnom obliku i rezultat vraća u znakovnom obliku. Sve konverzije
# raditi odmah nakon unosa, a u slučaju greške prekinuti dalji rad
# programa i ispisati odgovarajuću poruku. Primer korišćenja:
#       Unesite bazu broja:16
#       Unesite broj:Fa
#       Unesite bazu broja:8
#       Unesite broj:123
#       Unesite bazu rezultata:2
#       Rezultat:101001101
# Za ostale primere pokrenuti testiraj.sh.
# Dodatni primeri se mogu napraviti pomoću kalkulatora (Accessories/Calculator)

.section .data

### I/O stringovi
ulaz1:      .ascii "Unesite bazu broja:\0"
ulaz1_len = . - ulaz1
ulaz2:      .ascii "Unesite broj:\0"
ulaz2_len = . - ulaz2
ulaz3:      .ascii "Unesite bazu rezultata:\0"
ulaz3_len = . - ulaz3
izlaz1:     .ascii "Rezultat:\0"
izlaz1_len = . - izlaz1
greska1:    .ascii "Greska: pogresan znak!\0"
greska1_len = . - greska1
greska2:    .ascii "Greska: prekoracenje!\0"
greska2_len = . - greska2

### Promenljive
br_str: .fill 21, 1, 0
baza_str: .fill 21, 1, 0
baza: .long 0
rez: .long 0
rez_str: .fill 21, 1, 0
greska: .byte 0

.section .text
.global main

main:
	movl $0, %esi

### UNOS ################################
unos:
	cmpl $2, %esi
	je rezultat

	# Unos baze
	movl $4, %eax
	movl $1, %ebx
	movl $ulaz1, %ecx
	movl $ulaz1_len, %edx
	int $0x80

	movl $3, %eax
	movl $0, %ebx
	movl $baza_str, %ecx
	movl $21, %edx
	int $0x80

	# Poziv potprograma za konvertovanje unete baze
	pushl $greska
	pushl $10
	pushl $baza_str
	call str_to_inter
	movl %eax, baza
	call provera_greske
	call provera_baze

	#####################################

	# Unos broja
	movl $4, %eax
	movl $1, %ebx
	movl $ulaz2, %ecx
	movl $ulaz2_len, %edx
	int $0x80

	movl $3, %eax
	movl $0, %ebx
	movl $br_str, %ecx
	movl $21, %edx
	int $0x80

	# Poziv potprograma za konvertovanje unetog broja
	pushl $greska
	pushl baza
	pushl $br_str
	call str_to_inter
	call provera_greske

	addl %eax, rez
	jc greska_prekoracenje

	incl %esi
	jmp unos

### REZULTAT ############################
rezultat:

	# Unos baze rezultata
	movl $4, %eax
	movl $1, %ebx
	movl $ulaz3, %ecx
	movl $ulaz3_len, %edx
	int $0x80

	movl $3, %eax
	movl $0, %ebx
	movl $baza_str, %ecx
	movl $21, %edx
	int $0x80

	# Poziv potprograma za konvertovanje baze rezultata
	pushl $greska
	pushl $10
	pushl $baza_str
	call str_to_inter
	movl %eax, baza
	call provera_greske
	call provera_baze

	# Poziv potprograma za konvertovanje rezultata u string
	pushl $rez_str
	pushl baza
	pushl rez
	call inter_to_str

	# Ispis rezultata
	movl $4, %eax
	movl $1, %ebx
	movl $izlaz1, %ecx
	movl $izlaz1_len, %edx
	int $0x80
	movl $4, %eax
	movl $1, %ebx
	movl $rez_str, %ecx
	movl $21, %edx
	int $0x80

	jmp kraj

### GRESKE ##############################
provera_baze:
	cmpl $2, baza
	jb greska_prekoracenje
	cmpl $36, baza
	ja greska_prekoracenje
	ret

provera_greske:
	cmpl $1, greska
	je greska_znak
	cmpl $2, greska
	je greska_prekoracenje
	ret

greska_znak:
	movl $4, %eax
	movl $1, %ebx
	movl $greska1, %ecx
	movl $greska1_len, %edx
	int $0x80
	jmp kraj
greska_prekoracenje:
	movl $4, %eax
	movl $1, %ebx
	movl $greska2, %ecx
	movl $greska2_len, %edx
	int $0x80
	jmp kraj

######################################

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
