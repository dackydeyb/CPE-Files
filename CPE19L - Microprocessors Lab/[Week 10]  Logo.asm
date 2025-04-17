.model small
.stack
.code
start:


; White background
mov ah, 06h
mov bh, 0xFF  
mov ch, 0   
mov cl, 0   
mov dh, 24   
mov dl, 79  
int 10h 

; logo start
mov ah, 06h
mov bh, 00h  ;color
mov ch, 3     ;start row
mov cl, 32     ;start column
mov dh, 19    ;end row
mov dl, 32    ;end column
int 10h         

mov ah, 06h
mov bh, 00h  ;color
mov ch, 3     ;start row
mov cl, 48     ;start column
mov dh, 19    ;end row
mov dl, 48    ;end column
int 10h   

; middle
mov ah, 06h
mov bh, 00h  ;color
mov ch, 5     ;start row
mov cl, 33     ;start column
mov dh, 6    ;end row
mov dl, 33    ;end column
int 10h   

mov ah, 06h
mov bh, 00h  ;color
mov ch, 7     ;start row
mov cl, 34     ;start column
mov dh, 8    ;end row
mov dl, 34    ;end column
int 10h  

mov ah, 06h
mov bh, 0xDD  ;color
mov ch, 9     ;start row
mov cl, 35     ;start column
mov dh, 11    ;end row
mov dl, 35    ;end column
int 10h   

mov ah, 06h
mov bh, 0xEE  ;color
mov ch, 12     ;start row
mov cl, 36     ;start column
mov dh, 13    ;end row
mov dl, 36    ;end column
int 10h 

mov ah, 06h
mov bh, 00h  ;color
mov ch, 14     ;start row
mov cl, 37     ;start column
mov dh, 16    ;end row
mov dl, 37    ;end column
int 10h 

mov ah, 06h
mov bh, 00h  ;color
mov ch, 17     ;start row
mov cl, 38     ;start column
mov dh, 18    ;end row
mov dl, 38    ;end column
int 10h

mov ah, 06h
mov bh, 11h  ;color
mov ch, 19     ;start row
mov cl, 39     ;start column
mov dh, 20    ;end row
mov dl, 39    ;end column
int 10h 

; half start
mov ah, 06h
mov bh, 0xAA  ;color
mov ch, 21     ;start row
mov cl, 40     ;start column
mov dh, 22    ;end row
mov dl, 40    ;end column
int 10h  

mov ah, 06h
mov bh, 00h  ;color
mov ch, 19     ;start row
mov cl, 41     ;start column
mov dh, 20    ;end row
mov dl, 41    ;end column
int 10h

mov ah, 06h
mov bh, 99h  ;color
mov ch, 17     ;start row
mov cl, 42     ;start column
mov dh, 18    ;end row
mov dl, 42    ;end column
int 10h
 
mov ah, 06h
mov bh, 22h  ;color
mov ch, 14     ;start row
mov cl, 43     ;start column
mov dh, 16    ;end row
mov dl, 43    ;end column
int 10h 

mov ah, 06h
mov bh, 00h  ;color
mov ch, 12     ;start row
mov cl, 44     ;start column
mov dh, 13    ;end row
mov dl, 44    ;end column
int 10h   

mov ah, 06h
mov bh, 33h  ;color
mov ch, 9     ;start row
mov cl, 45     ;start column
mov dh, 11    ;end row
mov dl, 45    ;end column
int 10h 

mov ah, 06h
mov bh, 00h  ;color
mov ch, 7     ;start row
mov cl, 46     ;start column
mov dh, 8    ;end row
mov dl, 46    ;end column
int 10h  

mov ah, 06h
mov bh, 0xBB  ;color
mov ch, 5     ;start row
mov cl, 47     ;start column
mov dh, 6    ;end row
mov dl, 47    ;end column
int 10h  






;
mov ah, 06h
mov bh, 66h  ;color
mov ch, 17     ;start row
mov cl, 33     ;start column
mov dh, 18    ;end row
mov dl, 33    ;end column
int 10h

mov ah, 06h
mov bh, 00h  ;color
mov ch, 15     ;start row
mov cl, 34     ;start column
mov dh, 16    ;end row
mov dl, 34    ;end column
int 10h   

mov ah, 06h
mov bh, 0xCC  ;color
mov ch, 14     ;start row
mov cl, 35     ;start column
mov dh, 14    ;end row
mov dl, 35    ;end column
int 10h

mov ah, 06h
mov bh, 44h  ;color
mov ch, 11    ;start row
mov cl, 37     ;start column
mov dh, 11    ;end row
mov dl, 37    ;end column
int 10h 

mov ah, 06h
mov bh, 00h  ;color
mov ch, 9    ;start row
mov cl, 38     ;start column
mov dh, 10    ;end row
mov dl, 38    ;end column
int 10h      

mov ah, 06h
mov bh, 0xDD  ;color
mov ch, 7    ;start row
mov cl, 39     ;start column
mov dh, 8    ;end row
mov dl, 39    ;end column
int 10h  

;middle
mov ah, 06h
mov bh, 00h  ;color
mov ch, 6    ;start row
mov cl, 40     ;start column
mov dh, 6    ;end row
mov dl, 40    ;end column
int 10h

mov ah, 06h
mov bh, 00h  ;color
mov ch, 7    ;start row
mov cl, 41     ;start column
mov dh, 8    ;end row
mov dl, 41    ;end column
int 10h 

mov ah, 06h
mov bh, 0xEE  ;color
mov ch, 9    ;start row
mov cl, 42     ;start column
mov dh, 10    ;end row
mov dl, 42    ;end column
int 10h

mov ah, 06h
mov bh, 00h  ;color
mov ch, 11    ;start row
mov cl, 43     ;start column
mov dh, 11    ;end row
mov dl, 43    ;end column
int 10h  


mov ah, 06h
mov bh, 0xBB  ;color
mov ch, 14    ;start row
mov cl, 45     ;start column
mov dh, 14    ;end row
mov dl, 45    ;end column
int 10h  

mov ah, 06h
mov bh, 0xAA  ;color
mov ch, 15    ;start row
mov cl, 46     ;start column
mov dh, 16    ;end row
mov dl, 46    ;end column
int 10h   

mov ah, 06h
mov bh, 00h  ;color
mov ch, 17    ;start row
mov cl, 47     ;start column
mov dh, 18    ;end row
mov dl, 47    ;end column
int 10h 