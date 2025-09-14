section .data
    resultado: dd 0                ; armazena o resultado DD (Define Doubleword)

section .text
    global _start

_start:
    mov ecx, 10                   ; funciona como um contador: 10 passos
    mov eax, 0                    ; acumulador iniciado em 0

.loop:
    add eax, ecx                  ; soma o valor atual do contador
    loop .loop                    ; decrementa ecx e volta a soma se não zero

    mov [resultado], eax          ; armazena o resultado da soma (55)

    ; Finaliza programa
    mov rax, 60
    mov rdi, 0
    syscall