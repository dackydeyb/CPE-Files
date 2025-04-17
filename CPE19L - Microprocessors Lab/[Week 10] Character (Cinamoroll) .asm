.model small
.stack
.code
start:


; White background
mov ah, 06h
mov bh, 0xFF  
mov ch, 0   
mov cl, 0   
mov dh, 80   
mov dl, 180  
int 10h 

;start
mov ah, 06h
mov bh, 11h  
mov ch, 17   
mov cl, 5    
mov dh, 20   
mov dl, 5   
int 10h 

;top left
mov ah, 06h
mov bh, 11h
mov ch, 16   
mov cl, 6     
mov dh, 16  
mov dl, 6  
int 10h 

mov ah, 06h
mov bh, 11h
mov ch, 15     
mov cl, 7    
mov dh, 15   
mov dl, 7   
int 10h

mov ah, 06h
mov bh, 11h
mov ch, 14    
mov cl, 8    
mov dh, 14    
mov dl, 12   
int 10h

mov ah, 06h
mov bh, 11h
mov ch, 13    
mov cl, 13    
mov dh, 13   
mov dl, 15  
int 10h  

mov ah, 06h
mov bh, 11h
mov ch, 12    
mov cl, 16   
mov dh, 12  
mov dl, 17    
int 10h   

mov ah, 06h
mov bh, 11h
mov ch, 11   
mov cl, 18   
mov dh, 11  
mov dl, 20    
int 10h  

mov ah, 06h
mov bh, 11h
mov ch, 10   
mov cl, 21  
mov dh, 10  
mov dl, 22   
int 10h

mov ah, 06h
mov bh, 11h
mov ch, 9    
mov cl, 23   
mov dh, 9  
mov dl, 24  
int 10h

mov ah, 06h
mov bh, 11h
mov ch, 8   
mov cl, 25    
mov dh, 8  
mov dl, 26   
int 10h 

mov ah, 06h
mov bh, 11h
mov ch, 7    
mov cl, 27    
mov dh, 7   
mov dl, 31    
int 10h

; top head:

mov ah, 06h
mov bh, 11h
mov ch, 6     
mov cl, 32    
mov dh, 6   
mov dl, 33    
int 10h

mov ah, 06h
mov bh, 11h
mov ch, 5    
mov cl, 34  
mov dh, 5   
mov dl, 43   
int 10h

mov ah, 06h
mov bh, 11h
mov ch, 6     
mov cl, 44     
mov dh, 6   
mov dl, 50   
int 10h

mov ah, 06h
mov bh, 11h
mov ch, 7    
mov cl, 47   
mov dh, 7    
mov dl, 47   
int 10h

mov ah, 06h
mov bh, 11h
mov ch, 8   
mov cl, 48   
mov dh, 8  
mov dl, 48  
int 10h 

mov ah, 06h
mov bh, 11h
mov ch, 8    
mov cl, 29     
mov dh, 8   
mov dl, 29   
int 10h 

mov ah, 06h
mov bh, 11h
mov ch, 9    
mov cl, 28    
mov dh, 9    
mov dl, 28    
int 10h

; right ear
mov ah, 06h
mov bh, 11h
mov ch, 7    
mov cl, 51     
mov dh, 7   
mov dl, 54   
int 10h

mov ah, 06h
mov bh, 11h
mov ch, 8    
mov cl, 55   
mov dh, 8    
mov dl, 58   
int 10h

mov ah, 06h
mov bh, 11h
mov ch, 9     
mov cl, 59     
mov dh, 9   
mov dl, 63  
int 10h

mov ah, 06h
mov bh, 11h
mov ch, 8    
mov cl, 64    
mov dh, 8  
mov dl, 69    
int 10h

mov ah, 06h
mov bh, 11h
mov ch, 9     
mov cl, 70    
mov dh, 9   
mov dl, 70    
int 10h

mov ah, 06h
mov bh, 11h
mov ch, 10     
mov cl, 71    
mov dh, 14   
mov dl, 71   
int 10h

mov ah, 06h
mov bh, 11h
mov ch, 15    
mov cl, 70    
mov dh, 15    
mov dl, 70  
int 10h

mov ah, 06h
mov bh, 11h
mov ch, 16    
mov cl, 69   
mov dh, 16    
mov dl, 69   
int 10h

mov ah, 06h
mov bh, 11h
mov ch, 17    
mov cl, 67     
mov dh, 17   
mov dl, 68   
int 10h 

mov ah, 06h
mov bh, 11h
mov ch, 18     
mov cl, 57     
mov dh, 18   
mov dl, 66   
int 10h 

