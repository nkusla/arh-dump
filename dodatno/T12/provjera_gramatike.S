# pili21 (Dusko Pilipovic)
# Program provjerava da li se poslije svake tacke nalazi tacno jedan razmak i veliko slovo

.section .data
poruka1: .ascii "Unesite string:\0"
dim1=.-poruka1
poruka2: .ascii "Ispravno je sve\n\0"
dim2=.-poruka2
poruka3: .ascii "Nije ispravan string\n\0"
dim3=.-poruka3
string: .fill 51,1,42
duzina: .long 0
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

movl %eax,duzina
movl $0,%eax               #indeks

prolazi:
cmpb $'\n',string(,%eax,1)
je ispravno
cmpb $'.',string(,%eax,1)
je provjeri
incl %eax
jmp prolazi


provjeri:
cmpb $'\n',string+1(,%eax,1) #Ako je tacka na kraju kraj provjere i ne provjeravamo iza nje
je ispravno
cmpb $'\n',string+2(,%eax,1)
je ispravno
cmpb $' ',string+1(,%eax,1)
jne nije_ispravno
cmpb $'A',string+2(,%eax,1)
jb nije_ispravno
cmpb $'Z',string+2(,%eax,1)
ja nije_ispravno
incl %eax
jmp prolazi

nije_ispravno:
movl $4,%eax
movl $1,%ebx
leal poruka3,%ecx
movl $dim3,%edx
int $0x80
jmp kraj

ispravno:
movl $4,%eax
movl $1,%ebx
leal poruka2,%ecx
movl $dim2,%edx
int $0x80

kraj:
movl $1,%eax
movl $0,%ebx
int $0x80
