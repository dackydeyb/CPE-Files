; March 11, 2025
; Addressing Modes

; Lab Activity 4

; # 1 - Register Addressing

;mov ax, 0ABCDh
;mov bx, 06789h
;mov ax, bx

; # 2 - Immediate Addressing
.model small
.stack
.data
.code

;MOV CX,0ABCDh   

; # 3 - Direct Addressing
MOV AX, @DATA
MOV DS, AX

MOV BX, 1234H   ; BX <- 1234H
MOV CX, 0H      ; CX <- 0000H
MOV [1000H], BX ; Memory location 1000H <- BX (1234H)
MOV CX, [1000H] ; CX <- value stored at memory location 1000H

; # 4 - Register Indirect
;MOV AX, @DATA
;MOV DS, AX

;MOV CX, 0000H

;MOV BX, 1000h
;MOV [BX], 0ABCDH
;MOV CL, [BX]
;MOV DX, [BX]

; # 5 - Base-plus-index
;MOV AX, @DATA
;MOV DS, AX

;MOV CX, 0000H

;MOV BX, 1000h
;MOV DI, 01H
;MOV [BX+DI], 0EF01H
;MOV CL,[BX+DI]
;MOV CX,[BX+DI]   

; # 6 - Register Relative
;mov bx, 1000h
;mov [bx+01Ah], 0ABCDh
;mov cx, [bx+01Ah]

; # 7 - base relative + index 
;array db 1,2,3,4

;mov ax, @data
;mov ds, ax

;mov dl, 01h
;mov bx, offset array

;mov cx, 04h
;mov si, 00h
;loop1:
;    mov array [bx+si], dl
;    inc si
;    loop loop1