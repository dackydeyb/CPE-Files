.model small
.stack
.data
    var1 DB '9:28 P.M. ', 13, 10, '$'
    var2 DB 'TiI  29% ', 13, 10, '$'
    fbName DB 'Facebook', 13, 10, '$'
    msgName DB 'Messenger', 13, 10, '$'
    youtube DB 'Youtube', 13, 10, '$'
    goo DB 'Google Calendar', 13, 10, '$'
.code

mov ax, 1112h
int 10h

start:
mov ah, 06h
mov bh, 0xFF ; Color
mov ch, 0   ; start ROW
mov cl, 0   ; start Column
mov dh, 70  ; end ROW
mov dl, 79  ; end Column
int 10h 

; bezel phone
mov ah, 06h
mov bh, 00h ; Color
mov ch, 2   ; start ROW
mov cl, 20   ; start Column
mov dh, 2  ; end ROW
mov dl, 60  ; end Column
int 10h

mov ah, 06h
mov bh, 00h ; Color
mov ch, 3   ; start ROW
mov cl, 18   ; start Column
mov dh, 3  ; end ROW
mov dl, 19  ; end Column
int 10h

mov ah, 06h
mov bh, 00h ; Color
mov ch, 3   ; start ROW
mov cl, 61   ; start Column
mov dh, 3  ; end ROW
mov dl, 62  ; end Column
int 10h

mov ah, 06h
mov bh, 00h ; Color
mov ch, 4   ; start ROW
mov cl, 17   ; start Column
mov dh, 5  ; end ROW
mov dl, 17  ; end Column
int 10h

mov ah, 06h
mov bh, 00h ; Color
mov ch, 4   ; start ROW
mov cl, 63   ; start Column
mov dh, 5  ; end ROW
mov dl, 63  ; end Column
int 10h

mov ah, 06h
mov bh, 00h ; Color
mov ch, 6   ; start ROW
mov cl, 16   ; start Column
mov dh, 56  ; end ROW
mov dl, 16  ; end Column
int 10h

mov ah, 06h
mov bh, 00h ; Color
mov ch, 6   ; start ROW
mov cl, 64   ; start Column
mov dh, 56  ; end ROW
mov dl, 64  ; end Column
int 10h

mov ah, 06h
mov bh, 00h ; Color
mov ch, 57   ; start ROW
mov cl, 17   ; start Column
mov dh, 58  ; end ROW
mov dl, 17  ; end Column
int 10h

mov ah, 06h
mov bh, 00h ; Color
mov ch, 57   ; start ROW
mov cl, 63   ; start Column
mov dh, 58  ; end ROW
mov dl, 63  ; end Column
int 10h

mov ah, 06h
mov bh, 00h ; Color
mov ch, 59   ; start ROW
mov cl, 18   ; start Column
mov dh, 59  ; end ROW
mov dl, 19  ; end Column
int 10h 

mov ah, 06h
mov bh, 00h ; Color
mov ch, 59   ; start ROW
mov cl, 61   ; start Column
mov dh, 59  ; end ROW
mov dl, 62  ; end Column
int 10h

mov ah, 06h
mov bh, 00h ; Color
mov ch, 60   ; start ROW
mov cl, 20   ; start Column
mov dh, 60  ; end ROW
mov dl, 60  ; end Column
int 10h

; inside phone
mov ah, 06h
mov bh, 88h ; Color
mov ch, 3   ; start ROW
mov cl, 20   ; start Column
mov dh, 59  ; end ROW
mov dl, 60  ; end Column
int 10h

mov ah, 06h
mov bh, 88h ; Color
mov ch, 4   ; start ROW
mov cl, 18   ; start Column
mov dh, 58  ; end ROW
mov dl, 62 ; end Column
int 10h

mov ah, 06h
mov bh, 88h ; Color
mov ch, 6   ; start ROW
mov cl, 17   ; start Column
mov dh, 56  ; end ROW
mov dl, 63 ; end Column
int 10h

