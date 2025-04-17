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
   
; Printing number 5 
mov ah, 06h
mov bh, 00h  
mov ch, 1   
mov cl, 5   
mov dh, 1   
mov dl, 10   
int 10h 

mov ah, 06h
mov bh, 00h  
mov ch, 2   
mov cl, 5   
mov dh, 3   
mov dl, 5   
int 10h

mov ah, 06h
mov bh, 00h  
mov ch, 3   
mov cl, 6   
mov dh, 3   
mov dl, 9   
int 10h 

mov ah, 06h
mov bh, 00h  
mov ch, 4   
mov cl, 10 
mov dh, 6   
mov dl, 10   
int 10h

mov ah, 06h
mov bh, 00h 
mov ch, 7  
mov cl, 6  
mov dh, 7  
mov dl, 9   
int 10h 

mov ah, 06h
mov bh, 00h  
mov ch, 5   
mov cl, 5  
mov dh, 6   
mov dl, 5 
int 10h

;dot
mov ah, 06h
mov bh, 00h  
mov ch, 7   
mov cl, 12 
mov dh, 7   
mov dl, 12  
int 10h 

; number 4        
mov ah, 06h
mov bh, 00h 
mov ch, 1  
mov cl, 17  
mov dh, 7  
mov dl, 17  
int 10h
 

mov ah, 06h
mov bh, 00h  
mov ch, 2   
mov cl, 16   
mov dh, 3  
mov dl, 16   
int 10h 

mov ah, 06h
mov bh, 00h  
mov ch, 4  
mov cl, 14  
mov dh, 5  
mov dl, 15  
int 10h

mov ah, 06h
mov bh, 00h 
mov ch, 3  
mov cl, 15  
mov dh, 3  
mov dl, 15  
int 10h
        
mov ah, 06h
mov bh, 00h 
mov ch, 5  
mov cl, 16  
mov dh, 5   
mov dl, 16   
int 10h


; number 6
mov ah, 06h
mov bh, 00h 
mov ch, 2   
mov cl, 19  
mov dh, 6  
mov dl, 19   
int 10h 

mov ah, 06h
mov bh, 00h 
mov ch, 1  
mov cl, 20 
mov dh, 1  
mov dl, 22  
int 10h

mov ah, 06h
mov bh, 00h 
mov ch, 7   
mov cl, 20 
mov dh, 7   
mov dl, 22  
int 10h

mov ah, 06h
mov bh, 00h  
mov ch, 5  
mov cl, 23   
mov dh, 6   
mov dl, 23 
int 10h

mov ah, 06h
mov bh, 00h 
mov ch, 4  
mov cl, 20  
mov dh, 4   
mov dl, 22   
int 10h

; Letter G
mov ah, 06h
mov bh, 00h 
mov ch, 2  
mov cl, 25  
mov dh, 6   
mov dl, 25  
int 10h

mov ah, 06h
mov bh, 00h 
mov ch, 1 
mov cl, 26   
mov dh, 1  
mov dl, 29  
int 10h 
 
mov ah, 06h
mov bh, 00h 
mov ch, 7   
mov cl, 26   
mov dh, 7  
mov dl, 29  
int 10h 
 
mov ah, 06h
mov bh, 00h  
mov ch, 4  
mov cl, 29  
mov dh, 7  
mov dl, 29 
int 10h 
  
mov ah, 06h
mov bh, 00h 
mov ch, 4  
mov cl, 27  
mov dh, 4  
mov dl, 28 
int 10h 
 
; print ohms 
mov ah, 06h
mov bh, 00h  
mov ch, 7  
mov cl, 31  
mov dh, 7  
mov dl, 33  
int 10h  
 
mov ah, 06h
mov bh, 00h  
mov ch, 7  
mov cl, 37  
mov dh, 7  
mov dl, 39
int 10h 
 
mov ah, 06h
mov bh, 00h  
mov ch, 6  
mov cl, 33  
mov dh, 6  
mov dl, 33  
int 10h 
 
mov ah, 06h
mov bh, 00h 
mov ch, 6  
mov cl, 37 
mov dh, 6  
mov dl, 37  
int 10h 
 
mov ah, 06h
mov bh, 00h  
mov ch, 3  
mov cl, 32  
mov dh, 5   
mov dl, 32  
int 10h 
 
mov ah, 06h
mov bh, 00h  
mov ch, 3  
mov cl, 38  
mov dh, 5  
mov dl, 38  
int 10h 

