BITS 64

section .data
msg1:    db "Digite o primeiro numero: ", 0   ; mensagem pedindo o 1º número
msg2:    db "Digite o segundo numero: ", 0    ; mensagem pedindo o 2º número
suma:    db "Soma: ", 0                       ; prefixo para resultado da soma
subt:    db "Subtracao: ", 0                  ; prefixo para resultado da subtração
mult:    db "Multiplicacao: ", 0              ; prefixo para resultado da multiplicação
divi:    db "Divisao: ", 0                    ; prefixo para resultado da divisão
nl:      db 10, 0                             ; newline (LF = 10 em ASCII)


; Espaço reservado (BSS)
section .bss
buf:     resb 32                               ; buffer para leitura de entrada (string)
out:     resb 32                               ; buffer para saída (número convertido para string)

section .text
global _start

_start:

    ; Ler o 1º número do usuário
    lea rsi, [rel msg1]                        ; rsi aponta para a string msg1
    call print_str                              ; chama rotina para imprimir a string
    lea rsi, [rel buf]                          ; rsi aponta para o buffer de leitura
    mov rdx, 32                                 ; máximo de bytes que podemos ler
    call read_int                               ; lê inteiro do stdin -> retorna em rax
    mov r12, rax                                ; guarda o 1º número em r12 (registrador de propósito geral)

  
    ; Ler o 2º número do usuário
    lea rsi, [rel msg2]
    call print_str
    lea rsi, [rel buf]
    mov rdx, 32
    call read_int
    mov r13, rax                                ; guarda o 2º número em r13


    ; Soma
    mov rax, r12                                ; move num1 para rax
    add rax, r13                                ; soma rax + r13 -> resultado em rax
    lea rsi, [rel suma]                          ; prepara string "Soma: "
    call print_str                               ; imprime prefixo
    call print_num                               ; imprime resultado

   
    ; Subtração
    mov rax, r12
    sub rax, r13                                ; rax = num1 - num2
    lea rsi, [rel subt]
    call print_str
    call print_num

   
    ; Multiplicação 
    mov rax, r12
    imul rax, r13                               ; rax = r12 * r13 
    lea rsi, [rel mult]
    call print_str
    call print_num

    ; Divisão 
    mov rax, r12
    xor rdx, rdx                                ; zera rdx antes da divisão
    mov rbx, r13                                ; divisor em rbx
    div rbx                                      ; RAX = quociente, RDX = resto
    lea rsi, [rel divi]
    call print_str
    call print_num

  
    ; Saida do programa
    mov rax, 60                                 ; syscall exit
    xor rdi, rdi                                ; exit code = 0
    syscall


; Rotina: print_str
; Imprime string null-terminated no stdout
; Entradas: RSI -> ponteiro para string
; Preserva RAX
print_str:
    push rax                                    ; salva rax do chamador
    push rdx                                    ; salva rdx, que será usado
    xor rdx, rdx                                ; contador/índice

.find_len:
    cmp byte [rsi + rdx], 0                     ; procura null-terminator
    je .do_write
    inc rdx
    jmp .find_len

.do_write:
    mov rax, 1                                  ; syscall write
    mov rdi, 1                                  ; file descriptor 1 = stdout
    syscall
    pop rdx                                     ; restaura rdx
    pop rax                                     ; restaura rax
    ret

; Rotina: read_int
; Lê string de stdin e converte para inteiro >=0
; Entradas: RSI = buffer, RDX = max bytes
; Saída: RAX = valor inteiro
read_int:
    mov rax, 0
    xor rdi, rdi                                ; fd = 0 (stdin)
    syscall                                     ; read(stdin, RSI, RDX)
    mov rcx, rax                                ; rcx = quantidade de bytes lidos
    xor rax, rax                                ; limpa acumulador
    xor r10, r10                                ; índice = 0

.parse_loop:
    cmp r10, rcx
    jge .done
    mov bl, [rsi + r10]                         ; pega byte atual
    cmp bl, 10                                  
    je .done
    cmp bl, '0'
    jl .inc_i
    cmp bl, '9'
    jg .inc_i
    movzx r11, bl
    sub r11, '0'                                ; converte char ASCII -> número
    imul rax, rax, 10                           ; desloca decimalmente
    add rax, r11                                ; adiciona novo dígito
.inc_i:
    inc r10
    jmp .parse_loop

.done:
    ret


; Rotina: print_num
; Converte inteiro (RAX) para string e imprime + newline
; Entradas: RAX = número (signed)
print_num:
    mov r9, 10                                   ; divisor decimal
    lea rsi, [rel out + 31]                      ; começa do fim do buffer
    xor rcx, rcx                                 ; contador de dígitos

    test rax, rax
    jnz .maybe_conv
    ; caso zero
    dec rsi
    mov byte [rsi], '0'
    inc rcx
    jmp .print_out

.maybe_conv:
    mov r11, 0                                   ; flag negativo
    cmp rax, 0
    jge .conv_loop
    neg rax
    mov r11, 1

.conv_loop:
    xor rdx, rdx
    div r9                                        ; RAX = quociente, RDX = resto
    add dl, '0'                                  ; converte para ASCII
    dec rsi
    mov [rsi], dl
    inc rcx
    test rax, rax
    jnz .conv_loop

    cmp r11, 0
    je .print_out
    dec rsi
    mov byte [rsi], '-'                          ; adiciona sinal negativo
    inc rcx

.print_out:
    mov rax, 1
    mov rdi, 1
    mov rdx, rcx
    syscall
    ; newline
    mov rax, 1
    mov rdi, 1
    lea rsi, [rel nl]
    mov rdx, 1
    syscall
    ret
