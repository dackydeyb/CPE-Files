;Compilation of Assembly Language Program
;
;DATA MOVEMENT INSTRUCTIONS
;1. PUSH AND POP
;.MODEL SMALL
;.STACK 100H  
;.DATA
;.CODE
;   MOV AX, @DATA
;    MOV DS, AX
;   
;     Load values into registers
;    MOV AX, 1234H
;    MOV BX, 5678H
;
;     Push values onto the stack
;    PUSH AX
;    PUSH BX
;
;     Pop values back from the stack
;    POP BX  ; BX gets the last pushed value (5678H)
;    POP AX  ; AX gets the first pushed value (1234H)


;2A. LEA-LOAD EFFECTIVE ADDRESS 
;.model small
;.data
;var1 db '12345',13,10,'$'
;var2 db '67890',13,10,'$'
;.code
;MOV AX, @DATA	
;MOV DS, AX   ; init DS=0710
;LEA SI, var1 ; offset of var1 DS:SI 0710:0000 SI=0000
;LEA DI, var2 ; offset of var2 DS:DI 0710:0008 DI=0008    
;MOV DI,OFFSET VAR2
  
  
;2B. LEA-LOAD EFFECTIVE ADDRESS  
;.model small
;.data
;.code
;
;MOV DI,1000H
;MOV [DI],1234H
;LEA BX,[DI]


;3A. LODSB AND STOSB 
;.model small
;.data
;VAR1 db 'ABCDE',13,10,'$'
;VAR2 db '12345',13,10,'$'
;.code
;MOV AX, @DATA
;MOV ES, AX ; initialize ES 
;MOV DS, AX
;LEA SI, VAR1	
;LEA DI, VAR2
;MOV AX,0000H;CLEAR AX REGISTER
;CLD       ; read from location 0
;mov cx,5    ;counter 
;ulit:    
;    lodsb  ;AL = DS:[SI]
;    stosb  ;ES:[DI] = AL
;   loop ulit
;

;3B. LODSB AND STOSB
;.model small
;.data
;VAR1 db 'ABCDE',13,10,'$'
;VAR2 db '12345',13,10,'$'
;.code
;MOV AX, @DATA
;MOV ES, AX ; initialize ES 
;MOV DS, AX ; initialize DS
;LEA SI, VAR1+04h	
;LEA DI, VAR2+04h
;MOV AX,0000H;CLEAR AX REGISTER
;STD       ; read from location 0
;mov cx,5    ;counter 
;ulit:    
;    lodsb  ;AL = DS:[SI]
;    stosb  ;ES:[DI] = AL
;   loop ulit
;                                       
                                       
                                                                           
;4A. MOVSB                                        
;.model small
;.data   
;var1 db '123',13,10,'$'
;var2 db 3 dup(0)
;.code
;MOV AX, @DATA	
;MOV DS, AX   ; init DS
;MOV ES, AX   ; init ES
;LEA SI, var1 ; source
;LEA DI, var2 ; destination
;CLD          ; DF = 0
;MOVSB ;ES:[DI] = DS:[SI]
;MOVSB
;MOVSB 
;

;4B. MOVSB /W REP                                       
;.model small
;.data   
;var1 db '12345'
;var2 db 3 dup(0)
;.code
;MOV AX, @DATA	
;MOV DS, AX   ; init DS
;MOV ES, AX   ; init ES
;LEA SI, var1 ; source
;LEA DI, var2 ; destination
;CLD          ; DF = 0
;mov cx,3
;rep MOVSB ;ES:[DI] = DS:[SI]  
                                      



;ARITHMETIC AND LOGICAL
;===============================================
;addition
;mov ax,1234h
;mov bx,0ABCDh
;add ax,bx


;;subtraction
;mov ax,1234h
;mov bx,0ABCDH
;sub bx,ax

;increment
;mov ax,1234h
;inc ax

;decrement
;mov ax,1234h
;inc ax

;;multiply 8-bit
;mov al,20h
;mov ah,10h
;mul ah


;;multiply 16-bit
mov ax,0ABCDh
mov bx,100h
mul bx
;
;
;;division 8-bit
;mov al,12h
;mov bl,10h
;div bl
;
;;division 16-bit
;mov ax,1234h
;mov bx,100h
;div bx
;
;;add w/ carry
;stc 
;mov ax,1234h
;mov bx,0ABCDH
;adc ax,bx
;
;
;;sub w/ borrow
;stc 
;mov ax,1234h
;mov bx,0ABCDH
;sbb bx,ax
;
;;and
;mov ax,1234h
;mov bx,0ABCDH
;and ax,bx
;
;;or
;mov ax,1234h
;mov bx,0ABCDH
;or ax,bx
;
;;xor
;mov ax,1234h
;mov bx,0ABCDH
;xor ax,bx
; 
;;not
;mov ax,1234h
;not ax
;
;;neg
;mov ax,1234h
;neg ax
 