mov ah, 06h
mov bh, 11h
mov ch, 17    
mov cl, 55    
mov dh, 17   
mov dl, 56   
int 10h 

mov ah, 06h
mov bh, 11h
mov ch, 16    
mov cl, 53     
mov dh, 16    
mov dl, 54    
int 10h  

; bottom right head 
mov ah, 06h
mov bh, 11h
mov ch, 14   
mov cl, 52    
mov dh, 17    
mov dl, 52    
int 10h

mov ah, 06h
mov bh, 11h
mov ch, 13    
mov cl, 51    
mov dh, 13   
mov dl, 51    
int 10h

mov ah, 06h
mov bh, 11h
mov ch, 18    
mov cl, 51     
mov dh, 19   
mov dl, 51    
int 10h

mov ah, 06h
mov bh, 11h
mov ch, 20     
mov cl, 49  
mov dh, 20 
mov dl, 50   
int 10h

mov ah, 06h
mov bh, 11h
mov ch, 21    
mov cl, 47     
mov dh, 21   
mov dl, 48   
int 10h

mov ah, 06h
mov bh, 11h
mov ch, 22     
mov cl, 44   
mov dh, 22    
mov dl, 46    
int 10h

;chin
mov ah, 06h
mov bh, 11h
mov ch, 23    
mov cl, 28    
mov dh, 23  
mov dl, 43  
int 10h

mov ah, 06h
mov bh, 11h
mov ch, 22    
mov cl, 26    
mov dh, 22  
mov dl, 27   
int 10h

mov ah, 06h
mov bh, 11h
mov ch, 21    
mov cl, 25    
mov dh, 21    
mov dl, 25   
int 10h

mov ah, 06h
mov bh, 11h
mov ch, 20     
mov cl, 24     
mov dh, 20    
mov dl, 24   
int 10h

;left face
mov ah, 06h
mov bh, 11h
mov ch, 16   
mov cl, 23    
mov dh, 19 
mov dl, 23   
int 10h

mov ah, 06h
mov bh, 11h
mov ch, 15    
mov cl, 24     
mov dh, 15    
mov dl, 24   
int 10h

mov ah, 06h
mov bh, 11h
mov ch, 14    
mov cl, 25   
mov dh, 14   
mov dl, 25   
int 10h

; left ear
mov ah, 06h
mov bh, 11h
mov ch, 20    
mov cl, 21    
mov dh, 20    
mov dl, 22    
int 10h

mov ah, 06h
mov bh, 11h
mov ch, 21   
mov cl, 19   
mov dh, 21  
mov dl, 20   
int 10h

mov ah, 06h
mov bh, 11h
mov ch, 22     
mov cl, 17   
mov dh, 22  
mov dl, 18 
int 10h

mov ah, 06h
mov bh, 11h
mov ch, 23    
mov cl, 14     
mov dh, 23   
mov dl, 16   
int 10h

mov ah, 06h
mov bh, 11h
mov ch, 24    
mov cl, 9    
mov dh, 24  
mov dl, 13  
int 10h 

mov ah, 06h
mov bh, 11h
mov ch, 23    
mov cl, 7   
mov dh, 23  
mov dl, 8   
int 10h

mov ah, 06h
mov bh, 11h
mov ch, 21     
mov cl, 6     
mov dh, 22   
mov dl, 6    
int 10h

; body
; left hand
mov ah, 06h
mov bh, 11h
mov ch, 24     
mov cl, 31     
mov dh, 24   
mov dl, 31   
int 10h

mov ah, 06h
mov bh, 11h
mov ch, 25    
mov cl, 30     
mov dh, 25  
mov dl, 30   
int 10h

mov ah, 06h
mov bh, 11h
mov ch, 25     
mov cl, 32    
mov dh, 25   
mov dl, 32    
int 10h

mov ah, 06h
mov bh, 11h
mov ch, 26    
mov cl, 29  
mov dh, 28    
mov dl, 29    
int 10h

mov ah, 06h
mov bh, 11h
mov ch, 26    
mov cl, 33   
mov dh, 28  
mov dl, 33   
int 10h 

mov ah, 06h
mov bh, 11h
mov ch, 29    
mov cl, 32     
mov dh, 29   
mov dl, 32   
int 10h 

mov ah, 06h
mov bh, 11h
mov ch, 28     
mov cl, 31    
mov dh, 28    
mov dl, 31    
int 10h

; right hand

mov ah, 06h
mov bh, 11h
mov ch, 27     
mov cl, 36   
mov dh, 28   
mov dl, 36   
int 10h

