.section .data
### Prompt str
unos_str: .ascii "Unesite string: \0"
unos_len = . - unos_str
suma_str: .ascii "Suma elemenata niza je: \0"
suma_len = . - suma_str
okt_str: .ascii "Broj oktalnih elemenata u nizu: \0"
okt_len = . - okt_str
dek_str: .ascii "Broj decimalnih elemenata u nizu: \0"
dek_len = . - dek_str

### Greske str
greska1_str: .ascii "Greska: pogresan karakter!\n"
greska1_len = . - greska1_str
greska2_str: .ascii "Greska: prekoracenje prilikom konverzije!\n"
greska2_len = . - greska2_str
greska3_str: .ascii "Greska: prekoracenje!\n"
greska3_len = . - greska3_str

string: .fill 51, 1, 10		# ulazni string
bafer: .fill 51, 1, 0		# bafer u kom se cuva jedan broj (u string formatu)
suma: .long 0
greska: .long 0
br_okt: .long 0				# brojac oktalnih brojeva		
br_dek: .long 0				# brojac dekadnih brojeva

.section .text
.global main

### MAIN ######################################
main:
	# Unos stringa
	movl $4, %eax
	movl $1, %ebx
	movl $unos_str, %ecx
	movl $unos_len, %edx
	int $0x80

	movl $3, %eax
	movl $0, %ebx
	movl $string, %ecx
	movl $31, %edx
	int $0x80

	# Edge case ako kornisk unese prazan string
	cmpl $10, string
	je greska_znak

	movl $string, %esi		# indeksni registar stringa

petlja:
	cmpb $10, (%esi)		# petlja prestaje kada dodjemo do \\n
	je ispis

	movl $bafer, %edi		# indeksni registar bafera

	# Dolazimo do prvog znaka koji je cifra (preskacemo razmak)
	cmpb $' ', (%esi)
	je nastavi
	call provera_znak	# Provera dal je znak u opsegu 0-9

	# Dodajemo broj u bafer
	upisi_u_bafer:
		# Prestajemo da ucitavamo u bafer kada dodjemo do razmaka ili \\n
		cmpb $10, (%esi)
		je dalje
		cmpb $' ', (%esi)
		je dalje
		call provera_znak

		# Dodajemo znak u bafer
		movb (%esi), %cl
		movb %cl, (%edi)

		incl %esi
		incl %edi
	jmp upisi_u_bafer

	# Dodavanje \\0 na kraj bafera
	dalje:
	movb $0, (%edi)

	# Poziv potprograma za konverziju iz str u interni bolik
	call provera_baze
	pushl $greska
	pushl %ecx
	pushl $bafer
	call str_to_inter

	call provera_greske
	addl %eax, suma
	jc greska_prekoracenje

	nastavi:
	incl %esi
	jmp petlja

ispis:
	### SUMA
	movl $4, %eax
	movl $1, %ebx
	movl $suma_str, %ecx
	movl $suma_len, %edx
	int $0x80
	# Konverzija
	pushl $bafer
	pushl suma
	call inter_to_str
	movl %eax, %edi
	# Ispis
	movl $4, %eax
	movl $1, %ebx
	movl $bafer, %ecx
	movl %edi, %edx
	int $0x80

	### OKTALNI
	movl $4, %eax
	movl $1, %ebx
	movl $okt_str, %ecx
	movl $okt_len, %edx
	int $0x80
	# Konverzija
	pushl $bafer
	pushl br_okt
	call inter_to_str
	movl %eax, %edi
	# Ispis
	movl $4, %eax
	movl $1, %ebx
	movl $bafer, %ecx
	movl %edi, %edx
	int $0x80


	### DEKADNI
	movl $4, %eax
	movl $1, %ebx
	movl $dek_str, %ecx
	movl $dek_len, %edx
	int $0x80
	# Konverzija 
	pushl $bafer
	pushl br_dek
	call inter_to_str
	movl %eax, %edi
	# Ispis
	movl $4, %eax
	movl $1, %ebx
	movl $bafer, %ecx
	movl %edi, %edx
	int $0x80

	jmp kraj

### Rutine za proveru ####################
provera_greske:
	cmpb $1, greska
	je greska_znak
	cmpb $2, greska
	je greska_konverzija
	cmpb $3, greska
	je greska_prekoracenje
	ret

provera_znak:
	cmpb $'0', (%esi)
	jb greska_znak
	cmpb $'9', (%esi)
	ja greska_znak
	ret

provera_baze:
	movl $10, %ecx
	incl br_dek
	cmpb $'0', bafer
	jne povratak
	cmpb $0, bafer+1	# edge case ako je samo 0 u baferu
	je povratak
	movl $8, %ecx
	incl br_okt
	decl br_dek
	povratak:
	ret

### Ispis greski #########################
greska_znak:
	movl $4, %eax
	movl $1, %ebx
	movl $greska1_str, %ecx
	movl $greska1_len, %edx
	int $0x80
	jmp kraj
greska_konverzija:
	movl $4, %eax
	movl $1, %ebx
	movl $greska2_str, %ecx
	movl $greska2_len, %edx
	int $0x80
	jmp kraj
greska_prekoracenje:
	movl $4, %eax
	movl $1, %ebx
	movl $greska3_str, %ecx
	movl $greska3_len, %edx
	int $0x80
	jmp kraj

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80