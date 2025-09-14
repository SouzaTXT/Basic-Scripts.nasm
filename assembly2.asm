    section .data

    resultado_and: DD 0 ; Tamanho DD (Define DoubleWord)
    resultado_or: DD 0
    resultado_xor: DD 0
    resultado_not: DD 0

section .text
    global _start

_start:
    mov eax, 0b10101010    ; 10101010b (170 em decimal)
    
    mov ebx, 0b11001100
    and ebx, eax   ; 1 - AND com 0b11001100 (204 em decimal)
    mov [resultado_and], ebx 
    
    mov ebx, 0b11011100 
    or ebx, eax    ; 2 - OR com 0b11011100 (220 em decimal)
    mov [resultado_or], ebx  
    
    mov ebx, 0b11101100 
    xor ebx, eax    ; 3 - XOR com 0b11101100 (236 em decimal)
    mov [resultado_xor], ebx
    
    mov ebx, eax
    not ebx    ; 4. Operação NOT no valor original
    mov [resultado_not], ebx
    
    mov eax, 1
    xor ebx, ebx
    int 0x80