mov ah, 06h
mov bh, 11h
mov ch, 26     
mov cl, 37    
mov dh, 26  
mov dl, 37 
int 10h

mov ah, 06h
mov bh, 11h
mov ch, 25     
mov cl, 38    
mov dh, 25    
mov dl, 38   
int 10h  

mov ah, 06h
mov bh, 11h
mov ch, 29     
mov cl, 37     
mov dh, 29   
mov dl, 39   
int 10h

mov ah, 06h
mov bh, 11h
mov ch, 28  
mov cl, 40    
mov dh, 28   
mov dl, 40   
int 10h 


; right foot
mov ah, 06h
mov bh, 11h
mov ch, 32     
mov cl, 42   
mov dh, 35  
mov dl, 42  
int 10h

mov ah, 06h
mov bh, 11h
mov ch, 31     
mov cl, 43     
mov dh, 31   
mov dl, 43    
int 10h

mov ah, 06h
mov bh, 11h
mov ch, 30    
mov cl, 44   
mov dh, 30  
mov dl, 45   
int 10h 

mov ah, 06h
mov bh, 11h
mov ch, 31     
mov cl, 46   
mov dh, 34   
mov dl, 46    
int 10h

mov ah, 06h
mov bh, 11h
mov ch, 35    
mov cl, 45   
mov dh, 35   
mov dl, 45    
int 10h

mov ah, 06h
mov bh, 11h
mov ch, 36   
mov cl, 43    
mov dh, 36 
mov dl, 44   
int 10h 

;right body
mov ah, 06h
mov bh, 11h
mov ch, 24    
mov cl, 47   
mov dh, 31  
mov dl, 47  
int 10h 

mov ah, 06h
mov bh, 11h
mov ch, 23    
mov cl, 46    
mov dh, 23   
mov dl, 46  
int 10h

;tail
mov ah, 06h
mov bh, 11h
mov ch, 34   
mov cl, 47    
mov dh, 34   
mov dl, 49   
int 10h

mov ah, 06h
mov bh, 11h
mov ch, 30    
mov cl, 48   
mov dh, 30   
mov dl, 49   
int 10h

mov ah, 06h
mov bh, 11h
mov ch, 28    
mov cl, 50   
mov dh, 29   
mov dl, 50    
int 10h

mov ah, 06h
mov bh, 11h
mov ch, 27     
mov cl, 49   
mov dh, 27    
mov dl, 49   
int 10h

mov ah, 06h
mov bh, 11h
mov ch, 24     
mov cl, 48     
mov dh, 24  
mov dl, 50   
int 10h

mov ah, 06h
mov bh, 11h
mov ch, 25     
mov cl, 51   
mov dh, 25  
mov dl, 51   
int 10h

mov ah, 06h
mov bh, 11h
mov ch, 26     
mov cl, 52     
mov dh, 31    
mov dl, 52   
int 10h

mov ah, 06h
mov bh, 11h
mov ch, 32    
mov cl, 51    
mov dh, 32   
mov dl, 51   
int 10h 

mov ah, 06h
mov bh, 11h
mov ch, 33    
mov cl, 50    
mov dh, 33    
mov dl, 50   
int 10h 

;bottom body
mov ah, 06h
mov bh, 11h
mov ch, 35     
mov cl, 35     
mov dh, 35  
mov dl, 41   
int 10h

mov ah, 06h
mov bh, 11h
mov ch, 34     
mov cl, 31    
mov dh, 34    
mov dl, 34   
int 10h

mov ah, 06h
mov bh, 11h
mov ch, 33    
mov cl, 27    
mov dh, 33  
mov dl, 30  
int 10h

mov ah, 06h
mov bh, 11h
mov ch, 31   
mov cl, 28   
mov dh, 32    
mov dl, 28  
int 10h

mov ah, 06h
mov bh, 11h
mov ch, 28     
mov cl, 26    
mov dh, 32   
mov dl, 26  
int 10h

mov ah, 06h
mov bh, 11h
mov ch, 27     
mov cl, 27    
mov dh, 27  
mov dl, 27 
int 10h 

mov ah, 06h
mov bh, 11h
mov ch, 26     
mov cl, 28    
mov dh, 26   
mov dl, 28  
int 10h





;eyes
mov ah, 06h
mov bh, 0xBB  
mov ch, 17    
mov cl, 26    
mov dh, 17   
mov dl, 27  
int 10h

mov ah, 06h
mov bh, 0xBB  
mov ch, 16    
mov cl, 28  
mov dh, 16   
mov dl, 30 
int 10h

