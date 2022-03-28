# Trazenje indeksa svih minimalnih i maksimalnih elementa niza
# Radi za oznacene brojeve u jednostrukoj preciznosti

.section .data
SIZE = 12
niz: .long -10, -1, 3, 1, 0, 0, 8, 8, 2, -10, 4, 8
min_niz: .long -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1	# -1 znaci da je mesto u nizu "prazno"
max_niz: .long -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1

.section .text
.global main

main:
	movl $0, %esi			# indeksni reg glavnog niza
	movl niz(,%esi,4), %eax	# cuva minimalni elem
	movl niz(,%esi,4), %ebx	# cuva maksimalni elem

pronadji_elem:
	cmpl $SIZE, %esi
	je restart_reg

	# Proverava min elem
	cmpl niz(,%esi,4), %eax
	jng preskoci_min
	movl %esi, min_niz
	movl niz(,%esi,4), %eax
	preskoci_min:
	
	# Proverava max elem
	cmpl niz(,%esi,4), %ebx
	jnl preskoci_max
	movl %esi, max_niz
	movl niz(,%esi,4), %ebx
	preskoci_max:

	incl %esi
	jmp pronadji_elem

restart_reg:
	movl $0, %esi
	movl $0, %ecx	# indeksi reg min_niza
	movl $0, %edx	# indeksi reg max_niza
pronadji_indekse:
	cmpl $SIZE, %esi
	je kraj 

	# Dodavanje indeksa u min_niz
	cmpl niz(,%esi,4), %eax
	jne preskoci_min_indeks
	movl %esi, min_niz(,%ecx, 4)
	inc %ecx
	preskoci_min_indeks:

	# Dodavanje indeksa u max_niz
	cmpl niz(,%esi,4), %ebx
	jne preskoci_max_indeks
	movl %esi, max_niz(,%edx, 4)
	inc %edx
	preskoci_max_indeks:

	inc %esi
	jmp pronadji_indekse

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80