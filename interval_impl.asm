segment .text
    global    add_asm, sub_asm, mul_asm, sup_asm, inf_asm, min_asm, max_asm


add_asm:
    PUSH  EBP                    ;Setup stackframe
    MOV   EBP, ESP

    MOV   EAX, [EBP + 8]         ;[EBP + 8] contains the address where the result should returned

    MOV   BX, [EBP + 12]         ;[EBP + 12] contains the first parameter lower limit (x.lower)
    ADD   BX, [EBP + 16]         ;BX = x.lower + y.lower
    MOV   [EAX], BX              ;Set the lower limit in the result. [EAX] is our returning struct (32 bits)

    MOV   BX, [EBP + 14]         ;[EBP + 14] contains x.upper
    ADD   BX, [EBP + 18]         ;BX = x.upper + y.upper
    MOV   [EAX+2], BX            ;Set the upper limit in the result. [EAX+2] contains the upper limit of our returning struct.

    MOV   ESP, EBP               ;Leave stackframe
    POP   EBP
    RET


sub_asm:                         ;Exactly like add_asm but using SUB instead off ADD
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
    PUSH  EBP                    ;Setup stackframe
    MOV   EBP, ESP
    XOR   EAX, EAX               ;Clean registers
    XOR   EBX, EBX
    XOR   ECX, ECX

    MOV   EDX, [EBP + 8]         ;[EBP + 8] contains the address where is our returning struct

    MOV   BX,  [EBP + 12]        ;BX = x.lower
    MOV   CX,  [EBP + 16]        ;CX = y.lower
    PUSH  EBX                    ;Passing the parameters to max_asm
    PUSH  ECX
    CALL  max_asm                ;AX = max(x.lower, y.lower)
    ADD   ESP, 8                 ;Unstack the parameters
    PUSH  EAX                    ;Saving the max in the stack

    MOV   BX,  [EBP + 14]        ;BX = x.upper
    MOV   CX,  [EBP + 18]        ;CX = y.upper
    PUSH  EBX
    PUSH  ECX
    CALL  min_asm                ;AX = min(x.upper, y.upper)
    ADD   ESP, 8                 ;Unstack the parameters
    POP   EBX                    ;EBX = max(x.lower, y.lower)     (This was the saved result on the line 58)

    CMP   AX, BX                 ;Check: If "inf.upper">"inf.lower" then [0,0] aka "Empty" is returned
    JGE   RETURN_INF
    MOV   AX, 0
    MOV   BX, 0
  RETURN_INF:
    MOV   [EDX], BX              ;Else the lower limit of the INF is put in the returned struct
    MOV   [EDX+2], AX            ;The upper limit is put in its place in the struct
    MOV   ESP, EBP               ;Leave stackframe
    POP   EBP
    RET


sup_asm:
    PUSH  EBP                    ;Setup stackframe
    MOV   EBP, ESP
    XOR   EAX, EAX               ;Clean registers
    XOR   EBX, EBX
    XOR   ECX, ECX

    MOV   EDX, [EBP + 8]         ;EDX contains the memory address where the result is returned

    MOV   BX,  [EBP + 12]        ;BX = x.lower
    MOV   CX,  [EBP + 16]        ;CX = y.lower
    PUSH  EBX
    PUSH  ECX
    CALL  min_asm                ;AX = min(x.lower, y.lower)
    MOV   [EDX], AX              ;the lower limit of the SUP is put in the returned struct
    ADD   ESP, 8                 ;Unstack the parameters

    MOV   BX,  [EBP + 14]        ;BX = x.upper
    MOV   CX,  [EBP + 18]        ;CX = y.upper
    PUSH  EBX
    PUSH  ECX                    ;Same as "PUSH  dword [EBP + 14] PUSH  dword [EBP + 18]" but more clear
    CALL  max_asm                ;AX = max(x.upper, y.upper)
    MOV   [EDX + 2], AX          ;The upper limit of the SUP is placed in the returned struct
    ADD   ESP, 8                 ;Unstack the parameters

    MOV   ESP, EBP               ;Leave stackframe
    POP   EBP
    RET