;small speaker
mov ah, 06h
mov bh, 00h ; Color
mov ch, 6   ; start ROW
mov cl, 34   ; start Column
mov dh, 6  ; end ROW
mov dl, 34 ; end Column
int 10h

mov ah, 06h
mov bh, 00h ; Color
mov ch, 5   ; start ROW
mov cl, 35   ; start Column
mov dh, 7  ; end ROW
mov dl, 45 ; end Column
int 10h

mov ah, 06h
mov bh, 00h ; Color
mov ch, 6   ; start ROW
mov cl, 46   ; start Column
mov dh, 6  ; end ROW
mov dl, 46 ; end Column
int 10h

mov ah, 06h
mov bh, 88h ; Color
mov ch, 6   ; start ROW
mov cl, 35   ; start Column
mov dh, 6  ; end ROW
mov dl, 45 ; end Column
int 10h

;camera

mov ah, 06h
mov bh, 00h ; Color
mov ch, 6   ; start ROW
mov cl, 32   ; start Column
mov dh, 6  ; end ROW
mov dl, 32 ; end Column
int 10h

mov ah, 06h
mov bh, 00h ; Color
mov ch, 5   ; start ROW
mov cl, 29   ; start Column
mov dh, 7  ; end ROW
mov dl, 31 ; end Column
int 10h

mov ah, 06h
mov bh, 00h ; Color
mov ch, 6   ; start ROW
mov cl, 28   ; start Column
mov dh, 6  ; end ROW
mov dl, 28 ; end Column
int 10h

;screen
mov ah, 06h
mov bh, 00h ; Color
mov ch, 10   ; start ROW
mov cl, 18   ; start Column
mov dh, 52  ; end ROW
mov dl, 62 ; end Column
int 10h

; home button
mov ah, 06h
mov bh, 00h ; Color
mov ch, 54   ; start ROW
mov cl, 37   ; start Column
mov dh, 58  ; end ROW
mov dl, 43 ; end Column
int 10h

mov ah, 06h
mov bh, 00h ; Color
mov ch, 55   ; start ROW
mov cl, 36   ; start Column
mov dh, 57  ; end ROW
mov dl, 44 ; end Column
int 10h

mov ah, 06h
mov bh, 00h ; Color
mov ch, 55   ; start ROW
mov cl, 36   ; start Column
mov dh, 57  ; end ROW
mov dl, 44 ; end Column
int 10h

mov ah, 06h
mov bh, 88h ; Color
mov ch, 55   ; start ROW
mov cl, 37   ; start Column
mov dh, 57  ; end ROW
mov dl, 43 ; end Column
int 10h

; white screen


mov ah, 06h
mov bh, 0xF0 ; Color
mov ch, 11   ; start ROW
mov cl, 19   ; start Column
mov dh, 51  ; end ROW
mov dl, 61 ; end Column
int 10h

mov ax, @data
mov ds, ax





; time notification bar

mov ah, 02h
mov bh, 00
mov dh, 11 ; ROW
mov dl, 19 ; Column
 int 10h
 
mov ah, 09h
mov dx, offset var1
int 21h

mov ah, 02h
mov bh, 00
mov dh, 11 ; ROW
mov dl, 53 ; Column
int 10h
 
mov ah, 09h
mov dx, offset var2
int 21h






; APPLICATIONS
;facebook  icon
mov ah, 06h
mov bh, 99h ; Color
mov ch, 15   ; start ROW
mov cl, 20   ; start Column
mov dh, 20  ; end ROW
mov dl, 27 ; end Column
int 10h

mov ah, 06h
mov bh, 0xFF ; Color
mov ch, 17   ; start ROW
mov cl, 24   ; start Column
mov dh, 20  ; end ROW
mov dl, 24 ; end Column
int 10h

mov ah, 06h
mov bh, 0xFF ; Color
mov ch, 18   ; start ROW
mov cl, 23   ; start Column
mov dh, 18  ; end ROW
mov dl, 25 ; end Column
int 10h

