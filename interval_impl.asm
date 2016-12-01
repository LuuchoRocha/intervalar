segment .text
    global    add_asm, sub_asm, mul_asm, div_asm, sup_asm, inf_asm, min_asm, max_asm

add_asm:
    PUSH  EBP
    MOV   EBP, ESP
    PUSHA
    PUSHF

    MOV   EAX, [EBP + 8]

    MOV   BX, [EBP + 12]
    ADD   BX, [EBP + 16]
    MOV   [EAX], BX

    MOV   BX, [EBP + 14]
    ADD   BX, [EBP + 18]
    MOV   [EAX+2], BX

    POPF
    POPA
    MOV   ESP, EBP
    MOV   EAX, 0
    POP   EBP
    RET

sub_asm:
    PUSH  EBP
    MOV   EBP, ESP
    PUSHA
    PUSHF

    MOV   EAX, [EBP + 8]

    MOV   BX, [EBP + 12]
    SUB   BX, [EBP + 16]
    MOV   [EAX], BX

    MOV   BX, [EBP + 14]
    SUB   BX, [EBP + 18]
    MOV   [EAX+2], BX

    POPF
    POPA
    MOV   ESP, EBP
    MOV   EAX, 0
    POP   EBP
    RET

min_asm:
    PUSH  EBP
    MOV   EBP, ESP
    XOR   EAX, EAX

    MOV   AX, [EBP+8]
    CMP   AX, [EBP+12]
    JGE   SECOND_IS_LESSER
    JMP   RETURN_MIN
  SECOND_IS_LESSER:
    MOV   AX, [EBP+12]
  RETURN_MIN:
    MOV   ESP, EBP
    POP   EBP
    RET

max_asm:
    PUSH  EBP
    MOV   EBP, ESP
    XOR   EAX, EAX

    MOV   AX, [EBP+8]
    CMP   AX, [EBP+12]
    JLE   SECOND_IS_GREATER
    JMP   RETURN_MAX
  SECOND_IS_GREATER:
    MOV   AX, [EBP+12]
  RETURN_MAX:
    MOV   ESP, EBP
    POP   EBP
    RET
