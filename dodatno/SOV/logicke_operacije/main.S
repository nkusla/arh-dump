### MARKOI ###############
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

### PODACI ####################
.section .data
unos_str: 		.ascii "Unesite logicki izraz: \0"
unos_size = 	. - unos_str
rezultat_str: 	.ascii "Rezultat: \0"
rezultat_size = . - rezultat_str
greska1_str:	.ascii "Doslo je do prekoracenja.\n"
greska1_size = . - greska1_str
greska2_str:	.ascii "Greska kod operanda.\n"
greska2_size = . - greska2_str

MAX_SIZE = 100
string: .fill MAX_SIZE, 1, 0
bafer: 	.fill MAX_SIZE, 1, 0
oper:	.ascii " "
operand:.long 0
rez:	.long 0
greska: .long 0

### RUTINE ####################
.section .text
.global main

ucitaj_operand:
	movl $bafer, %edi

	pomeri:
		cmpb $10, (%esi)
		je dalje
		cmpb $' ', (%esi)
		je dalje
		movb (%esi), %cl
		movb %cl, (%edi)
		incl %edi
		incl %esi
	jmp pomeri

	dalje:
	movb $0, (%edi)
	ret

provera_greske:
	cmpl $1, greska
	je greska_prekoracenje
	cmpl $2, greska
	je greska_znak
	ret

greska_prekoracenje:
	ispis $greska1_str $greska1_size
	movl $1, greska
	jmp kraj
greska_znak:
	ispis $greska2_str $greska2_size
	movl $1, greska
	jmp kraj

### MAIN ######################
main:
	### Unos stringa
	ispis $unos_str $unos_size
	unos $string $MAX_SIZE

	movl $string, %esi	# pokazivac na pocetak stringa

pocetak:
	# Ucitamo prvi operand
	call ucitaj_operand
	# Konvertujemo prvi operand
	pushl $greska
	pushl $bafer
	call str_to_inter
	movl %eax, rez
	call provera_greske

petlja:
	cmpb $10, (%esi)
	je ispis_rezultata

	# Ucitamo operaciju
	incl %esi
	movb (%esi), %cl
	movb %cl, oper
	addl $2, %esi

	# Ucitamo sledeci operand
	call ucitaj_operand
	# Konvertujemo sledeci operand
	pushl $greska
	pushl $bafer
	call str_to_inter
	movl %eax, operand
	call provera_greske

	# Pozovemo potprogram za operaciju
	pushl $greska
	pushl rez
	pushl operand
	pushl oper
	call operacija
	movl %eax, rez
	call provera_greske		# provera dal je doslo do greske u izvrsavanju operacije

	jmp petlja

ispis_rezultata:
	ispis $rezultat_str $rezultat_size

	pushl $bafer
	pushl rez
	call inter_to_str
	movl %eax, %edi
	
	ispis $bafer %edi

kraj:
	izlaz greska