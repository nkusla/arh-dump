# pili21 (Dusko Pilipovic)
# Broji koliko ima velikih i malih slova u stringu i vraca broj kao izlaz iz programa

.section .data
poruka1: .ascii "Unesite string:\0"
dim1=.-poruka1
string: .fill 51,1,42
duzina: .long 0
broj_slova_m: .long 0
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
movl $0,%ebx              #Broji slovo m

broji:
cmpb $'\n',string(,%eax,1)
je kraj
cmpb $'m',string(,%eax,1)
je uvecaj
cmpb $'M',string(,%eax,1)
je uvecaj
incl %eax
jmp broji

uvecaj:
incl %eax
incl %ebx
jmp broji

kraj:
movl %ebx,broj_slova_m
movl $1,%eax
movl broj_slova_m,%ebx
int $0x80
