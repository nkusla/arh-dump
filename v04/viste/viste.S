# Program koji od korisnika traži da unese svoje ime i prezime,
# nakon čega na ekranu ispisuje ime i prezime gde su mala slova pretvorena u velika.

.section .data
poruka1: .ascii "Unesite ime i prezime: \0"
poruka2: .ascii "Vi ste: \0"
imeprez: .fill 50,1,42

.section .text
.global main

main:
	# Ispis prompta
	movl $4, %eax
	movl $1, %ebx
	movl $poruka1, %ecx
	movl $23, %edx
	int $0x80
	
	# Unos
	movl $3, %eax
	movl $0, %ebx
	movl $imeprez, %ecx
	movl $50, %edx
	int $0x80
	
	movl $0, %esi
petlja:
	movb imeprez(,%esi,1), %bl
	cmpb $10, %bl
	je ispis
	
	cmpb $97, %bl
	jae proveri
	proveri_nastavi:
	
	incl %esi
	jmp petlja

# Provera dal je znak malo slovo
proveri:
	cmpb $122, %bl
	jnbe proveri_nastavi
	
	subl $32, imeprez(,%esi,1)	# Pretvaranje malih u velika slova
	jmp proveri_nastavi
	
ispis:
	incl %esi
	movl $4, %eax
	movl $1, %ebx
	movl $poruka2, %ecx
	movl $8, %edx
	int $0x80
	
	movl $4, %eax
	movl $imeprez, %ecx
	movl %esi, %edx
	int $0x80
	
kraj:
	movl $0, %eax
	movl $1, %ebx
	int $0x80