mov ah, 06h
mov bh, 0xBB 
mov ch, 14     
mov cl, 42   
mov dh, 14   
mov dl, 44  
int 10h 

mov ah, 06h
mov bh, 0xBB
mov ch, 15    
mov cl, 45   
mov dh, 15   
mov dl, 46   
int 10h

; mouth
mov ah, 06h
mov bh, 11h 
mov ch, 18    
mov cl, 36   
mov dh, 18  
mov dl, 38 
int 10h

mov ah, 06h
mov bh, 11h  
mov ch, 19     
mov cl, 33    
mov dh, 19   
mov dl, 35  
int 10h

mov ah, 06h
mov bh, 11h  
mov ch, 18    
mov cl, 32   
mov dh, 18  
mov dl, 32  
int 10h

mov ah, 06h
mov bh, 11h  
mov ch, 17  
mov cl, 39    
mov dh, 17   
mov dl, 39  
int 10h


;blush
mov ah, 06h
mov bh, 0xDD
mov ch, 17   
mov cl, 45   
mov dh, 19   
mov dl, 48  
int 10h

mov ah, 06h
mov bh, 0xDD 
mov ch, 18     
mov cl, 44   
mov dh, 18  
mov dl, 49  
int 10h

mov ah, 06h
mov bh, 0xDD  
mov ch, 20    
mov cl, 25    
mov dh, 20   
mov dl, 30  
int 10h

mov ah, 06h
mov bh, 0xDD
mov ch, 19    
mov cl, 26   
mov dh, 21 
mov dl, 28  
int 10h

mov ah, 06h
mov bh, 0xDD 
mov ch, 21    
mov cl, 29   
mov dh, 21   
mov dl, 29  
int 10h  

; heart pixel

mov ah, 06h
mov bh, 0xCC
mov ch, 4    
mov cl, 5    
mov dh, 6   
mov dl, 8  
int 10h

mov ah, 06h
mov bh, 0xCC
mov ch, 5    
mov cl, 9   
mov dh, 7  
mov dl, 13  
int 10h 

mov ah, 06h
mov bh, 0xCC
mov ch, 3    
mov cl, 11   
mov dh, 4   
mov dl, 13 
int 10h

mov ah, 06h
mov bh, 0xCC
mov ch, 4    
mov cl, 14  
mov dh, 6  
mov dl, 14  
int 10h

mov ah, 06h
mov bh, 0xCC
mov ch, 4    
mov cl, 10   
mov dh, 4  
mov dl, 10  
int 10h

mov ah, 06h
mov bh, 0xCC
mov ch, 8    
mov cl, 10    
mov dh, 9   
mov dl, 11  
int 10h

mov ah, 06h
mov bh, 0xCC
mov ch, 8   
mov cl, 12    
mov dh, 8  
mov dl, 12  
int 10h

mov ah, 06h
mov bh, 0xCC
mov ch, 10    
mov cl, 10  
mov dh, 10 
mov dl, 10  
int 10h

mov ah, 06h
mov bh, 0xCC
mov ch, 8    
mov cl, 9  
mov dh, 10  
mov dl, 9  
int 10h

mov ah, 06h
mov bh, 0xCC
mov ch, 7   
mov cl, 7   
mov dh, 8  
mov dl, 8  
int 10h   

mov ah, 06h
mov bh, 0xCC
mov ch, 9     
mov cl, 8   
mov dh, 9  
mov dl, 8  
int 10h

mov ah, 06h
mov bh, 0xCC
mov ch, 7    
mov cl, 6   
mov dh, 7   
mov dl, 6  
int 10h

mov ah, 06h
mov bh, 0xCC
mov ch, 3    
mov cl, 5    
mov dh, 3  
mov dl, 7 
int 10h

mov ah, 06h
mov bh, 44h
mov ch, 4    
mov cl, 4   
mov dh, 6   
mov dl, 4   
int 10h 

mov ah, 06h
mov bh, 44h
mov ch, 7    
mov cl, 5   
mov dh, 7  
mov dl, 5   
int 10h

mov ah, 06h
mov bh, 44h
mov ch, 8    
mov cl, 6   
mov dh, 8  
mov dl, 6  
int 10h 

mov ah, 06h
mov bh, 44h
mov ch, 9    
mov cl, 7   
mov dh, 9   
mov dl, 7 
int 10h

mov ah, 06h
mov bh, 44h
mov ch, 10   
mov cl, 8    
mov dh, 10  
mov dl, 8   
int 10h 

