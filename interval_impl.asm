segment .data
    int_format dd "(%d)", 0h, 0

segment .text
    global    add_asm, sub_asm, mul_asm, div_asm, sup_asm, inf_asm
    extern    printf

add_asm:
    PUSH  EBP
    MOV   EBP, ESP

    MOV EAX, [EBP + 8]
    MOV WORD [EAX], 2
    MOV WORD [EAX+2], 3

    MOV   ESP, EBP
    POP   EBP
    RET