min_asm:
    PUSH  EBP                    ;Setup stackframe
    MOV   EBP, ESP
    MOV   AX, [EBP + 8]          ;AX = first parameter
    CMP   AX, [EBP + 12]         ;Compare first and second parameter
    JGE   SECOND_IS_LESSER
    JMP   RETURN_MIN
  SECOND_IS_LESSER:
    MOV   AX, [EBP + 12]         ;The result is returned in AX
  RETURN_MIN:
    MOV   ESP, EBP               ;Leave stackframe
    POP   EBP
    RET


mul_asm:
    PUSH  EBP
    MOV   EBP, ESP
    SUB   ESP, 16                ;Allocate space for local variables that will store the products between the interval limits

    MOV   ESI, [EBP + 8]         ;ESI contains the memory address of the returned struct

    XOR   EBX, EBX
    XOR   ECX, ECX

    MOV   AX, [EBP + 12]         ;AX = x.lower
    IMUL  WORD [EBP + 16]        ;DX:AX = x.lower * y.lower
    MOV   [EBP - 4], AX
    MOV   [EBP - 2], DX          ;Saving the result as a local variable

    MOV   AX, [EBP + 12]         ;AX = x.lower
    IMUL  WORD [EBP + 18]        ;DX:AX = x.lower * y.upper
    MOV   [EBP - 8], AX
    MOV   [EBP - 6], DX          ;Saving the result as a local variable

    MOV   AX, [EBP + 14]         ;AX = x.upper
    IMUL  WORD [EBP + 16]        ;DX:AX = x.upper * y.lower
    MOV   [EBP - 12], AX
    MOV   [EBP - 10], DX         ;Saving the result as a local variable

    MOV   AX, [EBP + 14]         ;AX = x.upper
    IMUL  WORD [EBP + 18]        ;DX:AX = x.upper * y.upper
    MOV   [EBP - 16], AX
    MOV   [EBP - 14], DX         ;Saving the result as a local variable

    PUSH  DWORD [EBP - 4]        ;Pushing (x.lower * y.lower)
    PUSH  DWORD [EBP - 8]        ;Pushing (x.lower * y.upper)
    CALL  min32_asm
    MOV   EDX, EAX               ;EDX = min of first two products

    CALL  max32_asm
    MOV   ECX, EAX               ;ECX = max of first two products
    ADD   ESP, 8                 ;Unstack the parameters

    PUSH  DWORD [EBP - 16]       ;Pushing (x.upper * y.upper)
    PUSH  DWORD [EBP - 12]       ;Pushing (x.upper * y.lower)
    CALL  min32_asm
    MOV   EBX, EAX               ;EBX = min of the second two products

    CALL  max32_asm              ;EAX = max of the second two products
    ADD   ESP, 8                 ;Unstack the parameters

    PUSH  EAX
    PUSH  ECX                    ;Pushing the parcial max's
    CALL  max32_asm
    MOV   ECX, EAX               ;ECX = max((x.lower * y.lower), (x.lower * y.upper), (x.upper * y.upper), (x.upper * y.lower))
    ADD   ESP, 8                 ;Unstack the parameters

    PUSH  EBX
    PUSH  EDX
    CALL  min32_asm              ;EAX = min((x.lower * y.lower), (x.lower * y.upper), (x.upper * y.upper), (x.upper * y.lower))
    ADD   ESP, 8

    MOV   [ESI], EAX             ;Placing the lower limit of mul in the returned struct
    MOV   [ESI + 4], ECX         ;Placint the upper limit in the returned struct

    MOV   ESP, EBP
    POP   EBP
    RET


max_asm:
    PUSH  EBP
    MOV   EBP, ESP
    MOV   AX, [EBP + 8]          ;AX = first parameter
    CMP   AX, [EBP + 12]         ;Compare with the second parameter
    JLE   SECOND_IS_GREATER
    JMP   RETURN_MAX
  SECOND_IS_GREATER:
    MOV   AX, [EBP + 12]         ;The result is returned in AX
  RETURN_MAX:
    MOV   ESP, EBP
    POP   EBP
    RET


min32_asm:                       ;Same as min_asm but comparing 32 bits numbers
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


max32_asm:                       ;Same as max_asm but comparing 32 bits numbers
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