mov ah, 06h
mov bh, 00h 
mov ch, 2  
mov cl, 33  
mov dh, 2 
mov dl, 33  
int 10h 

mov ah, 06h
mov bh, 00h 
mov ch, 2   
mov cl, 37   
mov dh, 2  
mov dl, 37  
int 10h

mov ah, 06h
mov bh, 00h  
mov ch, 1  
mov cl, 34   
mov dh, 1  
mov dl, 36  
int 10h

; print plus and minus sign

mov ah, 06h
mov bh, 00h  
mov ch, 1   
mov cl, 49 
mov dh, 5  
mov dl, 49  
int 10h

mov ah, 06h
mov bh, 00h  
mov ch, 3 
mov cl, 47  
mov dh, 3  
mov dl, 51  
int 10h

mov ah, 06h
mov bh, 00h 
mov ch, 7   
mov cl, 47   
mov dh, 7  
mov dl, 51  
int 10h

; print 0
mov ah, 06h
mov bh, 00h  
mov ch, 2   
mov cl, 53  
mov dh, 6  
mov dl, 53 
int 10h

mov ah, 06h
mov bh, 00h 
mov ch, 2   
mov cl, 56 
mov dh, 6   
mov dl, 56  
int 10h

mov ah, 06h
mov bh, 00h 
mov ch, 1  
mov cl, 54 
mov dh, 1  
mov dl, 55  
int 10h

mov ah, 06h
mov bh, 00h 
mov ch, 7   
mov cl, 54  
mov dh, 7   
mov dl, 55   
int 10h

; print dot

mov ah, 06h
mov bh, 00h  
mov ch, 7   
mov cl, 58  
mov dh, 7   
mov dl, 58  
int 10h

;print zero
mov ah, 06h
mov bh, 00h 
mov ch, 2   
mov cl, 60  
mov dh, 6   
mov dl, 60   
int 10h

mov ah, 06h
mov bh, 00h 
mov ch, 2  
mov cl, 63  
mov dh, 6  
mov dl, 63  
int 10h

mov ah, 06h
mov bh, 00h  
mov ch, 1  
mov cl, 61   
mov dh, 1   
mov dl, 62   
int 10h

mov ah, 06h
mov bh, 00h  
mov ch, 7   
mov cl, 61 
mov dh, 7   
mov dl, 62  
int 10h
 
; Printing number 5 
mov ah, 06h
mov bh, 00h  
mov ch, 1  
mov cl, 66  
mov dh, 7  
mov dl, 66   
int 10h 

mov ah, 06h
mov bh, 00h 
mov ch, 2   
mov cl, 65  
mov dh, 2   
mov dl, 65  
int 10h

mov ah, 06h
mov bh, 00h 
mov ch, 7   
mov cl, 65 
mov dh, 7  
mov dl, 67  
int 10h 
 
; print percentage
mov ah, 06h
mov bh, 00h  
mov ch, 1   
mov cl, 69  
mov dh, 2  
mov dl, 70  
int 10h
 
mov ah, 06h
mov bh, 00h  
mov ch, 6  
mov cl, 72  
mov dh, 7   
mov dl, 73  
int 10h
  
mov ah, 06h
mov bh, 00h  
mov ch, 1  
mov cl, 73 
mov dh, 1   
mov dl, 73  
int 10h 

mov ah, 06h
mov bh, 00h 
mov ch, 7   
mov cl, 69  
mov dh, 7  
mov dl, 69  
int 10h

mov ah, 06h
mov bh, 00h 
mov ch, 2  
mov cl, 72   
mov dh, 3  
mov dl, 72  
int 10h

mov ah, 06h
mov bh, 00h  
mov ch, 5  
mov cl, 70  
mov dh, 6  
mov dl, 70  
int 10h

mov ah, 06h
mov bh, 00h  
mov ch, 4   
mov cl, 71 
mov dh, 4  
mov dl, 71  
int 10h
 


;printing the resistor 
mov ah, 06h
mov bh, 00h 
mov ch, 10   
mov cl, 12   
mov dh, 22 
mov dl, 22  
int 10h 
    ; white filler
mov ah, 06h
mov bh, 0xFF  
mov ch, 11  
mov cl, 12  
mov dh, 21  
mov dl, 22   
int 10h 
 
