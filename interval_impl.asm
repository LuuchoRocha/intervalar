segment .text
    global    add_asm, sub_asm, mul_asm, sup_asm, inf_asm, min_asm, max_asm,


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


inf_asm:
    PUSH  EBP
    MOV   EBP, ESP

    MOV   EDX, [EBP + 8]

    MOV   BX,  [EBP + 12]
    MOV   CX,  [EBP + 16]
    PUSH  BX
    PUSH  CX
    CALL  max_asm
    ADD   ESP, 4

    MOV   [EDX], WORD AX

    MOV   BX,  [EBP + 14]
    MOV   CX,  [EBP + 18]
    PUSH  BX
    PUSH  CX

    CALL  min_asm

    ADD   ESP, 4

    MOV   [EDX + 2], WORD AX

    MOV   ESP, EBP
    POP   EBP
    RET


sup_asm:
    PUSH  EBP
    MOV   EBP, ESP

    MOV   EDX, [EBP + 8]

    MOV   BX,  [EBP + 12]
    MOV   CX,  [EBP + 16]
    PUSH  BX
    PUSH  CX

    CALL  max_asm
    MOV   [EDX], AX
    ADD   ESP, 4

    MOV   BX,  [EBP + 14]
    MOV   CX,  [EBP + 18]
    PUSH  BX
    PUSH  CX

    CALL  min_asm
    MOV   [EDX + 2], AX
    ADD   ESP, 4


    MOV   ESP, EBP
    POP   EBP
    RET
