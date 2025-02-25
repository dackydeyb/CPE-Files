.model small
.stack
.code

start:
    mov ah, 02h  
    
    
    ; New line
    mov dl, 0Dh  
    int 21h
    mov dl, 0Ah  
    int 21h 
    mov dl, 0Ah  
    int 21h 
    
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
    
    mov dl, 4Eh ; N 
    int 21h
    mov dl, 6Fh ; o 
    int 21h
    mov dl, 76h ; v
    int 21h
    mov dl, 65h ; e
    int 21h        
    mov dl, 6Dh ; m 
    int 21h
    mov dl, 62h ; b 
    int 21h
    mov dl, 65h ; e 
    int 21h
    mov dl, 72h ; r
    int 21h        
    
    mov dl, 20h ; space
    int 21h 
           
    mov dl, 37h ; 7 
    int 21h
    mov dl, 2Ch ; "," 
    int 21h 
    
    mov dl, 20h ; space
    int 21h
    
    mov dl, 32h ; 2
    int 21h
    mov dl, 30h ; 0
    int 21h        
    mov dl, 30h ; 0 
    int 21h  
    mov dl, 33h ; 3 
    int 21h

    ; New line
    mov dl, 0Dh  
    int 21h
    mov dl, 0Ah  
    int 21h
    
    ; e-mail address: poe844ii9@mozmail.com
    mov dl, 65h ; e
    int 21h
    mov dl, 2Dh ; -
    int 21h
    mov dl, 6Dh ; m
    int 21h
    mov dl, 61h ; a
    int 21h
    mov dl, 69h ; i
    int 21h
    mov dl, 6Ch ; l
    int 21h

    mov dl, 20h ; space
    int 21h
    mov dl, 61h ; a
    int 21h
    mov dl, 64h ; d
    int 21h
    mov dl, 64h ; d
    int 21h
    mov dl, 72h ; r
    int 21h
    mov dl, 65h ; e
    int 21h
    mov dl, 73h ; s
    int 21h
    mov dl, 73h ; s
    int 21h
    mov dl, 3Ah ; :
    int 21h
    mov dl, 20h ; space
    int 21h

    ; e-mail address: poe844ii9@mozmail.com
    mov dl, 70h ; p
    int 21h
    mov dl, 6Fh ; o
    int 21h
    mov dl, 65h ; e
    int 21h
    mov dl, 38h ; 8
    int 21h
    mov dl, 34h ; 4
    int 21h
    mov dl, 34h ; 4
    int 21h
    mov dl, 69h ; i
    int 21h
    mov dl, 69h ; i
    int 21h
    mov dl, 39h ; 9
    int 21h
    mov dl, 40h ; @
    int 21h
    mov dl, 6Dh ; m
    int 21h
    mov dl, 6Fh ; o
    int 21h
    mov dl, 7Ah ; z
    int 21h
    mov dl, 6Dh ; m
    int 21h
    mov dl, 61h ; a
    int 21h
    mov dl, 69h ; i
    int 21h
    mov dl, 6Ch ; l
    int 21h
    mov dl, 2Eh ; .
    int 21h
    mov dl, 63h ; c
    int 21h
    mov dl, 6Fh ; o
    int 21h
    mov dl, 6Dh ; m
    int 21h
    
    ; New line
    mov dl, 0Dh  
    int 21h
    mov dl, 0Ah  
    int 21h

    ; "Address: Block 9 Lot 11 Bayberry The Grand Parkplace Village, Aguinaldo Highway, Imus Cavite"

    mov dl, 41h ; A
    int 21h
    mov dl, 64h ; d
    int 21h
    mov dl, 64h ; d
    int 21h
    mov dl, 72h ; r
    int 21h
    mov dl, 65h ; e
    int 21h
    mov dl, 73h ; s
    int 21h
    mov dl, 73h ; s
    int 21h
    mov dl, 3Ah ; :
    int 21h

    mov dl, 20h ; space
    int 21h

    mov dl, 42h ; B
    int 21h
    mov dl, 6Ch ; l
    int 21h
    mov dl, 6Fh ; o
    int 21h
    mov dl, 63h ; c
    int 21h
    mov dl, 6Bh ; k
    int 21h

    mov dl, 20h ; space
    int 21h

    mov dl, 39h ; 9
    int 21h

    mov dl, 20h ; space
    int 21h

    mov dl, 4Ch ; L
    int 21h
    mov dl, 6Fh ; o
    int 21h
    mov dl, 74h ; t
    int 21h

    mov dl, 20h ; space
    int 21h

    mov dl, 31h ; 1
    int 21h
    mov dl, 31h ; 1
    int 21h

    mov dl, 20h ; space
    int 21h

    mov dl, 42h ; B
    int 21h
    mov dl, 61h ; a
    int 21h
    mov dl, 79h ; y
    int 21h
    mov dl, 62h ; b
    int 21h
    mov dl, 65h ; e
    int 21h
    mov dl, 72h ; r
    int 21h
    mov dl, 72h ; r
    int 21h
    mov dl, 79h ; y
    int 21h

    mov dl, 20h ; space
    int 21h

    mov dl, 54h ; T
    int 21h
    mov dl, 68h ; h
    int 21h
    mov dl, 65h ; e
    int 21h

    mov dl, 20h ; space
    int 21h

    mov dl, 47h ; G
    int 21h
    mov dl, 72h ; r
    int 21h
    mov dl, 61h ; a
    int 21h
    mov dl, 6Eh ; n
    int 21h
    mov dl, 64h ; d
    int 21h

    mov dl, 20h ; space
    int 21h 
    mov dl, 0Dh  
    int 21h
    mov dl, 0Ah  
    int 21h
    mov dl, 09h ; tab
    int 21h 
    mov dl, 20h ; space
    int 21h

    mov dl, 50h ; P
    int 21h
    mov dl, 61h ; a
    int 21h
    mov dl, 72h ; r
    int 21h
    mov dl, 6Bh ; k
    int 21h
    mov dl, 70h ; p
    int 21h
    mov dl, 6Ch ; l
    int 21h
    mov dl, 61h ; a
    int 21h
    mov dl, 63h ; c
    int 21h
    mov dl, 65h ; e
    int 21h

    mov dl, 20h ; space
    int 21h

    mov dl, 56h ; V
    int 21h
    mov dl, 69h ; i
    int 21h
    mov dl, 6Ch ; l
    int 21h  
    mov dl, 6Ch ; l
    int 21h
    mov dl, 61h ; a
    int 21h
    mov dl, 67h ; g
    int 21h
    mov dl, 65h ; e
    int 21h
    mov dl, 2Ch ; ,
    int 21h

    mov dl, 20h ; space
    int 21h

    mov dl, 41h ; A
    int 21h
    mov dl, 67h ; g
    int 21h
    mov dl, 75h ; u
    int 21h
    mov dl, 69h ; i
    int 21h
    mov dl, 6Eh ; n
    int 21h
    mov dl, 61h ; a
    int 21h
    mov dl, 6Ch ; l
    int 21h
    mov dl, 64h ; d
    int 21h
    mov dl, 6Fh ; o
    int 21h

    mov dl, 20h ; space
    int 21h

    mov dl, 48h ; H
    int 21h
    mov dl, 69h ; i
    int 21h
    mov dl, 67h ; g
    int 21h
    mov dl, 68h ; h
    int 21h
    mov dl, 77h ; w
    int 21h
    mov dl, 61h ; a
    int 21h
    mov dl, 79h ; y
    int 21h
    mov dl, 2Ch ; ,
    int 21h

     
    mov dl, 20h ; space
    int 21h
    mov dl, 0Dh
    int 21h
    mov dl, 0Ah
    int 21h 
    mov dl, 09h ; tab
    int 21h 
    mov dl, 20h ; space
    int 21h
   

    mov dl, 49h ; I
    int 21h
    mov dl, 6Dh ; m
    int 21h
    mov dl, 75h ; u
    int 21h
    mov dl, 73h ; s
    int 21h

    mov dl, 20h ; space
    int 21h

    mov dl, 43h ; C
    int 21h
    mov dl, 61h ; a
    int 21h
    mov dl, 76h ; v
    int 21h
    mov dl, 69h ; i
    int 21h
    mov dl, 74h ; t
    int 21h
    mov dl, 65h ; e
    int 21h 
    
    ; New line
    mov dl, 0Dh
    int 21h
    mov dl, 0Ah
    int 21h

    ; Province: Imus Cavite
    mov dl, 50h ; P
    int 21h
    mov dl, 72h ; r
    int 21h
    mov dl, 6Fh ; o
    int 21h
    mov dl, 76h ; v
    int 21h
    mov dl, 69h ; i
    int 21h
    mov dl, 6Eh ; n
    int 21h
    mov dl, 63h ; c
    int 21h
    mov dl, 65h ; e
    int 21h
    mov dl, 3Ah ; :
    int 21h

    mov dl, 20h ; space
    int 21h

    mov dl, 49h ; I
    int 21h
    mov dl, 6Dh ; m
    int 21h
    mov dl, 75h ; u
    int 21h
    mov dl, 73h ; s
    int 21h

    mov dl, 20h ; space
    int 21h

    mov dl, 43h ; C
    int 21h
    mov dl, 61h ; a
    int 21h
    mov dl, 76h ; v
    int 21h
    mov dl, 69h ; i
    int 21h
    mov dl, 74h ; t
    int 21h
    mov dl, 65h ; e
    int 21h
    
    ; New line
    mov dl, 0Dh
    int 21h
    mov dl, 0Ah
    int 21h

    ; Contact Number: 0928 989 7123
    mov dl, 43h ; C
    int 21h
    mov dl, 6Fh ; o
    int 21h
    mov dl, 6Eh ; n
    int 21h
    mov dl, 74h ; t
    int 21h
    mov dl, 61h ; a
    int 21h
    mov dl, 63h ; c
    int 21h
    mov dl, 74h ; t
    int 21h 
    
    mov dl, 20h ; space
    int 21h 
    
    mov dl, 4Eh ; N
    int 21h
    mov dl, 75h ; u
    int 21h
    mov dl, 6Dh ; m
    int 21h
    mov dl, 62h ; b
    int 21h
    mov dl, 65h ; e
    int 21h
    mov dl, 72h ; r
    int 21h
    mov dl, 3Ah ; :
    int 21h
    
    mov dl, 20h ; space
    int 21h
    
    mov dl, 30h ; 0
    int 21h
    mov dl, 39h ; 9
    int 21h
    mov dl, 32h ; 2
    int 21h
    mov dl, 38h ; 8
    int 21h 
    
    mov dl, 20h ; space
    int 21h
    
    mov dl, 39h ; 9
    int 21h
    mov dl, 38h ; 8
    int 21h
    mov dl, 39h ; 9
    int 21h 
    
    mov dl, 20h ; space
    int 21h 
    
    mov dl, 37h ; 7
    int 21h
    mov dl, 31h ; 1
    int 21h
    mov dl, 32h ; 2
    int 21h
    mov dl, 33h ; 3
    int 21h

    ; New line
    mov dl, 0Dh
    int 21h
    mov dl, 0Ah
    int 21h

    ; Guardian's Name: Rhea G. Paduada
    mov dl, 47h ; G
    int 21h
    mov dl, 75h ; u
    int 21h
    mov dl, 61h ; a
    int 21h
    mov dl, 72h ; r
    int 21h
    mov dl, 64h ; d
    int 21h
    mov dl, 69h ; i
    int 21h
    mov dl, 61h ; a
    int 21h
    mov dl, 6Eh ; n
    int 21h
    mov dl, 27h ; '
    int 21h
    mov dl, 73h ; s
    int 21h
    
    mov dl, 20h ; space
    int 21h
    
    mov dl, 4Eh ; N
    int 21h
    mov dl, 61h ; a
    int 21h
    mov dl, 6Dh ; m
    int 21h
    mov dl, 65h ; e
    int 21h
    mov dl, 3Ah ; :
    int 21h 
    
    mov dl, 20h ; space
    int 21h
    
    mov dl, 52h ; R
    int 21h
    mov dl, 68h ; h
    int 21h
    mov dl, 65h ; e
    int 21h
    mov dl, 61h ; a
    int 21h
    
    mov dl, 20h ; space
    int 21h
    
    mov dl, 47h ; G
    int 21h
    mov dl, 2Eh ; .
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

    ; Occupation: Government Employee
    mov dl, 4Fh ; O
    int 21h
    mov dl, 63h ; c
    int 21h
    mov dl, 63h ; c
    int 21h
    mov dl, 75h ; u
    int 21h
    mov dl, 70h ; p
    int 21h
    mov dl, 61h ; a
    int 21h
    mov dl, 74h ; t
    int 21h
    mov dl, 69h ; i
    int 21h
    mov dl, 6Fh ; o
    int 21h
    mov dl, 6Eh ; n
    int 21h
    mov dl, 3Ah ; :
    int 21h 
    
    mov dl, 20h ; space
    int 21h 
    
    mov dl, 47h ; G
    int 21h
    mov dl, 6Fh ; o
    int 21h
    mov dl, 76h ; v
    int 21h
    mov dl, 65h ; e
    int 21h
    mov dl, 72h ; r
    int 21h
    mov dl, 6Eh ; n
    int 21h
    mov dl, 6Dh ; m
    int 21h
    mov dl, 65h ; e
    int 21h
    mov dl, 6Eh ; n
    int 21h
    mov dl, 74h ; t
    int 21h 
    
    mov dl, 20h ; space
    int 21h
    
    mov dl, 45h ; E
    int 21h
    mov dl, 6Dh ; m
    int 21h
    mov dl, 70h ; p
    int 21h
    mov dl, 6Ch ; l
    int 21h
    mov dl, 6Fh ; o
    int 21h
    mov dl, 79h ; y
    int 21h
    mov dl, 65h ; e
    int 21h
    mov dl, 65h ; e
    int 21h

    ; Exit program
    mov ah, 4Ch
    int 21h

end start