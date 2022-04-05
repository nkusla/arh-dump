# pili21 (Dusko Pilipovic)
# Program uporedjuje da li u unijetom stringu ima vise velikih ili malih slova i broj njihov ispisuje kao izlaz iz programa

.section .data
str_len=55
poruka1: .ascii "Unesite string za provjeru:\0"
dim1=.-poruka1
poruka2: .ascii "U stringu ima vise malih slova\n\0"
dim2=.-poruka2
poruka3: .ascii "U stringu ima vise velikih slova\n\0"
dim3=.-poruka3
poruka4: .ascii "Ima isti broj velikih i malih slova\n\0"
dim4=.-poruka4
string: .fill str_len,1,42
n_malih: .long 0
n_velikih: .long 0
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
movl $0,%eax #indeks
movl $0,%ebx #malih
movl $0,%ecx #velikih

broji:
cmpb $'\n',string(,%eax,1)
je poredi
cmpb $'A',string(,%eax,1)
jb uvecaj
cmpb $'Z',string(,%eax,1)
jb veliko
cmpb $'a',string(,%eax,1)
jb uvecaj
cmpb $'z',string(,%eax,1)
ja uvecaj
incl %ebx
incl %eax
jmp broji

veliko:
incl %ecx

uvecaj:
incl %eax
jmp broji

poredi:
movl %ebx,n_malih
movl %ecx,n_velikih
cmpl %ebx,%ecx
je jednako
ja velikih
jmp malih

velikih:
movl $4,%eax
movl $1,%ebx
leal poruka3,%ecx
movl $dim3,%edx
int $0x80

movl $1,%eax
movl n_velikih,%ebx
int $0x80

malih:
movl $4,%eax
movl $1,%ebx
leal poruka2,%ecx
movl $dim2,%edx
int $0x80

movl $1,%eax
movl n_malih,%ebx
int $0x80

jednako:
movl $4,%eax
movl $1,%ebx
leal poruka4,%ecx
movl $dim4,%edx
int $0x80

movl $1,%eax
movl n_velikih,%ebx
int $0x80