mov ah, 06h
mov bh, 00h  
mov ch, 12  
mov cl, 24  
mov dh, 20   
mov dl, 56  
int 10h
    ; white filler
mov ah, 06h
mov bh, 0xFF 
mov ch, 13   
mov cl, 24  
mov dh, 19   
mov dl, 56  
int 10h
     
mov ah, 06h
mov bh, 00h  
mov ch, 10  
mov cl, 58   
mov dh, 22  
mov dl, 68  
int 10h 
     ; white filler
mov ah, 06h
mov bh, 0xFF 
mov ch, 11   
mov cl, 58 
mov dh, 21   
mov dl, 68   
int 10h


 
mov ah, 06h
mov bh, 00h 
mov ch, 11  
mov cl, 57   
mov dh, 11   
mov dl, 57   
int 10h 
 
mov ah, 06h
mov bh, 00h 
mov ch, 21  
mov cl, 57  
mov dh, 21  
mov dl, 57  
int 10h 
 
mov ah, 06h
mov bh, 00h  
mov ch, 11   
mov cl, 23   
mov dh, 11   
mov dl, 23   
int 10h 
 
mov ah, 06h
mov bh, 00h 
mov ch, 21  
mov cl, 23  
mov dh, 21  
mov dl, 23  
int 10h 
 
mov ah, 06h
mov bh, 00h 
mov ch, 11  
mov cl, 10   
mov dh, 11  
mov dl, 11  
int 10h   
 
mov ah, 06h
mov bh, 00h 
mov ch, 12  
mov cl, 9   
mov dh, 13  
mov dl, 9   
int 10h 
 
mov ah, 06h
mov bh, 00h 
mov ch, 14  
mov cl, 8  
mov dh, 18   
mov dl, 8  
int 10h 
 
mov ah, 06h
mov bh, 00h  
mov ch, 19   
mov cl, 9  
mov dh, 20 
mov dl, 9  
int 10h 
 
mov ah, 06h
mov bh, 00h 
mov ch, 21  
mov cl, 10  
mov dh, 21  
mov dl, 11   
int 10h 
 
; right side resistor
mov ah, 06h
mov bh, 00h 
mov ch, 11   
mov cl, 69  
mov dh, 11  
mov dl, 70  
int 10h 
 
mov ah, 06h
mov bh, 00h 
mov ch, 12   
mov cl, 71 
mov dh, 13   
mov dl, 71   
int 10h 
 
mov ah, 06h
mov bh, 00h
mov ch, 14   
mov cl, 72  
mov dh, 18   
mov dl, 72   
int 10h 
 
mov ah, 06h
mov bh, 00h  
mov ch, 19   
mov cl, 71  
mov dh, 20  
mov dl, 71  
int 10h  
 
mov ah, 06h
mov bh, 00h 
mov ch, 21 
mov cl, 69   
mov dh, 21  
mov dl, 70  
int 10h  
  


; 1st Band (Green)
  
mov ah, 06h
mov bh, 0xAA  
mov ch, 11  
mov cl, 18   
mov dh, 21   
mov dl, 21  
int 10h  
  
; 2nd band (Yellow)
mov ah, 06h
mov bh, 0xEE 
mov ch, 13  
mov cl, 25   
mov dh, 19  
mov dl, 27  
int 10h  
    
; 3rd band (Blue)
mov ah, 06h
mov bh, 99h 
mov ch, 13  
mov cl, 31  
mov dh, 19  
mov dl, 33  
int 10h 
  
; 4th band (Purple)  
mov ah, 06h
mov bh, 55h 
mov ch, 13   
mov cl, 36 
mov dh, 19  
mov dl, 38   
int 10h  
  
; 5th band (Silver)  
mov ah, 06h
mov bh, 77h  
mov ch, 13   
mov cl, 52  
mov dh, 19  
mov dl, 55   
int 10h  
  
; 6th band (Red)
mov ah, 06h
mov bh, 0xcc  
mov ch, 11  
mov cl, 59   
mov dh, 21   
mov dl, 62   
int 10h    
  

;wire left
mov ah, 06h
mov bh, 77h 
mov ch, 16   
mov cl, 73  
mov dh, 16  
mov dl, 79  
int 10h  
  
;wire right
mov ah, 06h
mov bh, 77h  
mov ch, 16 
mov cl, 0   
mov dh, 16  
mov dl, 7  
int 10h   
  
  
  
mov ah, 4ch
int 21h 
end start