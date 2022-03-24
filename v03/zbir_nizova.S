# Sabiranje odgovoarajucih elemenata dva niza u element treceg niza
# Radi se u dvostrukoj preciznosti

.section .data
SIZE = 4
a: .quad 0x5C6031724, 0xF258635EF, 0xEAC66A8E53, 0x9ABB
b: .quad 0x8E98F115, 0xA, 0x4FA4B186F0, 0x7FEE
c: .quad 0, 0, 0, 0
greska: .byte 0

.section .text
.global main

main:
	movl $0, %esi

petlja:
	cmpl $SIZE, %esi
	je kraj

	# Sabiranje nizih delova
	movl a(,%esi,8), %eax
	movl b(,%esi,8), %ebx

	addl %eax, %ebx
	movl %ebx, c(,%esi,8)

	# Sabiranje visih delova
	movl a+4(,%esi,8), %eax
	movl b+4(,%esi,8), %ebx
	
	adcl %eax, %ebx
	movl %ebx, c+4(,%esi,8)
	
	# Provera greske
	jc promeni_greska
	incl %esi
	jmp petlja

promeni_greska:
	movb $1, %al
	movb %al, greska

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80