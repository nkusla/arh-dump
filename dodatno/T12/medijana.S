# Trazi se medijana nekog niza. Medijana je vrednost srednjeg elementa niza (srednji kao u sredini sortiranog niza), 
# ako niz ima dva srednja elementa tj. paran broj clanova tada je medijana aritmeticka sredina ta dva srednja elementa. 
# Niz se prvo sortira pa se tek onda trazi medijana. Koristi se bubble sort i elementi niza su oznaceni brojevi u dvostrukoj preciznosti.

.section .data
SIZE = 6
niz: .quad 0xFFFFFFFFFFFFFFFF, 0x000000000AAAAAAA, 0xFFFFFFFFABC00000, 0x7AAAAAAAAAAAAAAA, 0xF000000000000001, 0x0000000000ABCDEF
medijana: .quad 0
greska: .byte 0

.section .text
.global main

main:
	movl $SIZE-1, %edi
bubble_sort:
	cmpl $0, %edi
	je nadji

	movl $0, %esi
	petlja:
		cmpl %esi, %edi
		je decl_edi

		movl niz(,%esi,8), %eax		# donja 4 bajta
		movl niz+4(,%esi,8), %ebx	# gornja 4 bajta

		cmpl niz+12(,%esi,8), %ebx	# poredimo gornja 4 bajta sledeceg elementa sa gornja 4 trenutnog
		jg zameni
		jne nastavi
		cmpl niz+8(,%esi,8), %eax	# poredimo donja 4 bajta sledeceg elementa sa donja 4 trenutnog
		ja zameni
		
		nastavi:
		incl %esi
	jmp petlja

	decl_edi:
	decl %edi
	jmp bubble_sort

zameni:
	xchg %eax, niz+8(,%esi,8)
	xchg %ebx, niz+12(,%esi,8)
	movl %eax, niz(,%esi,8)
	movl %ebx, niz+4(,%esi,8)

	jmp nastavi

nadji:
	# Racunanje indeks srednjeg elementa
	movl $SIZE, %eax
	movl $0, %edx
	movl $2, %ecx
	div %ecx
	cmpl $0, %edx
	je racunaj_srednu

	# Ako ima neparan broj elemenata sredni element 
	# se samo upise u promenljivu medijana
	movl niz(,%eax,8), %ebx
	movl %ebx, medijana
	movl niz+4(,%eax,8), %ebx
	movl %ebx, medijana+4
	jmp kraj

racunaj_srednu:
	# esi i edi su indeksi dva srednja elementa
	movl %eax, %esi
	decl %eax
	movl %eax, %edi

	movl niz(,%esi,8), %eax
	movl niz+4(,%esi,8), %ebx
	addl niz(,%edi,8), %eax		# eax je donji deo zbira
	adcl niz+4(,%edi,8), %ebx	# ebx je gorni deo zbira
	jo prekoracenje

	movl $0, %ecx
	movl $0, %edx

	cmpl $0, %ebx
	jge del_oduzimanjem
	
	del_sabiranjem:
		cmpl $0xFFFFFFFF, %ebx
		jl saberi
		jne kraj
		cmpl $0xFFFFFFFE, %eax
		jnbe kraj

		saberi:
		addl $2, %eax
		adcl $0, %ebx

		subl $1, medijana
		sbbl $0, medijana+4
		
		jmp del_sabiranjem

	del_oduzimanjem:
		cmpl $0, %ebx
		jg oduzmi
		jne kraj
		cmpl $2, %eax
		jnae kraj

		oduzmi:
		subl $2, %eax
		sbbl $0, %ebx

		addl $1, medijana
		adcl $0, medijana+4
		
		jmp del_oduzimanjem

prekoracenje:
	movl $1, greska
kraj:
	movl $1, %eax
	movl greska, %ebx
	int $0x80
