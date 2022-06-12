.section .text
.global str_to_inter

konverzija_u_malo:
	cmpb $'A', %bl
	jb dalje
	cmpb $'Z', %bl
	ja dalje
	addb $32, %bl
	dalje:
	ret

konverzija_znaka:
	# Konverzija za cifre od 0-9
	cmpb $'0', %bl
	jb greska_znak
	cmpb $'9', %bl
	ja slovo
	subb $48, %bl
	jmp provera

	# Konverzija malog slova
	slovo:
	cmpb $'a', %bl
	jb greska_znak
	cmpb $'z', %bl
	ja greska_znak
	subb $87, %bl

	# Provera dal je manje od baze
	provera:
	cmpb %bl, %cl
	jbe greska_znak

	ret

str_to_inter:
	pushl %ebp
	movl %esp, %ebp
	pushl %esi
	pushl %edi
	pushl %ebx

	movl 8(%ebp), %esi 	# pokazivac na pocetak stringa koji se konvertuje
	movl 12(%ebp), %edi # pokazivac na gresku
	movl $0, %eax
	
provera_baze:
	movl $10, %ecx
	cmpb $'0', (%esi)
	jne petlja
	incl %esi
	cmpb $'x', (%esi)
	jne petlja
	incl %esi
	movl $16, %ecx

petlja:
	cmpb $0, (%esi)
	je obrisi_stek

	movb (%esi), %bl
	call konverzija_u_malo
	call konverzija_znaka

	mulb %cl
	cmpb $0, %ah
	jne greska_prekoracenje

	addb %bl, %al
	jc greska_prekoracenje

	incl %esi
	jmp petlja

greska_prekoracenje:
	movl $1, (%edi)
	jmp obrisi_stek
greska_znak:
	movl $2, (%edi)

obrisi_stek:
	popl %ebx
	popl %edi
	popl %esi
	movl %ebp, %esp
	popl %ebp
	ret