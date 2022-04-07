# pili21 (Dusko Pilipovic)
# Program eliminise sve vodece pratece i visestruke razmake

.section .data
str_len=51
poruka1: .ascii "Unesite string:\0"
dim1=.-poruka1
poruka2: .ascii "Ovo je string bez nepotrebnih razmaka:\n\0"
dim2=.-poruka2
string: .fill str_len,1,42
duzina: .long 0
.section .text
.global main
main:

movl $4,%eax
movl $1,%ebx
leal poruka1,%ecx
movl $dim1,%edx
int $0x80

movl $3,%eax
movl $0,%ebx
leal string,%ecx
movl $str_len,%edx
int $0x80

movl %eax,duzina

movl $0,%eax #Indeks niza
movl $0,%ebx #brojac

sa_pocetka:				#ide dok ne dodje do prvog slova
cmpb $' ',string(,%eax,1)
jne smanji
incl %eax
jmp sa_pocetka

smanji:				#smanjuje duzinu stringa za broj razmaka
subl %eax,duzina
jmp pomjeri

pomjeri:				#pomjera sva slova za broj mjesta koliko je bilo razmaka
cmpl %eax,%ebx
jae sa_kraja
cmpb $'\n',string(,%ebx,1)
je sa_kraja
movb string(,%eax,1),%cl
xchgb string(,%ebx,1),%cl
incl %eax
incl %ebx
jmp pomjeri

sa_kraja:
movl duzina,%eax 			#pokazuje na kraj
decl %eax
movl $0,%ebx 				#broj razmaka
jmp pomjeri_do_slova

pomjeri_do_slova:			#Pomjera lijevo do prvog slova
cmpb $' ',string-1(,%eax,1)		#gleda da li je lijevo slovo
jne stavi_kraj
decl %eax
incl %ebx
jmp pomjeri_do_slova

stavi_kraj:
movb $'\n',string(,%eax,1)
subl %ebx,duzina
jmp izbaci_visestruke


izbaci_visestruke:
movl $-1,%eax	
movl $-1,%ecx		#indeks
movl $0,%ebx			#prati visestrukost
jmp potrazi_visestruke1

potrazi_visestruke1:
movl %ecx,%eax


potrazi_visestruke:
incl %eax		#Ako je razmak i %ebx veci od 1 ima vise razmaka
cmpb $'\n',string(,%eax,1)
je ispis
cmpb $' ',string(,%eax,1)
jne potrazi_visestruke
movl %eax,%ecx             #u %ecx cuvam mjesto prvog razmaka i do njega sve pomjeram
movl %eax,%ebx
cmpb $' ',string+1(,%eax,1)
je razmak
jmp potrazi_visestruke

razmak:
cmpb $' ',string+1(,%eax,1)
jne pomjeraj_sve
incl %eax
jmp razmak

pomjeraj_sve:
cmpb $'\n',string(,%eax,1)
je postavi_kraj
movb string(,%eax,1),%dl
xchgb string(,%ebx,1),%dl
incl %eax
incl %ebx
jmp pomjeraj_sve


postavi_kraj:
movl $'\n',string(,%ebx,1)
subl %ebx,%eax
subl %eax,duzina
jmp potrazi_visestruke1

ispis:
movl $4,%eax
movl $1,%ebx
leal poruka2,%ecx
movl $dim2,%edx
int $0x80

movl $4,%eax
movl $1,%ebx
leal string,%ecx
movl duzina,%edx
int $0x80

kraj:
movl $1,%eax
movl $0,%ebx
int $0x80
