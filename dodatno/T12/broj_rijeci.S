# pili21 (Dusko Pilipovic)
# program broji rijeci u stringu na osnovi broja razmaka

.section .data
poruka: .ascii "Unesite string:\0"
dim=.-poruka
poruka1: .ascii "Ima rijeci:\n"
dim1=.-poruka1
string: .fill 51,1,42
duzina: .long 0
broj: .long 0
.section .text
.global main
main:

unos: 
movl $4,%eax
movl $1,%ebx
leal poruka,%ecx
movl $dim,%edx
int $0x80

movl $3,%eax
movl $0,%ebx
leal string,%ecx
movl $51,%edx
int $0x80

movl $0,%ecx
cmpl $1,%eax
je ispis
movl %eax,duzina #duzina stringa
movl $0,%ebx #indeks
movl $1,%ecx #broj rijeci

prodji:
cmpl %eax,%ebx
jae ispis
cmpb $' ',string(,%ebx,1)
je dodaj
incl %ebx
jmp prodji

dodaj:
incl %ecx
incl %ebx
jmp prodji

ispis:
movl %ecx,broj
movl $1,%eax
movl broj,%ebx
int $0x80


