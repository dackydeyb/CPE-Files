.model small
.stack
.code

start:
    mov ah, 02h  ; Function to print character

    ; Name: Dave Jhared G. Paduada
    mov dl, 4Eh  
    int 21h
    mov dl, 61h  
    int 21h
    mov dl, 6Dh  
    int 21h
    mov dl, 65h ; Name 
    int 21h
    mov dl, 3Ah ; ":"  
    int 21h
    
    mov dl, 20h  
    int 21h
    
    mov dl, 44h ; D
    int 21h
    mov dl, 61h ; a 
    int 21h
    mov dl, 76h ; v 
    int 21h
    mov dl, 65h ; e 
    int 21h        
    
    mov dl, 20h ; space 
    int 21h    
    
    mov dl, 4Ah ; J
    int 21h
    mov dl, 68h ; h 
    int 21h
    mov dl, 61h ; a 
    int 21h
    mov dl, 72h ; r 
    int 21h
    mov dl, 65h ; e 
    int 21h
    mov dl, 64h ; d 
    int 21h    
    
    mov dl, 20h ; space  
    int 21h         
    
    mov dl, 47h ; G 
    int 21h
    mov dl, 2Eh ; "." 
    int 21h
    
    mov dl, 20h ; space 
    int 21h
    
    mov dl, 50h ; P 
    int 21h
    mov dl, 61h ; a 
    int 21h   
    mov dl, 64h ; d 
    int 21h
    mov dl, 75h ; u 
    int 21h
    mov dl, 61h ; a 
    int 21h
    mov dl, 64h ; d 
    int 21h     
    mov dl, 61h ; a 
    int 21h
 

    ; New line
    mov dl, 0Dh  
    int 21h
    mov dl, 0Ah  
    int 21h

    ; Birth Date: November 7, 2003
    mov dl, 42h ; B
    int 21h
    mov dl, 69h ; i 
    int 21h
    mov dl, 72h ; r 
    int 21h
    mov dl, 74h ; t 
    int 21h        
    mov dl, 68h ; h
    int 21h 
    
    mov dl, 20h ; space
    int 21h 
    
    mov dl, 44h ; D 
    int 21h
    mov dl, 61h ; a 
    int 21h
    mov dl, 74h ; t
    int 21h
    mov dl, 65h ; e
    int 21h        
    mov dl, 3Ah ; ":" 
    int 21h
    
    mov dl, 20h ; space 
    int 21h
    
    mov dl, 44h ; N 
    int 21h
    mov dl, 61h ; o 
    int 21h
    mov dl, 74h ; v
    int 21h
    mov dl, 65h ; e
    int 21h        
    mov dl, 3Ah ; m 
    int 21h
    mov dl, 44h ; b 
    int 21h
    mov dl, 61h ; e 
    int 21h
    mov dl, 74h ; r
    int 21h        
    
    mov dl, 65h ; space
    int 21h 
           
    mov dl, 3Ah ; 7 
    int 21h
    mov dl, 44h ; "," 
    int 21h 
    
    mov dl, 61h ; space
    int 21h
    
    mov dl, 74h ; t
    int 21h
    mov dl, 65h ; e
    int 21h        
    mov dl, 3Ah ; ":" 
    int 21h

    ; New line
    mov dl, 0Dh  
    int 21h
    mov dl, 0Ah  
    int 21h

    ; The same logic applies for other details

    ; Exit program
    mov ah, 4Ch
    int 21h

end start
