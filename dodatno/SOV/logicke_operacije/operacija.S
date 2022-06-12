.section .text
.global operacija

operacija:
	pushl %ebp
	movl %esp, %ebp

	movl $0, %eax
	movl $0, %ecx
	movl 20(%ebp), %edi	# sadrzi adresu greske
	movb 16(%ebp), %al	# prvi operand
	movb 12(%ebp), %cl	# drugi operand

	# Određivanje operacije
	cmpb $'<', 8(%ebp)
	je rot_levo
	cmpb $'>', 8(%ebp)
	je rot_desno
	cmpb $'^', 8(%ebp)
	je eksluzivno_ili

	# Ako nije nijedna od operacija znaci da imamo pogresan znak
	movl $2, (%edi)
	jmp obrisi_stek

rot_levo:
	rolb %cl, %al
	jmp obrisi_stek
rot_desno:
	rorb %cl, %al
	jmp obrisi_stek
eksluzivno_ili:
	xorb %cl, %al

obrisi_stek:
	movl %ebp, %esp
	popl %ebp
	ret