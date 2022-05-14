# Potprogram broji jedinice u 64-bitnom broju (prvih 63-bita) i 
# postavlja prvi bit na vrednost bita pariteta. Zatim rotira u levo ceo 64-bitan broj.
# Rotira se za onoliko mesta koliko ima jedinica u broju (ne racunajuci bit pariteta)
# Povratna vrednost je broj prebrojanih jedinica

.section .text
.global rotiranje64

rotiranje64:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp		# alociranje i inicijalizacija lokalne promenljive 
	movl $0, -4(%ebp)	# koja cuva broj prebrojanih jedinica
	pushl %esi

	# namestanje registara
	movl 8(%ebp), %eax	# eax pokazuje na nizi deo 64-bitnog broj
	movl $0, %esi		# brojac
	movl $1, %ecx		# maska

	andl $0x7fffffff, 4(%eax)	# postavljanje najznacajnijeg bita viseg dela na 0

br_jedinica:
	cmpl $32, %esi
	je postavi_paritet

	testl (%eax), %ecx
	jz visi_deo
	incl -4(%ebp)

	visi_deo:
	testl 4(%eax), %ecx
	jz nastavi
	incl -4(%ebp)

	nastavi:
	shll %ecx
	incl %esi
	jmp br_jedinica

postavi_paritet:
	movl -4(%ebp), %ecx
	andl $1, %ecx		# uklanjamo sve osim najamnje znacajnog bita (bit pariteta)
	rorl %ecx			# pomeramo ga na pocetak
	orl %ecx, 4(%eax)	# postavljamo bit pariteta na visem delu 64-bitnog broja

	movl -4(%ebp), %esi	# brojac rotiranja

rotiraj:
	cmpl $0, %esi
	je obrisi_stek

	# dve maske
	movl $0x80000000, %ecx
	movl $0x80000000, %edx
	andl (%eax), %ecx		# cuvamo najznacajniji bit nizeg dela 64-bitnog br	
	andl 4(%eax), %edx		# cuvamo najznacajniji bit viseg dela 64-bitnog br
	roll %ecx				# stavljamo bitove na pocetak maske
	roll %edx

	# shiftujemo u levo visi i nizi deo (na pocektu su 0 posle shiftovanja)
	shll (%eax)
	shll 4(%eax)

	# pepisujemo sacuvane bitove na pocetak nizeg i viseg dela broja
	orl %ecx, 4(%eax)
	orl %edx, (%eax)

	decl %esi
	jmp rotiraj

obrisi_stek:
	movl -4(%ebp), %eax	# cuvamo povratnu vrednost u eax
	movl $0, %edx

	popl %esi
	movl %ebp, %esp
	popl %ebp
	ret