# Trazenje minimalnog i maksimalnog elementa niza

.section .data
NELEM = 7
niz: .long 100, 32, 99, 69, 42, 101, 77
max: .long 0
min: .long 0

.section .text
.global main

main:
	movl $niz, %esi		# indeksni registar
	movl (%esi), %eax	# registar za max
	movl (%esi), %ebx	# registar za min
	
petlja:
	cmpl %eax, (%esi)
	ja promeni_max
nastavi_1:
	cmpl %ebx, (%esi)
	jb promeni_min
nastavi_2:

	addl $4, %esi
	cmpl $niz+NELEM*4, %esi
	jae kraj
	jmp petlja
	
promeni_max:
	movl (%esi), %eax
	jmp nastavi_1
promeni_min:
	movl (%esi), %ebx
	jmp nastavi_2

kraj:
	movl %eax, max
	movl %ebx, min

	movl $1, %eax
	movl $0, %ebx
	int $0x80
