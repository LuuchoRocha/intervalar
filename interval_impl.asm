segment .data
    mensaje dw "<<< %d >>>", 10, 0

segment .text
    global    add_asm, sub_asm, mul_asm, sup_asm, inf_asm, min_asm, max_asm
    EXTERN    printf


add_asm:
    PUSH  EBP
    MOV   EBP, ESP

    MOV   EAX, [EBP + 8]

    MOV   BX, [EBP + 12]
    ADD   BX, [EBP + 16]
    MOV   [EAX], BX

    MOV   BX, [EBP + 14]
    ADD   BX, [EBP + 18]
    MOV   [EAX+2], BX

    MOV   ESP, EBP
    POP   EBP
    RET


sub_asm:
    PUSH  EBP
    MOV   EBP, ESP

    MOV   EAX, [EBP + 8]

    MOV   BX, [EBP + 12]
    SUB   BX, [EBP + 16]
    MOV   [EAX], BX

    MOV   BX, [EBP + 14]
    SUB   BX, [EBP + 18]
    MOV   [EAX+2], BX

    MOV   ESP, EBP
    POP   EBP
    RET


inf_asm:
    PUSH  EBP
    MOV   EBP, ESP
    XOR   EAX, EAX
    XOR   EBX, EBX
    XOR   ECX, ECX

    MOV   EDX, [EBP + 8]

    MOV   BX,  [EBP + 12]
    MOV   CX,  [EBP + 16]
    PUSH  EBX
    PUSH  ECX
    CALL  max_asm
    ADD   ESP, 8
    PUSH  EAX

    MOV   BX,  [EBP + 14]
    MOV   CX,  [EBP + 18]
    PUSH  EBX
    PUSH  ECX
    CALL  min_asm
    ADD   ESP, 8
    POP   EBX

    CMP   AX, BX
    JGE   RETURN_INF
    MOV   AX, 0
    MOV   BX, 0
  RETURN_INF:
    MOV   [EDX], BX
    MOV   [EDX+2], AX
    MOV   ESP, EBP
    POP   EBP
    RET


sup_asm:
    PUSH  EBP
    MOV   EBP, ESP
    XOR   EAX, EAX
    XOR   EBX, EBX
    XOR   ECX, ECX

    MOV   EDX, [EBP + 8]

    MOV   BX,  [EBP + 12]
    MOV   CX,  [EBP + 16]
    PUSH  EBX
    PUSH  ECX
    CALL  min_asm
    MOV   [EDX], AX
    ADD   ESP, 8

    MOV   BX,  [EBP + 14]
    MOV   CX,  [EBP + 18]
    PUSH  EBX
    PUSH  ECX
    CALL  max_asm
    MOV   [EDX + 2], AX
    ADD   ESP, 8

    MOV   ESP, EBP
    POP   EBP
    RET


min_asm:
    PUSH  EBP
    MOV   EBP, ESP
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
    MOV   AX, [EBP + 8]
    CMP   AX, [EBP + 12]
    JLE   SECOND_IS_GREATER
    JMP   RETURN_MAX
  SECOND_IS_GREATER:
    MOV   AX, [EBP + 12]
  RETURN_MAX:
    MOV   ESP, EBP
    POP   EBP
    RET

min32_asm:
    PUSH  EBP
    MOV   EBP, ESP
    MOV   EAX, [EBP + 8]
    CMP   EAX, [EBP + 12]
    JGE   SECOND_IS_LESSER32
    JMP   RETURN_MIN32
  SECOND_IS_LESSER32:
    MOV   EAX, [EBP+12]
  RETURN_MIN32:
    MOV   ESP, EBP
    POP   EBP
    RET

max32_asm:
    PUSH  EBP
    MOV   EBP, ESP
    MOV   EAX, [EBP + 8]
    CMP   EAX, [EBP + 12]
    JLE   SECOND_IS_GREATER32
    JMP   RETURN_MAX32
  SECOND_IS_GREATER32:
    MOV   EAX, [EBP + 12]
  RETURN_MAX32:
    MOV   ESP, EBP
    POP   EBP
    RET


mul_asm:
    PUSH  EBP
    MOV   EBP, ESP
    SUB   ESP, 16

    MOV   ESI, [EBP + 8]

    XOR   EBX, EBX
    XOR   ECX, ECX

    MOV   AX, [EBP + 12]     ;lim inf x
    IMUL  WORD [EBP + 16]         ;DX:AX = LIM INF X * LIM INF Y
    MOV   [EBP - 4], AX
    MOV   [EBP - 2], DX

    MOV   AX, [EBP + 12]     ;lim inf x
    IMUL  WORD [EBP + 18]         ;DX:AX = LIM INF X * LIM SUP Y
    MOV   [EBP - 8], AX
    MOV   [EBP - 6], DX

    MOV   AX, [EBP + 14]     ;lim inf x
    IMUL  WORD [EBP + 16]         ;DX:AX = LIM INF X * LIM SUP Y
    MOV   [EBP - 12], AX
    MOV   [EBP - 10], DX

    MOV   AX, [EBP + 14]     ;lim inf x
    IMUL  WORD [EBP + 18]         ;DX:AX = LIM INF X * LIM SUP Y
    MOV   [EBP - 16], AX
    MOV   [EBP - 14], DX

    PUSH  DWORD [EBP - 4]
    PUSH  DWORD [EBP - 8]
    CALL  min32_asm
    MOV   EDX, EAX               ;EDX = MIN DE LOS PRIMEROS 2 PRODUCTOS

    CALL  max32_asm
    MOV   ECX, EAX               ;ECX = MAX DE LOS PRIMEROS 2 PRODUCTOS
    ADD   ESP, 8

    PUSH  DWORD [EBP - 16]
    PUSH  DWORD [EBP - 12]
    CALL  min32_asm
    MOV   EBX, EAX               ;EBX = MIN DE LOS SEGUNDOS 2 PRODUCTOS

    CALL  max32_asm              ;EAX = MAX DE LOS SEGUNDOS 2 PRODUCTOS
    ADD   ESP, 8

    PUSH  EAX
    PUSH  ECX
    CALL  max32_asm
    MOV   ECX, EAX
    ADD   ESP, 8

    PUSH  EBX
    PUSH  EDX
    CALL  min32_asm
    ADD   ESP, 8

    MOV   [ESI], EAX
    MOV   [ESI + 4], ECX

    MOV   ESP, EBP
    POP   EBP
    RET