;AAA PUSHF POP F 
;.MODEL SMALL
;.DATA
;
;hello db 'The sum of the numbers is',10,13,'$'
;num1 db '2345',10,13,'$'
;num2 db '5678',10,13,'$'
;sum  db '    ',10,13,'$'
;
;.CODE
;mov ax, @DATA
;mov ds, ax
;
;mov si, 03h
;mov cx, 05h
;clc
;
;add_loop:
;    mov al, [num1+si]
;    adc al, [num2+si]
;    aaa
;    pushf
;    or al, 30h
;    popf
;    mov [sum+si], al
;    dec si
;    loop add_loop
;
;mov ah, 09
;mov dx, offset hello
;int 21h
;
;mov ah, 09
;mov dx, offset sum
;int 21h



;CMP TEST Instruction
;====================================
;PROGRAM 1 using CMP compare instruction
;.model small
;.data
;hello db 'Above',13,10,'$'
;hi db 'Below',13,10,'$'
;equal db 'Equal',13,10,'$'
;.code

;mov ax,@data
;mov ds,ax

;code if difference is positive
;mov ax,1234h
;mov bx,1000h
;cmp ax,bx    ; ax-bx  only changes the flag

;code if difference is negative
;mov ax,1234h
;mov bx,1000h
;cmp bx,ax    ; bx-ax  only changes the flag

;code if difference is equal
;mov ax,1000h
;mov bx,1000h
;cmp bx,ax    ; bx-ax  only changes the flag  


;ja talon   ; jump above     sf&zf=0
;jb lundag  ; jump below     sf=1
;je tulad   ; jump if equal  zf=1

;talon: 
;       mov ah,09h
;       mov dl,offset hello
;       int 21h

;lundag: 
;       mov ah,09h
;       mov dl,offset hi
;       int 21h

;tulad: 
;       mov ah,09h
;       mov dl,offset equal
;       int 21h


;PROGRAM 2 using test instruction
;.model small
;.data
;odd db 'Odd',13,10,'$'
;even db 'Even',13,10,'$'

;.code
;mov ax,@data
;mov ds,ax

;mov ax,0003h    ;0000 0011
;mov bx,0001h    ;0000 0001 
;test ax,bx      ; and operation
;jz hi
;jnz hello

;hi: 
;       mov ah,09h
;       mov dl,offset even
;       int 21h

;hello: 
;       mov ah,09h
;       mov dl,offset odd
;       int 21h


;BIT MANIPULATION
;========================================================
;PROGRAM 3 using Shift instruction
;translate hex to binary

;mov ax,0001h    ;0000 0000 0000 0001
;shl ax,3        ;shift to 3 times ax=0008                 
;sal ax,3       

;------
;mov ax,8000h    ;1000 0000 0000 0000
;shr ax,5        ;shift to 3 times ax=0004                 
;sal ax,5        

;PROGRAM 4 using Rotate instruction

;rotate operation RCL and RCR kasama CF pag ikot 
;rotate operation ROL and ROR ndi kasama CF pag ikot
;stc              ; Set Carry Flag to 1
;mov ax,0D000h    ; CF=1 1101 0000 0000 0000  
                  ; CF=1 1010 0000 0000 0001
                  ; CF=1 0100 0000 0000 0011
                  ; CF=0 1000 0000 0000 0111 
                  ; CF=1 0000 0000 0000 1110
                  ; CF=0 0000 0000 0001 1100
;rcl ax,5  
;----------
;stc
;mov ax,0D000h    ; CF=1 1101 0000 0000 0000  
                  ; CF=1 1010 0000 0000 0001
                  ; CF=1 0100 0000 0000 0011
                  ; CF=0 1000 0000 0000 0110 
                  ; CF=1 0000 0000 0000 1101 
                  ; CF=0 0000 0000 0001 1010 
                  ; AX=00 1A
;rol ax,5 

;----------
;stc
;mov ax,0003h     ; 0000 0000 0000 0011       CF=1
                  ; 1000 0000 0000 0001       CF=1
                  ; 1100 0000 0000 0000       CF=1
                  ; 1110 0000 0000 0000       CF=0
                  ; 0111 0000 0000 0000       CF=0
                  ; 0011 1000 0000 0000       CF=0
