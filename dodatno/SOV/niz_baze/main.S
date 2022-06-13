### MAKORI ########################
.macro unos adresa size
	movl $3, %eax
	movl $0, %ebx
	movl \adresa, %ecx
	movl \size, %edx
	int $0x80
.endm

.macro ispis adresa size
	movl $4, %eax
	movl $1, %ebx
	movl \adresa, %ecx
	movl \size, %edx
	int $0x80
.endm

.macro izlaz kod
	movl $1, %eax
	movl \kod, %ebx
	int $0x80
.endm

### PODACI #########################
.section .data

unos_niz_str: .ascii "Unesite niz brojeva: \0"
unos_niz_size = . - unos_niz_str
unos_baze_str: .ascii "Unesite niz baza: \0"
unos_baze_size = . - unos_baze_str
rezultat_str: .ascii "Rezultat: \0"
rezultat_size = . - rezultat_str
greska1_str: .ascii "Doslo je do prekoracenja!\n"
greska1_size = . - greska1_str
greska2_str: .ascii "Unet je pogresan znak!\n"
greska2_size = . - greska2_str

MAX_SIZE = 31
string_br: .fill MAX_SIZE, 1, 0
string_baza: .fill MAX_SIZE, 1, 0
bafer: .fill MAX_SIZE, 1, 0
rez: .long 0
baza: .long 0
baza10: .long 10
greska: .long 0

.section .text
.global main

### RUTINE ##########################

# Poziva se nakon svakog potprograma da bi se proverilo stanje promenljive greska
provera_greske:
	cmpl $1, greska
	je greska_prekoracenje
	cmpl $2, greska
	je greska_znak
	ret

# Sluzi za ispis odgovarajuce greske
greska_prekoracenje:
	ispis $greska1_str $greska1_size
	jmp kraj
greska_znak:
	ispis $greska2_str $greska2_size
	jmp kraj

### MAIN ########################
main:
	# Unos stringa brojeva
	ispis $unos_niz_str $unos_niz_size
	unos $string_br $MAX_SIZE
	cmpb $32, string_br					# provera za prazan string
	je greska_znak

	# Unos stringa baza
	ispis $unos_baze_str $unos_baze_size
	unos $string_baza $MAX_SIZE
	cmpb $10, string_baza				# provera za prazan string
	je greska_znak

	movl $string_br, %esi				# adresni registar stringa brojeva
	movl $string_baza, %edi				# adresni registar stringa baza

petlja:
	cmpb $10, (%esi)
	je ispis_rezultata

	# Ucitamo bazu u bafer
	pushl %edi							# stavimo trenutnu poziciju pokazivaca stringa baza na stek
	pushl $bafer
	call ucitaj_u_bafer
	movl %eax, %edi						# sacuvamo pomeranje pokazivaca stringa u adresni registar
	# Konvertujemo bazu
	pushl $greska
	pushl baza10
	pushl $bafer
	call str_to_inter
	call provera_greske					# proverimo dal je doslo do greske pa onda sacuvamo povratnu vrednost
	movl %eax, baza

	# Ucitamo broj u bafer
	pushl %esi							# stavimo trenutnu poziciju pokazivaca stringa brojeva na stek
	pushl $bafer
	call ucitaj_u_bafer
	movl %eax, %esi						# sacuvamo pomeranje pokazivaca stringa u adresni registar
	# Konvertujemo broj
	pushl $greska
	pushl baza
	pushl $bafer
	call str_to_inter
	call provera_greske

	# Saberemo broj sa rezultatom
	addl %eax, rez
	jc greska_prekoracenje				# moze doci do prekoracenja sabiranjem

	jmp petlja

ispis_rezultata:

	# Konvertujemo rezultat u string
	pushl rez
	pushl $bafer
	call inter_to_str
	movl %eax, %edi						# sacuvamo koliko karaktera ima string (zbog ispisa)

	# Ispis
	ispis $rezultat_str $rezultat_size
	ispis $bafer %edi

kraj:
	izlaz $0
