; PUSH & POP
;.MODEL SMALL
;.STACK 100H
;.DATA
;.CODE
;MOV AX, @DATA
;MOV DS, AX
;mov ax, 1234h
;mov bx, 5678h
;push ax
;push bx
;pop cx
;pop dx


; LEA
;.model small
;.data
;var1 db '12345', 13, 10, '$'
;var2 db '67890', 13, 10, '$'
;.code
;MOV AX, @DATA
;MOV DS, AX
;LEA SI, var1 ; offset of var1
;LEA DI, var2 ; offset of var2
;MOV DI, OFFSET VAR2   
;MOV DI, 1000H
;MOV [DI], 1234H
;LEA BX, [DI]


; LODSB and STOSB W/ CLD

.model small
.data
string1 db 'ABCDE', 13, 10, '$'
string2 db '12345', 13, 10, '$'
.code
MOV AX, @DATA
MOV ES, AX
MOV DS, AX
LEA SI, string1
LEA DI, string2
CLD
mov ax, 0000h
mov cx, 5
ulit:
     lodsb
     inc al
     stosb
     loop ulit     
   
   
; MOVSB
;.model small
;.data
;var1 db '12345'
;var2 db 3 dup(0)
;.code
;MOV AX, @DATA
;MOV DS, AX
;MOV ES, AX
;LEA SI, var1
;LEA DI, var2
;CLD
;MOVSB
;MOVSB
;MOVSB   


; MOVSB W REP
;.model small
;.data
;var1 db '12345'
;var2 db 3 dup (0)
;.code
;MOV AX, @DATA
;MOV DS, AX
;MOV ES, AX
;LEA SI, var1
;LEA DI, var2
;CLD
;mov cx, 3
;rep MOVSB 


; addition
;mov ax, 1234h
;mov bx, 0ABCDh
;add ax, bx
       
       
; subtraction
;mov ax, 1234h
;mov bx, 0ABCDH
;sub bx, ax

           
;increment
;mov ax, 1234h
;inc ax

;decrement
;mov ax, 1234h
;dec ax

;multiply 8-bit
;mov al, 20h
;mov ah, 10h
;mul ah

; multiply 16-bit
;mov ax, 0ABCDh
;mov bx, 100h
;mul bx

; division 8 -bit
;mov al, 12h
;mov bl, 10h
;div bl

; division 16 - bit
;mov ax, 1234h
;mov bx, 100h
;div bx

; add w/ carry
;stc
;mov ax, 1234h
;mov bx, 0ABCDH
;adc ax, bx

; sub w/ borrow
;stc
;mov ax, 1234h
;mov bx, 0ABCDH
;sbb bx, ax

; and
;mov ax, 1234h
;mov bx, 0ABCDH
;and ax, bx

; or
;mov ax, 1234h
;mov bx, 0ABCDH
;or ax, bx

; xor
;mov ax, 1234h
;mov bx, 0ABCDH
;xor ax, bx

; not 
;mov ax, 1234h
;not ax

; neg
;mov ax, 1234h
;neg ax