;rcr ax,5  
;----------
;stc
;mov ax,0003h      ; 0000 0000 0000 0011       CF=1
;                  ; 1000 0000 0000 0001       CF=1
;                  ; 1100 0000 0000 0000       CF=1
;                  ; 0110 0000 0000 0000       CF=0
;                  ; 0011 0000 0000 0000       CF=0
;                  ; 0001 1000 0000 0000       CF=0
;ror ax,5 


;==============================================
;SCASB CMPSB

;SCAS Scan String
;.MODEL SMALL
;.DATA
;STRING1 DB 'ABCDEFGHI'
;STRING2 DB 'FOUND ', '$'
;STRING3 DB 'NOT FOUND ', '$'
;.CODE
;MOV AX, @DATA
;MOV ES, AX ; 
;
;LEA DI, STRING1
;MOV CX,9
;
;ULIT:
;MOV AL, 'J' ; TARGET CHARACTER
;SCASB    
;JE HEY
;LOOP ULIT	
;
;HELLO:
;MOV AX,@DATA
;MOV DS,AX
;MOV AH,09
;MOV DX,OFFSET STRING3
;INT 21H
;JMP EXIT
;
;HEY:
;MOV AX,@DATA
;MOV DS,AX          
;MOV AH,09
;MOV DX,OFFSET STRING2
;INT 21H
;
;EXIT:
;MOV AH,04CH
;INT 21H
      
      
;CMPS Compare String
;.MODEL SMALL
;.DATA
;STRING1 DB 'HELL1'
;STRING2 DB 'HELLO', '$'
;STRING3 DB 'SAME', '$'
;STRING4 DB 'NOT THE SAME', '$'
;.CODE
;MOV AX, @DATA
;MOV DS, AX ; 
;MOV ES, AX ; 
;LEA SI, STRING1
;LEA DI, STRING2
;CLD
;MOV CX,5
;REPE CMPSB    
;JE HEY
;
;HELLO:
;MOV AX,@DATA
;MOV DS,AX
;MOV AH,09
;MOV DX,OFFSET STRING4
;INT 21H
;JMP EXIT
;
;HEY:
;MOV AX,@DATA
;MOV DS,AX          
;MOV AH,09
;MOV DX,OFFSET STRING3
;INT 21H
;
;EXIT:
;MOV AH,04CH
;INT 21H





;=================================================
;LOOP Instruction

;.model small
;.data
;var1 db 'hello world',13,10,'$'
;.code
;mov ax,@data
;mov ds,ax
;mov ah,09
;mov cx,20
;ulit:
;mov dx,offset var1
;int 21h
;loop ulit
;mov ah,4ch
;int 21h



;.model small
;.data
;var1 db '*','$'
;var2 db ' ',13,10,'$'
;.code
;mov ax,@data
;mov ds,ax
;mov ah,0
;mov cl,10
;ulit2:     
;  mov bl,cl
;  mov cl,5   
;ulit:
;mov ah,09h
;mov dx,offset var1
;int 21h
;loop ulit
;mov ah,09h
;mov dx,offset var2
;int 21h
;  mov cl,bl
;loop ulit2
;mov ah,4ch
;int 21h



;.model small
;.data
;var1 db '*','$'
;var2 db '',10,13,'$'
;.code
;mov ax,@data
;mov ds,ax
;mov cl,3
;mov bl,1h
;mov bh,0
;
;ulit2:     
;    mov bh,cl    
;    mov cl,bl
;ulit:
;mov ah,09h
;mov dx,offset var1
;int 21h   
;loop ulit
;
;inc bl
;mov ah,09h
;mov dx,offset var2
;int 21h
;  mov cl,bh  
;loop ulit2
;
;mov ah,4ch
;int 21h



;.model small
;.data
;var1 db '*','$'
;var2 db ' ',13,10,'$'
;.code
;mov ax,@data
;mov ds,ax
;mov cx,10 
;
;ulit2:     
;push cx
;
;    mov cl,5    
;    ulit:
;       mov ah,09h
;       mov dx,offset var1
;       int 21h
;    loop ulit
;    
;mov ah,09h
;mov dx,offset var2
;int 21h
;
;pop cx
;loop ulit2
;
;mov ah,4ch
;int 21h
;
;
;.model small
;.data
;var1 db '*','$'
;var2 db '',10,13,'$'
;.code
;mov ax,@data
;mov ds,ax
;mov cx,3
;mov bx,1
;ulit2:     
;    push cx 
;    push bx 
;       pop cx
;       ulit:
;       mov ah,09h
;       mov dx,offset var1
;       int 21h   
;       loop ulit 
;       inc bx
;
;    mov ah,09h
;    mov dx,offset var2
;    int 21h
;    pop cx
;loop ulit2
;
;mov ah,4ch
;int 21h


