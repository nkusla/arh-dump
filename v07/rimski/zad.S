.section .text
.globl inter_to_roman
dek:    .long 1000, 100, 10, 1
rom:    .ascii "MDCLXVI"

### -------------------
devet:
    movb 1(%edi), %bl
    movb %bl, (%esi)
    movb -1(%edi), %bl
    movb %bl, 1(%esi)
    addl $2, %esi
    subl $2, 16(%ebp)
    js greska
    jmp nastavi

cetiri:
    movb 1(%edi), %bl
    movb %bl, (%esi)
    movb (%edi), %bl
    movb %bl, 1(%esi)
    addl $2, %esi
    subl $2, 16(%ebp)
    js greska
    jmp nastavi

pet:
    movb (%edi), %bl
    movb %bl, (%esi)
    incl %esi
    decl 16(%ebp)
    js greska
    subl $5, %eax
    jz nastavi
jedan:
    movb 1(%edi), %bl
    movb %bl, (%esi)
    incl %esi
    decl 16(%ebp)
    js greska
    decl %eax
    jnz jedan
    jmp nastavi
### -------------------

inter_to_roman:
    pushl %ebp
    movl %esp, %ebp
    pushl %esi
    pushl %edi
    pushl %ebx

    movl 8(%ebp), %eax      # u eax je neoznacen broj koji se konvertuje
    movl 12(%ebp), %esi     # u esi ide pocetak stringa u koji se upisuje
    leal rom+1, %edi        # edi pokazuje na drugi znak rom stringa
    movl $0, %ecx           # indeksni registar za dek niz
    movl $0, %edx

    decl 16(%ebp)          # smanjujemo zbog '\\0'
    js greska              # ako je duzina < 0 nemamo vise mesta za upisivanje (dolazi do greske)

edge_case:
    cmpl $0, %eax           # cifra za 0 ne postoji u rimskom sistemu
    je greska
    
    divl dek(,%ecx,4)       # delimo sa 1000

    dodaj:                  # dodajemo cifre za hiljade (cifra M)
    cmpl $0, %eax
    je dalje

    movb $'M', (%esi)
    decl 16(%ebp)
    js greska
    incl %esi
    decl %eax
    jmp dodaj

    dalje:
    movl %edx, %eax
    movl $0, %edx
    incl %ecx

petlja:
    cmpl $0, %eax
    je orbrisi_stek

    divl dek(,%ecx,4)   # posle deljenja u eax-u je cifra od 0-9

    cmpl $9, %eax   # provera dal je cifra 9
    je devet
    cmpl $5, %eax   # provera dal je 5,6,7,8
    jae pet
    cmpl $4, %eax   # provera dal je 4
    je cetiri
    cmpl $1, %eax   # poslednji slucaj (ako je 1,2,3)
    jae jedan

    nastavi:
    addl $2, %edi   # pomeramo edi na sledecu "grupu" od po tri cifre 
    movl %edx, %eax # restartujemo eax i edx zbog deljenja
    movl $0, %edx
    incl %ecx

    jmp petlja

greska:
    movl $1, %eax

orbrisi_stek:
    movb $0, (%esi) # dodavanje '\\0' na kraj stringa

    popl %ebx
    popl %edi
    popl %esi
    movl %ebp, %esp
    popl %ebp
    ret