mov ah, 06h
mov bh, 0xFF ; Color
mov ch, 16   ; start ROW
mov cl, 25   ; start Column
mov dh, 16  ; end ROW
mov dl, 26 ; end Column
int 10h
;fbname
mov ah, 02h
mov bh, 00
mov dh, 21 ; ROW
mov dl, 20 ; Column
int 10h
 
mov ah, 09h
mov dx, offset fbName
int 21h

;messenger  icon
mov ah, 06h
mov bh, 99h ; Color
mov ch, 15   ; start ROW
mov cl, 35   ; start Column
mov dh, 20  ; end ROW
mov dl, 43 ; end Column
int 10h

; trim messenger to circle
mov ah, 06h
mov bh, 0xFF ; Color
mov ch, 15   ; start ROW
mov cl, 35   ; start Column
mov dh, 15  ; end ROW
mov dl, 35 ; end Column
int 10h

mov ah, 06h
mov bh, 0xFF ; Color
mov ch, 20   ; start ROW
mov cl, 35   ; start Column
mov dh, 20  ; end ROW
mov dl, 35 ; end Column
int 10h

mov ah, 06h
mov bh, 0xFF ; Color
mov ch, 15   ; start ROW
mov cl, 43   ; start Column
mov dh, 15  ; end ROW
mov dl, 43 ; end Column
int 10h

mov ah, 06h
mov bh, 0xFF ; Color
mov ch, 20   ; start ROW
mov cl, 43   ; start Column
mov dh, 20  ; end ROW
mov dl, 43 ; end Column
int 10h

;lightning in messenger
mov ah, 06h
mov bh, 0xFF ; Color
mov ch, 18   ; start ROW
mov cl, 37   ; start Column
mov dh, 18  ; end ROW
mov dl, 39 ; end Column
int 10h

mov ah, 06h
mov bh, 0xFF ; Color
mov ch, 17   ; start ROW
mov cl, 39   ; start Column
mov dh, 17  ; end ROW
mov dl, 41 ; end Column
int 10h

;messengername
mov ah, 02h
mov bh, 00
mov dh, 21 ; ROW
mov dl, 35 ; Column
int 10h
 
mov ah, 09h
mov dx, offset msgName
int 21h


; Youtube
mov ah, 06h
mov bh, 0xCC ; Color
mov ch, 15   ; start ROW
mov cl, 49   ; start Column
mov dh, 20  ; end ROW
mov dl, 60 ; end Column
int 10h

mov ah, 06h
mov bh, 0xFF ; Color
mov ch, 15   ; start ROW
mov cl, 49   ; start Column
mov dh, 15  ; end ROW
mov dl, 49 ; end Column
int 10h

mov ah, 06h
mov bh, 0xFF ; Color
mov ch, 15   ; start ROW
mov cl, 60   ; start Column
mov dh, 15  ; end ROW
mov dl, 60 ; end Column
int 10h

mov ah, 06h
mov bh, 0xFF ; Color
mov ch, 20   ; start ROW
mov cl, 49   ; start Column
mov dh, 20  ; end ROW
mov dl, 49 ; end Column
int 10h

mov ah, 06h
mov bh, 0xFF ; Color
mov ch, 29   ; start ROW
mov cl, 60   ; start Column
mov dh, 20  ; end ROW
mov dl, 60 ; end Column
int 10h

; play button logo in youtube
mov ah, 06h
mov bh, 0xFF ; Color
mov ch, 16   ; start ROW
mov cl, 53   ; start Column
mov dh, 19  ; end ROW
mov dl, 53 ; end Column
int 10h

mov ah, 06h
mov bh, 0xFF ; Color
mov ch, 17   ; start ROW
mov cl, 54   ; start Column
mov dh, 18  ; end ROW
mov dl, 54 ; end Column
int 10h

