# pili21 (Dusko Pilipovic)
# Program broji rijeci u stringu na osnovi broja razmaka i izdvaja n-tu rijec u novi string

.section .data
RIJEC=3
poruka1: .ascii "Unesite string:\0"
dim1=.-poruka1
poruka2: .ascii "Nta rijec je:\0"
dim2=.-poruka2
string: .fill 51,1,42
duzina: .long 0
rec: .fill 51,1,42
duzina_rec: .long 0
.section .text
.global main
main:

unos: 
movl $4,%eax
movl $1,%ebx
leal poruka1,%ecx
movl $dim1,%edx
int $0x80

movl $3,%eax
movl $0,%ebx
leal string,%ecx
movl $51,%edx
int $0x80

cmpl $1,%eax		#nema rijeci u stringu
je kraj
movl $0,%eax
movl %eax,duzina #duzina stringa
movl $0,%ebx #indeks
movl $1,%ecx #broj rijeci
cmpl $RIJEC,%ecx   	#ako hocemo prvu rijec odma se prebacuje inace program trazi sledecu
je prebaci
incl %ebx

broji_rijeci:
cmpb $'\n',string(,%ebx,1)		#nema te rijeci u stringu idemo na kraj
je kraj
cmpb $' ',string-1(,%ebx,1)
je nasli_rec
incl %ebx
jmp broji_rijeci

nasli_rec:
incl %ecx
cmpl $RIJEC,%ecx
je prebaci
incl %ebx
jmp broji_rijeci

prebaci:
cmpb $'\n',string(,%ebx,1)		#ako je zadnja rijec izlaz iy programa
je ispis
cmpb $' ',string(,%ebx,1)		#Ako nije zadnja rijec izlaz iy programa
je ispis
movb string(,%ebx,1),%dl
xchgb rec(,%eax,1),%dl
incl duzina_rec
incl %eax
incl %ebx
jmp prebaci



ispis:
movb $'\n',rec(,%eax,1)
incl duzina_rec

movl $4,%eax
movl $1,%ebx
leal poruka2,%ecx
movl $dim2,%edx
int $0x80

movl $4,%eax
movl $1,%ebx
leal rec,%ecx
movl duzina_rec,%edx
int $0x80

kraj:
movl $1,%eax
movl $0,%ebx
int $0x80


