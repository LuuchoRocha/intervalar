segment .text
    global    add_asm, sub_asm, mul_asm, sup_asm, inf_asm, min_asm, max_asm,


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
    MOV   AX, WORD [EBP+8]
    CMP   AX, WORD [EBP+12]
    JLE   SECOND_IS_GREATER
    JMP   RETURN_MAX
  SECOND_IS_GREATER:
    MOV   AX, [EBP+12]
  RETURN_MAX:
    MOV   ESP, EBP
    POP   EBP
    RET

mul_asm:
    PUSH  EBP
    MOV   EBP, ESP
    XOR   EAX, EAX
    XOR   EBX, EBX
    XOR   ECX, ECX
    XOR   EDX, EDX

    MOV   EDX, [EBP + 8]
    
    MOV   AX, WORD [EBP + 12]     ;lim inf x
    MOV   BX, WORD [EBP + 16]     ;lim inf y 
    IMUL  BX                      ;DX:AX = AX * BX ***segun lei, es raro que una multip
                                  ;entre 2 numeros de n bits, de un numero de mas de n bits
                                  ;por lo que es posible que solo necesitemos usar AX

    PUSH  DX:AX                   ;esto me modifica la posicion de los otros parametros?

    MOV   AX, WORD [EBP + 12]     ;lim inf x.. si se movieron de lugar, deberian estar 
    MOV   BX, WORD [EBP + 18]     ;lim sup y.. en +16 y +22?? 
    IMUL  BX
    PUSH  DX:AX

    CALL  min_asm                 ;si comparamos numeros de 32 bits puede que se rompa,
                                  ;ya que en la pila del min comparamos nums de 16 bits!!!
    
    MOV   ECX, EAX                ;o solo CX y AX? para guardar el min de los primeros 2 productos
    
    CALL  max_asm
    MOV   ESI, EAX                ;guardo el maximo de los 2 factores, uso ESI pero puedo usar cualquiera de prop gral.
    ADD   ESP, 8                  ;desapilar los parametros, +8 O +16?
    
    MOV   AX, WORD [EBP + 14]     ;lim sup x 
    MOV   BX, WORD [EBP + 16]     ;lim inf y  
    IMUL  BX
    PUSH  DX:AX

    MOV   AX, WORD [EBP + 14]     ;lim sup x 
    MOV   BX, WORD [EBP + 18]     ;lim sup y
    IMUL  BX
    PUSH  DX:AX

    CALL  min_asm                  ;tengo el minimo de los segundos 2 factores
    MOV   EDI, EAX                 ;lo guardo en el EDI asi en el EAX me queda el max

    CALL  max_asm
    ADD   ESP, 8                   ;vuelvo a desapilar los parametros  

    PUSH  ECX                      
    PUSH  EDI                      ;pusheo los 2 minimos

    CALL  min_asm                   ;en AX tengo el min de los 4 factores.
                                   ;Este es el limite inferior del prod intervalar
    ADD   ESP, 8 

    PUSH  ESI
    PUSH  EAX
    CALL  max_asm                  ;ahora en eax tengo el max de todos los productos
                                   ; este es el lim sup del producto intervbalar





