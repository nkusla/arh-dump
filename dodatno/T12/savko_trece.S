# pili21 (Dusko Pilipovic)
# Program svako trece slovo pretvara u veliko a preskace ono sto nije slovo

.section .data
poruka: .ascii "Unesite string:\0"
dim1=.-poruka
poruka1: .ascii "\nRezultat programa:\0"
dim2=.-poruka1
uneseni_string: .fill 51,1,42
duzina: .long 0
.section .text
.global main
main:

unos:
movl $4,%eax
movl $1,%ebx
movl $poruka,%ecx
movl $dim1,%edx
int $0x80

movl $3,%eax
movl $0,%ebx
movl $uneseni_string,%ecx
movl $51,%edx
int $0x80

movl %eax,duzina
movl $0,%ebx #indeks
movl $0,%edx

prolaz:
cmpl %ebx,duzina
jbe ispis
cmpb $64,uneseni_string(,%ebx,1)
jb uvecaj
cmpb $91,uneseni_string(,%ebx,1)
jb slovo
cmpb $97,uneseni_string(,%ebx,1)
jb uvecaj
cmpb $122,uneseni_string(,%ebx,1)
ja uvecaj

slovo:
incl %edx
cmpl $3,%edx
jne uvecaj

u_velika:
movb uneseni_string(,%ebx,1),%cl
subb $32,%cl
movb %cl,uneseni_string(,%ebx,1)
movl $0,%edx


uvecaj:
incl %ebx
jmp prolaz

ispis:
movl $4,%eax
movl $1,%ebx
movl $poruka1,%ecx
movl $dim2,%edx
int $0x80

movl $4,%eax
movl $1,%ebx
movl $uneseni_string,%ecx
movl duzina,%edx
int $0x80

kraj:
movl $1,%eax
movl $0,%ebx
int $0x80