;.model small
;.data
;var1 db '*','$'
;var2 db '',10,13,'$'
;.code
;mov ax,@data
;mov ds,ax
;
;mov cx,3
;;mov bx,1
;
;
;ulit2:     
;    push cx ;top stack 3
;   ; push bx ;*
;    
;    ;   pop cx
;       ulit:
;       mov ah,09h
;       mov dx,offset var1
;       int 21h   
;       loop ulit 
; ;      inc bx
;
;    mov ah,09h
;    mov dx,offset var2
;    int 21h
;    pop cx
;loop ulit2
;
;mov ah,4ch
;int 21h

;===========================================================
;JMP Instruction
;
;mov ax,1234h 
;jmp hello
;mov bx,4567h
;hello:
;    inc ax 
;mov ah,4ch
;int 21h
;  ------------------
;mov ax,1234h 
;mov bx,4567h
;cmp ax,bx
;ja hello
;jb hi
;
;hello:
;    inc ax 
;
;mov ax,4c00h
;int 21h
;
;
;hi:
;    dec ax 
;
;mov ax,4c00h
;int 21h    
;
;--------------
;mov ax,1234h 
;mov bx,1235h
;cmp ax,bx
;je hello  
;jne hi
;
;hello:
;    inc ax 
;mov ax,4c00h
;int 21h
;
;
;hi:
;    dec ax 
;mov ax,4c00h
;int 21h 
;
;
;---------------
;
;mov ax,1234h 
;mov bx,1235h
;cmp ax,bx
;jg hello    ;zf=0   sf=of
;jl hi           ;SF <> OF
;
;hello:
;    inc ax 
;
;mov ax,4c00h
;int 21h
;
;
;hi:
;    dec ax 
;
;mov ax,4c00h
;int 21h    
;
;----------------
;
;
;.model small
;.data
;num1 dw 0015h
;
; 
;var1 db 'odd ','$'
;var2 db 'even',10,13,'$'
;
;
;
;.code
;
;start:
;mov ax,@data
;mov ds,ax
;mov bl,2
;
;mov ax,[num1]   ;save num1 sa al
;div bl  
;
;cmp ah,0       
;je even
;jne odd        
;
;odd:
;   mov ah,09
;   mov dx,offset var1
;   int 21h
;jmp exit
;
;even:
;   mov ah,09
;   mov dx,offset var2
;   int 21h
;jmp exit
;
;   
;exit:
;
; mov ah,4CH
; int 21h
 



