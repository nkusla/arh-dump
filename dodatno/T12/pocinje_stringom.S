# pili21 (Dusko Pilipovic)
# Provjerava da li prvi string pocinje drugim

.section .data
poruka1: .ascii "Unesite string:\0"
dim1=.-poruka1
poruka2: .ascii "Unesite string sa kojim se provjerava da li pocinje prethodni:\0"
dim2=.-poruka2
poruka3: .ascii "String pocinje unijetim stringom\n"
dim3=.-poruka3
poruka4: .ascii "String ne pocinje unijetim stringom\n"
dim4=.-poruka4
string: .fill 51,1,42
duzina: .long 0
string_manji: .fill 51,1,42
duzina_manji: .long 0
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

movl $4,%eax
movl $1,%ebx
leal poruka2,%ecx
movl $dim2,%edx
int $0x80

movl $3,%eax
movl $0,%ebx
leal string_manji,%ecx
movl $51,%edx
int $0x80

movl %eax,duzina_manji
cmpl $1,%eax		#Nije unijeto nista u drugi
je kraj
movl $0,%ebx		#indeks
decl %eax		#Duzina manjeg bez \n

provjera:
cmpl %ebx,%eax
jbe poruka_da
movb string(,%ebx,1),%cl
cmpb %cl,string_manji(,%ebx,1)
jne poruka_ne
incl %ebx
jmp provjera


poruka_da:
movl $4,%eax
movl $1,%ebx
leal poruka3,%ecx
movl $dim3,%edx
int $0x80
jmp kraj



poruka_ne:
movl $4,%eax
movl $1,%ebx
leal poruka4,%ecx
movl $dim4,%edx
int $0x80

kraj:
movl $1,%eax
movl $0,%ebx
int $0x80
