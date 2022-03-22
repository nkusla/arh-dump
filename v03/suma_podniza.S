# Racunanje sume nekog podniza
# Indeksi prvog i poslednjeg elementa podniza 
# su dati u vidu konstanti

.section .data
NELEM = 10
START = 2
END = 5
niz: .long 1,2,3,4,5,6,7,8,9,10
suma: .long 0

.section .text
.global main

main:
	movl $0, %esi	# indeks
	movl $0, %eax	# suma
	
pomeri:
	incl %esi
	cmpl $START, %esi	
	jb pomeri
	
petlja:
	addl niz(, %esi, 4), %eax
	incl %esi
	
	cmpl $END, %esi
	jbe petlja

kraj:
	movl %eax, suma

	movl $1, %eax
	movl $0, %ebx
	int $0x80