;.model small
;.data
;num1 db 2
;num2 db 1
;num3 db 5
;lar db '0',13,10,'$'
;.code
;
;start:
;mov ax,@data
;mov ds,ax
;mov al,[num1]   ;save num1 sa al
;mov bl,[num2]   ;save num2 sa bl
;mov cl,[num3]   ;save num3 sa cl
;
;cmp al,bl       ;compare 1 and 2
;jg checkthird   ;jump para compare naman firstandthird
;jmp checksecond ;jump para compare naman sa secondandthird
;
;checksecond:
;cmp bl,cl           ;compare 2 and 3
;jg secondlargest    ;jump para print second as largest
;jmp thirdlargest    ;jump para print thrird as largest
;
;checkthird:     
;cmp al,cl       ;compare 1 and 3
;jg firstlargest ;jump para print first as largest
;jmp thirdlargest ;jump pag mas mali ung third 
;
;
;firstlargest:
;mov al,[num1]  ;save sa AL ung laman ng variable na num1
;or al,30h      ;use OR para maging ascii 
;lea bx,lar     ;kukunin address ng variable na LAR at isave sa BX
;mov [bx],al    ;isave sa memory location ng LAR ung value ng AL
;jmp print
;                  
;
;secondlargest:
;mov al,[num2]  
;or al,30h
;lea bx,lar
;mov [bx],al     
;jmp print
;
;
;thirdlargest:
;mov al,[num3]  
;or al,30h
;lea bx,lar
;mov [bx],al     
;jmp print
;                  
;                  
;print:
;mov ah,09
;mov dx,offset lar
;int 21h
;
;mov ah,4ch
;int 21h
;
;==========================================================================
;
;
;Procedure / Method / Function
;     
;--------------------
;.model small
;.stack 100
;.data
;.code
;MOV AX,1234H ;1
;CALL ADDP
;MOV BX,5678H  ;5
;
;
;MOV AH,4CH
;INT 21H
;
;ADDP PROC NEAR
;     INC AX      ;2
;     CALL SUBP
;     NEG AX    ;4
;     RET
;ADDP ENDP
;
;
;SUBP PROC NEAR
;     DEC AX  ;3
;     RET
;SUBP ENDP
;;---------
;;POWER(2,3)
;
;MOV BX,02
;MOV AX,01
;MOV CX,03H
;CALL POWER
; 
;MOV AH,4CH
;INT 21H
;
;POWER   PROC  NEAR
;     HI:
;        MUL BX    
;        LOOP HI:
;        RET    
;POWER  ENDP  
;
;
;
;
;========================================================================
;
;Array 
;Its a data type whose members (elements) are all in the same data type. 
;It consists a list of elements with same data type.
;
;How to declare an array of bytes:
;	b_array 	db 	  1, 2, 3, 4
;	(array name) (data type) (values) 
;How to declare an array of words:
;	w_array dw FFFFh, 789Ah, BCDEh
;
;How to declare multiple-line array:
;	big db 21, 22, 23, 24, 25, 26, 27, 28, 29, 30
;	or
;	big db 21,22,23,24
;	    db 25,26,27,28
;	    db 29,30
;
;The DUP Operator:
;	count DUP (initial_value [[, initial_value]]...)
;Example:
;	barray db 5 DUP (1) 
;	is similar to
;	barray db 1, 1, 1, 1, 1
;
;
;
;
;
;=========================================
;;Print all elements
;.model small
;.stack 100h
;.data
;    arr db 1,2,3,4,5 
;.code
;
;mov ax,@data
;mov ds,ax
;
;mov cx,5 ;counter of loop
;mov si,0 ;pointer
;mov ah,2 ;printing single char
;
;output:
;mov dl,arr[si]
;add dl,30h
;int 21h
;mov dl,0Ah
;int 21h
;mov dl,0Dh
;int 21h
;inc si
;loop output
;
;end
;
;
;
;============================
;;copy array 1 to array2
;.model small
;.stack
;.data
;
;arr1 db 1h,2h,3h,4h,5h
;arr2 db ''
;
;.code
;
;
;start:
;mov ax,@data
;mov ds,ax
;mov es,ax
;
;
;mov cx,5
;lea si,arr1
;lea di,arr2 
;
;mov cx,5
;rep movsb
;
;end start
;
;============================
;.model small
;.stack
;.data
;
;arr1 db 1h,2h,3h,4h,5h,6h,7h,8h,9h,10h,11h
;arr2 db ''
;
;.code
;
;
;start:
;mov ax,@data
;mov ds,ax
;
;
;mov al,0
;mov cx,11
;mov si,0
;
;labko:
;
;add al,arr1[si]
;mov arr2[si],al
;inc si
;loop labko
;
;end start
;
;
;===============================
;
;.model small
;.stack 100h
;
;.data
;array db 1, 2, 3, 4, 5     ; Array of 5 elements
;sum   db 0                ; Variable to store the sum
;
;.code
;main:
;    mov ax, @data         ; Initialize data segment
;    mov ds, ax
;
;    xor ax, ax            ; Clear AX to store the sum
;    xor si, si            ; Index register for array (offset from start)
;
;    mov cx,05h         ; Set loop counter
;
;sum_loop:
;    add al, array[si]      ; Add element to AX
;     inc si    
;    loop sum_loop         ; Loop until CX = 0
;
;    mov sum, al           ; Store result in 'sum'
;
;    ; End program
;    mov ah, 4ch
;   
;    int 21h
;    
;    
;    
;end main
;
;
;
;=====================
;.model small
;.stack 100
;.data
;
;    array db 0,1,2,3,4,5,6,7,8,9
;    max db 0
;
;.code
;
;mov ax,@data
;mov ds,ax
;
;xor di,di
;mov cl,10
;lea bx,array
;mov al,max
;
;back:
;cmp al,[bx+di]
;jnc skip
;
;mov dl,[bx+di]
;mov al,dl
;
;skip:
;inc di
;dec cl
;jnz back
;
;or al,30h
;mov max[0],al
;mov ah,02
;mov dl,max[0]
;int 21h
;
;
;mov ah,4ch
;int 21h
;end
