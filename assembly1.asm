section .data
    resultado_soma: DQ 0    ; (Tamanho DQ = Define Quadword)
    resultado_subtracao: DQ 0
    resultado_multiplicacao: DQ 0
    resultado_divisao: DQ 0

section .text
    global _start

_start:
    MOV ax, 8 
    ADD ax, 13     ;  1 - SOMA 8 + 13 = 21
    MOV[ resultado_soma], ax  
    
    MOV bx, 7
    SUB bx, 6    ;  2 - SUBTRAÇÃO 13 - 8 = 5
    MOV [resultado_subtracao], bx  
    
    MOV cx, 21
    IMUL cx, 5    ;  3 - MULTIPLICAÇÃO 21 * 5
    MOV [resultado_multiplicacao], cx
    
    MOV ax, 21
    MOV cx, 5
    idiv cx    ;  4 - DIVISÃO 21 / 5
    
    MOV [resultado_divisao], ax

    mov rax, 60                
    mov rdi, 0                 
    syscall 