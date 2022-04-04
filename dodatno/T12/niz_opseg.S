# Dat je niz niz2, koji je niz označenih 64-bitnih brojeva (dvostruka preciznost). Naći
# koliko se elemenata niza nalazi van opsega [-5000000000 (minus 5 milijardi),
# 6000000000 (6 milijardi)]. Dobijen broj postaviti u 8-bitnu promenljivu van_opsega i
# vratiti ga kao izlazni kod programa.

.section .data
SIZE = 7
niz2: .quad 0xFFFFFFFED5FA0A00, 0x000000010F882D30, 0x45, 0x0A00000165A0BC00, 0x01, 0x69, 0x0FFFFFFFFFFFFFFF
inf: .quad 0xFFFFFFFED5FA0E00	# -5 milijadi
sup: .quad 0x0000000165A0BC00	# 6 milijadri
van_opsega: .byte 0

.section .text
.global main

main:
	movl $0, %esi

petlja:
	cmpl $SIZE, %esi
	je kraj

	movl niz2(,%esi,8), %eax	# nizih 4 bajta
	movl niz2+4(,%esi,8), %edx	# visih 4 bajta

	# provera donje granice
	cmpl inf+4, %edx
	jl prekoracenje
	jne gornja_granica
	cmpl inf, %eax
	jl prekoracenje

	# provera gornje granice
	gornja_granica:
	cmpl sup+4, %edx
	jg prekoracenje
	jne dalje
	cmpl sup, %eax
	jg prekoracenje

	dalje:
	incl %esi
	jmp petlja

prekoracenje:
	incb van_opsega
	jmp dalje

kraj:
	movl $1, %eax
	movl $0, %ebx
	movb van_opsega, %bl
	int $0x80