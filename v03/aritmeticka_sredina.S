# Racunanje aritmeticke sredine niza oznacenih brojeva
# Koristi se div komanda za deljenje

.section .data
SIZE = 15
niz: .long 729,928,-498,255,537,475,-281,394,989,219,-182,-19,129,197,811
vrednost: .long 0
ostatak: .long 0

.section .text
.global main

main:
	movl $niz, %esi	# indeksni registar
	movl $0, %eax	# registar za sumu (niži deo)
	movl $0, %edx	# registar za sumu (viši deo)

petlja:
	cmpl $niz+SIZE*4, %esi
	je podeli

	addl (%esi), %eax
	addl $4, %esi
	
	jmp petlja

podeli:
	movl $SIZE, %ecx
	idivl %ecx
	movl %eax, vrednost
	movl %edx, ostatak

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80