mov ah, 06h
mov bh, 44h
mov ch, 11    
mov cl, 9  
mov dh, 11  
mov dl, 9  
int 10h 

; heart border/highlight
mov ah, 06h
mov bh, 00h
mov ch, 4    
mov cl, 9   
mov dh, 4   
mov dl, 9  
int 10h 

mov ah, 06h
mov bh, 00h
mov ch, 3    
mov cl, 10   
mov dh, 3 
mov dl, 10  
int 10h

mov ah, 06h
mov bh, 00h
mov ch, 3   
mov cl, 8  
mov dh, 3   
mov dl, 8  
int 10h

mov ah, 06h
mov bh, 00h
mov ch, 2     
mov cl, 11   
mov dh, 2 
mov dl, 13   
int 10h

mov ah, 06h
mov bh, 00h
mov ch, 2    
mov cl, 5  
mov dh, 2  
mov dl, 7  
int 10h

mov ah, 06h
mov bh, 00h
mov ch, 3    
mov cl, 4   
mov dh, 3  
mov dl, 4  
int 10h 

mov ah, 06h
mov bh, 00h
mov ch, 3     
mov cl, 14   
mov dh, 3   
mov dl, 14 
int 10h

mov ah, 06h
mov bh, 00h
mov ch, 4    
mov cl, 15   
mov dh, 6  
mov dl, 15  
int 10h

mov ah, 06h
mov bh, 00h
mov ch, 4    
mov cl, 3   
mov dh, 6   
mov dl, 3 
int 10h 

;white highlight
mov ah, 06h
mov bh, 0xFF
mov ch, 4    
mov cl, 12   
mov dh, 4  
mov dl, 12  
int 10h

mov ah, 06h
mov bh, 0xFF
mov ch, 5    
mov cl, 13   
mov dh, 5   
mov dl, 13 
int 10h

;
mov ah, 06h
mov bh, 00h
mov ch, 7    
mov cl, 4    
mov dh, 7   
mov dl, 4  
int 10h

mov ah, 06h
mov bh, 00h
mov ch, 8    
mov cl, 5   
mov dh, 8  
mov dl, 5  
int 10h

mov ah, 06h
mov bh, 00h
mov ch, 9    
mov cl, 6   
mov dh, 9   
mov dl, 6  
int 10h

mov ah, 06h
mov bh, 00h
mov ch, 10    
mov cl, 7   
mov dh, 10  
mov dl, 7 
int 10h

mov ah, 06h
mov bh, 00h
mov ch, 11    
mov cl, 8   
mov dh, 11  
mov dl, 8  
int 10h

mov ah, 06h
mov bh, 00h
mov ch, 12     
mov cl, 9 
mov dh, 12  
mov dl, 9  
int 10h 

mov ah, 06h
mov bh, 00h
mov ch, 11    
mov cl, 10   
mov dh, 11  
mov dl, 10   
int 10h

mov ah, 06h
mov bh, 00h
mov ch, 10    
mov cl, 11   
mov dh, 10 
mov dl, 11  
int 10h

mov ah, 06h
mov bh, 00h
mov ch, 9    
mov cl, 12   
mov dh, 9   
mov dl, 12  
int 10h

mov ah, 06h
mov bh, 00h
mov ch, 8    
mov cl, 13   
mov dh, 8  
mov dl, 13  
int 10h

mov ah, 06h
mov bh, 00h
mov ch, 7    
mov cl, 14   
mov dh, 7  
mov dl, 14 
int 10h 


;star
mov ah, 06h
mov bh, 0xEE
mov ch, 20   
mov cl, 52  
mov dh, 20  
mov dl, 52  
int 10h

mov ah, 06h
mov bh, 0xEE
mov ch, 25    
mov cl, 64   
mov dh, 28  
mov dl, 64  
int 10h

mov ah, 06h
mov bh, 0xEE
mov ch, 26   
mov cl, 63 
mov dh, 26  
mov dl, 65  
int 10h

mov ah, 06h
mov bh, 0xEE
mov ch, 22     
mov cl, 58   
mov dh, 22  
mov dl, 58  
int 10h

mov ah, 06h
mov bh, 0xEE
mov ch, 26    
mov cl, 8   
mov dh, 26  
mov dl, 8  
int 10h

mov ah, 06h
mov bh, 0xEE
mov ch, 29   
mov cl, 12   
mov dh, 29  
mov dl, 12  
int 10h

mov ah, 06h
mov bh, 0xEE
mov ch, 25    
mov cl, 20   
mov dh, 25  
mov dl, 20   
int 10h