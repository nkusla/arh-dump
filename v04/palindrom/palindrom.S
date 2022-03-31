# Proveravanje da li je string palindrom.
# Opis algoritma:
#	1) sva velika slova se pretvore u mala
# 	2) sva mala slova i brojevi se kopiraju u novi string
#	3) Nameste se pokazivaci na pocetak i kraj novog stringa
#	i onda se pomeraju. Ako se znakovi na koje pokazuju pokazivaci
#	razlikuju, onda string nije palindrom. Ako se pokazivaci mimoidju
#	(pocetni postane veci od krajnjeg pokazivaca), string jeste palindrom

.section .data
poruka: .ascii "Unesite string:\0"
nijep:  .ascii "String nije palindrom.\n\0"
jestep: .ascii "String je palindrom.\n\0"
unos:   .fill 50,1,10
novi_str: .fill 50,1,10
.section .text
.global main

main:
	# Ispis prompta
	movl $4, %eax
	movl $1, %ebx
	movl $poruka, %ecx
	movl $15, %edx
	int $0x80
	
	# Unos
	movl $3, %eax
	movl $0, %ebx
	movl $unos, %ecx
	movl $50, %edx
	int $0x80
	movl $0, %esi

# Velika slova se pretvaraju u mala
pretvori_u_mala:
	movb unos(,%esi,1), %bl
	cmpb $'\n', %bl
	je restart_esi_1
	
	cmpb $'A', %bl
	jnae dalje_slovo
	cmpb $'Z', %bl
	jnbe dalje_slovo
	addl $32, unos(,%esi,1)
	dalje_slovo:
			
	incl %esi
	jmp pretvori_u_mala

restart_esi_1:
	movl $0, %esi
	movl $0, %edi
	
# Izdvajaju se mala slova i cifre od 0-9
izdvoj:
	movb unos(,%esi,1), %bl
	cmpb $'\n', %bl
	je restart_esi_2
	
	cmpb $'a', %bl
	jnae dalje_1
	cmpb $'z', %bl
	jnbe dalje_1
	movb %bl, novi_str(,%edi,1)
	incl %edi
	dalje_1:
	
	cmpb $'0', %bl
	jnae dalje_2
	cmpb $'9', %bl
	jnbe dalje_2
	movb %bl, novi_str(,%edi,1)
	incl %edi
	dalje_2:
	
	incl %esi
	jmp izdvoj

restart_esi_2:
	movl $0, %esi	# esi se koristi kao pokazivac na prvi znak
	decl %edi		# edi se koristi kao pokazivac na poslednji znak (koji nije '\n')

# Proveravanje dal je novi str palindrom
proveri:
	movb novi_str(,%esi,1), %bl
	cmpl %esi, %edi
	jna jeste
	
	cmpb novi_str(,%edi,1), %bl
	jne nije
	
	incl %esi
	decl %edi
	jmp proveri

jeste:
	movl $4, %eax
	movl $1, %ebx
	movl $jestep, %ecx
	movl $21, %edx
	int $0x80
	
	movl $1, %eax
	movl $0, %ebx
	int $0x80
nije:
	movl $4, %eax
	movl $1, %ebx
	movl $nijep, %ecx
	movl $23, %edx
	int $0x80

	movl $1, %eax
	movl $1, %ebx
	int $0x80

