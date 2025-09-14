section .data

    varA = db 5                    ; Variavel A = 5
    varB = db 8                    ; Variavel B = 8

section .text
    global _start

_start:
    mov ah, [varA]
    mov bh, [varB]

    cmp ah, bh                  ; compara os dois valores
    jg .maior                   ; se maior, vai para .maior
    jl .menor                   ; se menor, vai para .menor

.maior:
    sub ah, bh                  ; subtrai a variável A com a B
    syscall                   
    jmp .fim                    ;pula para .fim

.menor:
    sub bh, ah                  ; subtrai a variável B com a A
    syscall                   
    jmp .fim                    

.fim:
    mov rax, 60                 ; chamada de sistema para exit
    mov rdi, 0                  ; código de saída 0
    syscall                     ; executa a chamada de sistema
