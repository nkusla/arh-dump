# pili21 (Dusko Pilipovic)
# Program koji zamenjuje uzvicnike i upitnike datim stringovima

.section .data
str_len=101
poruka1: .ascii "Unesite string:\0"
dim1=.-poruka1
upitnik: .ascii ",pitamo se.\0"
dim2=.-upitnik
uzvicnik: .ascii ",vicemo.\0"
dim3=.-uzvicnik
string: .fill str_len,1,42
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
movl $str_len,%edx
int $0x80

movl %eax,duzina
movl $0,%eax               #indeks
movl $0,%ebx              #Indeks zamjene

trazi:
cmpb $'\n',string(,%eax,1)
je ispis
cmpb $'?',string(,%eax,1)
je upitnik1
cmpb $'!',string(,%eax,1)
je uzvicnik1
incl %eax
jmp trazi

upitnik1:
movl $0,%ebx
addl $dim2-2,duzina
cmpl $str_len,duzina
ja kraj			#Ide na kraj jer nema vise mjesta
movl duzina,%ecx
jmp pomjeraj

pomjeraj:                     #Pravi mjesta za string novi
cmpl %eax,%ecx
je zamjena
movb string(,%ecx,1),%dl
movb %dl,string+dim2-2(,%ecx,1)
decl %ecx
jmp pomjeraj

zamjena:			#Ubacuje string izmedju
cmpb $0,upitnik(,%ebx,1)
je trazi
movb upitnik(,%ebx,1),%dl
movb %dl,string(,%eax,1)
incl %ebx
incl %eax
jmp zamjena


#isto radimo i za uzvicnik

uzvicnik1:
movl $0,%ebx
addl $dim3-2,duzina
cmpl $str_len,duzina
ja kraj			#Ide na kraj jer nema vise mjesta
movl duzina,%ecx
jmp pomjeraj_u

pomjeraj_u:                     #Pravi mjesta za string novi
cmpl %eax,%ecx
je zamjena_u
movb string(,%ecx,1),%dl
movb %dl,string+dim3-2(,%ecx,1)
decl %ecx
jmp pomjeraj_u

zamjena_u:			#Ubacuje string izmedju
cmpb $0,uzvicnik(,%ebx,1)
je trazi
movb uzvicnik(,%ebx,1),%dl
movb %dl,string(,%eax,1)
incl %ebx
incl %eax
jmp zamjena_u


ispis:
movl $4,%eax
movl $1,%ebx
leal string,%ecx
movl duzina,%edx
int $0x80

kraj:
movl $1,%eax
movl $0,%ebx
int $0x80
