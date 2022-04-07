# pili21 (Dusko Pilipovic)
# Unose se dva stringa i onda se iz prvog stringa izbacuju svi znakovi 
# koji se nalaze u drugom i prebacuju se u pomocni koji se ispisuje

.section .data
str_len=100
poruka1: .ascii "Unesite string:\0"
dim1=.-poruka1
poruka2: .ascii "String koji govori koje znakove izbacujemo:\0"
dim2=.-poruka2
string: .fill str_len,1,42
duzina: .long 0
izbaci: .fill str_len,1,42
duzina1: .long 0
pomocni: .fill str_len,1,42
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
movl $str_len,%edx
int $0x80

movl %eax,duzina1

movl $4,%eax
movl $1,%ebx
leal poruka2,%ecx
movl $dim2,%edx
int $0x80


movl $3,%eax
movl $0,%ebx
leal izbaci,%ecx
movl $str_len,%edx
int $0x80

movl %eax,duzina1
movl $-1,%eax               #indeks
movl $0,%edx                #Indeks pomocnog

prebaci_odgovarajuce:
incl %eax
cmpb $'\n',string(,%eax,1)
je ispis
movb string(,%eax,1),%cl
jmp pripremi

pripremi:
movl $-1,%ebx
jmp uporedi

uporedi:
incl %ebx
cmpb $'\n',izbaci(,%ebx,1)
je prebaci_slovo
cmpb %cl,izbaci(,%ebx,1)
je prebaci_odgovarajuce
jmp uporedi

prebaci_slovo:
movb %cl,pomocni(,%edx,1)
incl %edx
jmp prebaci_odgovarajuce


ispis:
movl %edx,duzina
movb $'\n',pomocni(,%edx,1)
incl duzina
movl $4,%eax
movl $1,%ebx
leal pomocni,%ecx
movl duzina,%edx
int $0x80

kraj:
movl $1,%eax
movl $0,%ebx
int $0x80