mov ah, 06h
mov bh, 0xFF ; Color
mov ch, 18   ; start ROW
mov cl, 55   ; start Column
mov dh, 18  ; end ROW
mov dl, 55 ; end Column
int 10h

; youtube name
mov ah, 02h
mov bh, 00
mov dh, 21 ; ROW
mov dl, 52 ; Column
int 10h
 
mov ah, 09h
mov dx, offset youtube
int 21h



; Google Search bar
mov ah, 06h
mov bh, 88h ; Color
mov ch, 24   ; start ROW
mov cl, 20   ; start Column
mov dh, 49  ; end ROW
mov dl, 60 ; end Column
int 10h

mov ah, 06h
mov bh, 0xFF ; Color
mov ch, 24   ; start ROW
mov cl, 20   ; start Column
mov dh, 24  ; end ROW
mov dl, 20 ; end Column
int 10h

mov ah, 06h
mov bh, 0xFF ; Color
mov ch, 49   ; start ROW
mov cl, 20   ; start Column
mov dh, 49  ; end ROW
mov dl, 20 ; end Column
int 10h

mov ah, 06h
mov bh, 0xFF ; Color
mov ch, 24   ; start ROW
mov cl, 60   ; start Column
mov dh, 24  ; end ROW
mov dl, 60 ; end Column
int 10h 

mov ah, 06h
mov bh, 0xFF ; Color
mov ch, 49   ; start ROW
mov cl, 60   ; start Column
mov dh, 49  ; end ROW
mov dl, 60 ; end Column
int 10h 

mov ah, 06h
mov bh, 0xFF ; Color
mov ch, 25   ; start ROW
mov cl, 21   ; start Column
mov dh, 48  ; end ROW
mov dl, 59 ; end Column
int 10h 

; grid calendar

mov ah, 06h
mov bh, 88h ; Color
mov ch, 25   ; start ROW
mov cl, 26   ; start Column
mov dh, 48  ; end ROW
mov dl, 26 ; end Column
int 10h

mov ah, 06h
mov bh, 88h ; Color
mov ch, 25   ; start ROW
mov cl, 32   ; start Column
mov dh, 48  ; end ROW
mov dl, 32 ; end Column
int 10h

mov ah, 06h
mov bh, 88h ; Color
mov ch, 25   ; start ROW
mov cl, 38   ; start Column
mov dh, 48  ; end ROW
mov dl, 38 ; end Column
int 10h

mov ah, 06h
mov bh, 88h ; Color
mov ch, 25   ; start ROW
mov cl, 44   ; start Column
mov dh, 48  ; end ROW
mov dl, 44 ; end Column
int 10h

mov ah, 06h
mov bh, 88h ; Color
mov ch, 25   ; start ROW
mov cl, 49   ; start Column
mov dh, 48  ; end ROW
mov dl, 49 ; end Column
int 10h

mov ah, 06h
mov bh, 88h ; Color
mov ch, 25   ; start ROW
mov cl, 54   ; start Column
mov dh, 48  ; end ROW
mov dl, 54 ; end Column
int 10h

; horizontal grid lines
mov ah, 06h
mov bh, 88h ; Color
mov ch, 30   ; start ROW
mov cl, 21   ; start Column
mov dh, 30  ; end ROW
mov dl, 60 ; end Column
int 10h

mov ah, 06h
mov bh, 88h ; Color
mov ch, 36   ; start ROW
mov cl, 21   ; start Column
mov dh, 36  ; end ROW
mov dl, 60 ; end Column
int 10h

mov ah, 06h
mov bh, 88h ; Color
mov ch, 43   ; start ROW
mov cl, 21   ; start Column
mov dh, 43  ; end ROW
mov dl, 60 ; end Column
int 10h
 


; Google name
mov ah, 02h
mov bh, 00
mov dh, 23 ; ROW
mov dl, 20 ; Column
int 10h
 
mov ah, 09h
mov dx, offset goo
int 21h


mov ah, 4ch
int 21h

end start