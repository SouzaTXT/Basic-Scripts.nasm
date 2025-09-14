section .data
    messageMaior: db "O primeiro número é maior", 10    ; 10 = nova linha
    lenMaior equ $ - messageMaior                       ; calcula tamanho da string
    
    messageMenor: db "O Segundo número é maior", 10
    lenMenor equ $ - messageMenor
    
    messageIgual: db "Os dois números são equivalentes", 10
    lenIgual equ $ - messageIgual

section .text
    global _start

_start:
    mov ah, 6
    mov bh, 6

    cmp ah, bh                  ; compara os dois valores
    je .igual                   ; se igual, vai para .igual
    jg .maior                   ; se maior, vai para .maior
    jl .menor                   ; se menor, vai para .menor

.igual:
    mov rax, 1                  ; chamada de sistema para write
    mov rdi, 1                  ; descritor de arquivo 1 é stdout (canal de execução)
    mov rsi, messageIgual       ; endereço da string para output
    mov rdx, lenIgual           ; número de bytes
    syscall                     ; executa a chamada de sistema
    jmp .fim                    ; vai para o final

.maior:
    mov rax, 1                
    mov rdi, 1                 
    mov rsi, messageMaior      
    mov rdx, lenMaior
    syscall                   
    jmp .fim                 

.menor:
    mov rax, 1             
    mov rdi, 1                  
    mov rsi, messageMenor      
    mov rdx, lenMenor      
    syscall                   
    jmp .fim                    

.fim:
    mov rax, 60                 ; chamada de sistema para exit
    mov rdi, 0                  ; código de saída 0
    syscall                     ; executa a chamada de sistema
