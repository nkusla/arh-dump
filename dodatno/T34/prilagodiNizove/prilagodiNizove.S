.section .text
.global prilagodiNizove

prilagodiNizove:
	pushl %ebp
	movl %esp, %ebp
	subl $8, %esp		# lokalna 64-bitna promenljiva (sluzi za povratnu vrednost)
	pushl %esi
	pushl %ebx

	# namestanje registara
	movl 12(%ebp), %ebx	# pokazivac na prvi elem niz b
	movl 8(%ebp), %eax	# pokazivac na prvi elem niza a
	movl $0, %esi 		# brojac
	movl $0, -4(%ebp)
	movl $0, -8(%ebp) 

petlja:
	cmpl 16(%ebp), %esi
	je sacuvaj_povratnu

	# poredjenje elemenata iz a i b
	movl (%eax, %esi, 4), %edx	# u edx privremeno ide elem iz a
	cmpl %edx, (%ebx, %esi, 4)
	jb oduzmi_a_b
	ja oduzmi_b_a

	# ako a == b, invertuje im se 3. bit (bit sa tezinom 8)
	xorl $0x8, (%eax,%esi,4)
	xorl $0x8, (%ebx,%esi,4)

	nastavi:
	incl %esi
	jmp petlja

oduzmi_a_b:
	movl (%eax, %esi, 4), %edx
	subl (%ebx, %esi, 4), %edx
	addl %edx, -4(%ebp)
	adcl $0, -8(%ebp)
	jmp nastavi

oduzmi_b_a:
	movl (%ebx, %esi, 4), %edx
	subl (%eax, %esi, 4), %edx
	addl %edx, -4(%ebp)
	adcl $0, -8(%ebp)
	jmp nastavi

sacuvaj_povratnu:
	movl -4(%ebp), %eax
	movl -8(%ebp), %edx

obrisi_stek:
	popl %ebx
	popl %esi
	movl %ebp, %esp
	popl %ebp
	ret
