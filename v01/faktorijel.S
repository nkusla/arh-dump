# Faktorijel broja, korišćenjem 3 registra

.section .data
.section .text
.global main

main:
    movl $5, %eax   # Faktorijel broja 5
    movl $1, %ebx
    movl $1, %ecx     

faktorijel:
    movl %ecx, %ebx
    movl $0, %ecx
    jmp mnozenje
continue:
    decl %eax
    cmpl $0, %eax
    je kraj
    jmp faktorijel

mnozenje:
    addl %eax, %ecx
    decl %ebx
    je continue
    jmp mnozenje
    
kraj:
    movl $1, %eax
    movl $0, %ebx
    int $0x80