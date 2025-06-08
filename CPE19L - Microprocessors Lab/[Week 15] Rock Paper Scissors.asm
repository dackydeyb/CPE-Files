.MODEL SMALL
.STACK 100H

.DATA
    MSG_PLAYER1_PROMPT      DB 'Player 1 (P,R,S): $'
    MSG_PLAYER2_PROMPT      DB 'Player 2 (P,R,S): $'
    
    MSG_PLAYER1_WINS        DB 'Player 1 wins!$'
    MSG_PLAYER2_WINS        DB 'Player 2 wins!$'
    MSG_DRAW                DB "It's a draw!$"
    
    MSG_PLAY_AGAIN          DB 'Play Again? (Y/N): $'
    MSG_INVALID_INPUT       DB 'Invalid input. Please enter P, R, or S.$'
    BLANK_LINE              DB '                                        $'

    ; Action messages - these describe the winning interaction
    MSG_P_COVERS_R          DB 'Paper covers Rock!$'
    MSG_R_CRUSHES_S         DB 'Rock crushes Scissors!$'
    MSG_S_CUTS_P            DB 'Scissors cut Paper!$'

    PLAYER1_CHOICE          DB ?
    PLAYER2_CHOICE          DB ?
    WINNER_FLAG             DB ?    ; 0 = DRAW, 1 = P1 WINS, 2 = P2 WINS
    ACTION_MSG_OFFSET       DW ?    ; Offset of the action string (e.g., Paper covers Rock), 0 if draw

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    CALL CLEAR_SCREEN
    CALL DRAW_BORDERS

GAME_ROUND_START:
    CALL CLEAR_DRAWING_AREA
    CALL CLEAR_RESULTS_AREA

    ; Get Player 1 input
GET_P1_INPUT:
    MOV DH, 20
    MOV DL, 3
    CALL SET_CURSOR
    LEA DX, MSG_PLAYER1_PROMPT
    CALL PRINT_STRING
    CALL GET_PLAYER_INPUT
    JNC P1_INPUT_VALID
    ; Invalid input for P1
    MOV DH, 21
    MOV DL, 3
    CALL SET_CURSOR
    LEA DX, MSG_INVALID_INPUT
    CALL PRINT_STRING
    JMP GET_P1_INPUT
P1_INPUT_VALID:
    MOV PLAYER1_CHOICE, AL
    ; Clear invalid message line
    MOV DH, 21
    MOV DL, 3
    CALL SET_CURSOR
    LEA DX, BLANK_LINE
    CALL PRINT_STRING

    ; Get Player 2 input
GET_P2_INPUT:
    MOV DH, 20
    MOV DL, 50
    CALL SET_CURSOR
    LEA DX, MSG_PLAYER2_PROMPT
    CALL PRINT_STRING
    CALL GET_PLAYER_INPUT
    JNC P2_INPUT_VALID
    ; Invalid input for P2
    MOV DH, 21
    MOV DL, 3
    CALL SET_CURSOR
    LEA DX, MSG_INVALID_INPUT
    CALL PRINT_STRING
    JMP GET_P2_INPUT
P2_INPUT_VALID:
    MOV PLAYER2_CHOICE, AL
    ; Clear invalid message line
    MOV DH, 21
    MOV DL, 3
    CALL SET_CURSOR
    LEA DX, BLANK_LINE
    CALL PRINT_STRING
    
    ; Display ASCII art for choices
    CALL DISPLAY_CHOICES_ART

    ; Determine winner
    CALL DETERMINE_WINNER

    ; Display result
    CALL DISPLAY_GAME_RESULT

    ; Ask to play again
ASK_PLAY_AGAIN:
    MOV DH, 23
    MOV DL, 3
    CALL SET_CURSOR
    LEA DX, MSG_PLAY_AGAIN
    CALL PRINT_STRING

    MOV AH, 07H     
    INT 21H

    CMP AL, 'n'
    JE EXIT_GAME
    CMP AL, 'N'
    JE EXIT_GAME
    
    JMP GAME_ROUND_START 

EXIT_GAME:
    MOV AH, 4CH
    INT 21H
MAIN ENDP

PRINT_STRING PROC
    MOV AH, 09H
    INT 21H
    RET
PRINT_STRING ENDP

; Procedure to clear the screen
CLEAR_SCREEN PROC
    MOV AH, 0FH     
    INT 10H
    MOV AH, 00H     
    INT 10H
    RET
CLEAR_SCREEN ENDP

SET_CURSOR PROC
    MOV AH, 02H
    MOV BH, 00H 
    INT 10H
    RET
SET_CURSOR ENDP

GET_PLAYER_INPUT PROC
    MOV AH, 07H     
    INT 21H         
    CMP AL, 'a'
    JL  CHECK_UPPERCASE_VALIDITY
    CMP AL, 'z'
    JG  CHECK_UPPERCASE_VALIDITY
    SUB AL, 20H     

CHECK_UPPERCASE_VALIDITY:
    CMP AL, 'P'
    JE  VALID_INPUT
    CMP AL, 'R'
    JE  VALID_INPUT
    CMP AL, 'S'
    JE  VALID_INPUT

    ; Invalid input
    STC 
    JMP INPUT_DONE

VALID_INPUT:
    CLC 
INPUT_DONE:
    RET
GET_PLAYER_INPUT ENDP
DETERMINE_WINNER PROC
    MOV AL, PLAYER1_CHOICE
    MOV BL, PLAYER2_CHOICE
    
    MOV ACTION_MSG_OFFSET, 0

    CMP AL, BL
    JE  ITS_A_DRAW

    CMP AL, 'P'
    JNE CHECK_P1_ROCK
    CMP BL, 'R'
    JNE P1_PAPER_VS_SCISSOR
    MOV WINNER_FLAG, 1
    LEA AX, MSG_P_COVERS_R
    MOV ACTION_MSG_OFFSET, AX
    JMP DW_DONE

P1_PAPER_VS_SCISSORS: 
    MOV WINNER_FLAG, 2
    LEA AX, MSG_S_CUTS_P 
    MOV ACTION_MSG_OFFSET, AX
    JMP DW_DONE

CHECK_P1_ROCK:
    CMP AL, 'R' 
    JNE CHECK_P1_SCISSORS
    CMP BL, 'S' 
    JNE P1_ROCK_VS_PAPER
    MOV WINNER_FLAG, 1
    LEA AX, MSG_R_CRUSHES_S
    MOV ACTION_MSG_OFFSET, AX
    JMP DW_DONE

P1_ROCK_VS_PAPER:
    MOV WINNER_FLAG, 2
    LEA AX, MSG_P_COVERS_R 
    MOV ACTION_MSG_OFFSET, AX
    JMP DW_DONE

CHECK_P1_SCISSORS:
    
    CMP BL, 'P' 
    JNE P1_SCISSORS_VS_ROCK
    MOV WINNER_FLAG, 1
    LEA AX, MSG_S_CUTS_P
    MOV ACTION_MSG_OFFSET, AX
    JMP DW_DONE

P1_SCISSORS_VS_ROCK: 
    MOV WINNER_FLAG, 2
    LEA AX, MSG_R_CRUSHES_S 
    MOV ACTION_MSG_OFFSET, AX
    JMP DW_DONE

ITS_A_DRAW:
    MOV WINNER_FLAG, 0
DW_DONE:
    RET
DETERMINE_WINNER ENDP
DISPLAY_GAME_RESULT PROC
    MOV AL, WINNER_FLAG
    CMP AL, 0
    JE  DISPLAY_DRAW_MSG
    CMP AL, 1
    JE  DISPLAY_P1_WINS_MSG
    MOV DH, 15
    MOV DL, 30
    CALL SET_CURSOR
    LEA DX, MSG_PLAYER2_WINS
    CALL PRINT_STRING
    JMP DISPLAY_ACTION_DETAILS

DISPLAY_P1_WINS_MSG:
    MOV DH, 15
    MOV DL, 30
    CALL SET_CURSOR
    LEA DX, MSG_PLAYER1_WINS
    CALL PRINT_STRING
    JMP DISPLAY_ACTION_DETAILS

DISPLAY_DRAW_MSG:
    MOV DH, 15
    MOV DL, 30
    CALL SET_CURSOR
    LEA DX, MSG_DRAW
    CALL PRINT_STRING
    JMP DGR_EXIT

DISPLAY_ACTION_DETAILS:
    MOV DX, ACTION_MSG_OFFSET
    CMP DX, 0 
    JE DGR_EXIT 
    
    PUSH DX    
    MOV DH, 16
    MOV DL, 30
    CALL SET_CURSOR
    POP DX     
    
    CALL PRINT_STRING

DGR_EXIT:
    RET
DISPLAY_GAME_RESULT ENDP

CLEAR_DRAWING_AREA PROC
    MOV AH, 06H  
    MOV AL, 0     
    MOV BH, 0    
    MOV CH, 3    
    MOV CL, 2    
    MOV DH, 12   
    MOV DL, 78  
    INT 10H
    RET
CLEAR_DRAWING_AREA ENDP

CLEAR_RESULTS_AREA PROC
    MOV DH, 15
    MOV DL, 30
    CALL SET_CURSOR
    LEA DX, BLANK_LINE
    CALL PRINT_STRING
    MOV DH, 16
    MOV DL, 30
    CALL SET_CURSOR
    LEA DX, BLANK_LINE
    CALL PRINT_STRING
    MOV DH, 23
    MOV DL, 3
    CALL SET_CURSOR
    LEA DX, BLANK_LINE
    CALL PRINT_STRING
    RET
CLEAR_RESULTS_AREA ENDP

; --- Drawing Procedures ---
DISPLAY_CHOICES_ART PROC
    ; Player 1
    MOV AL, PLAYER1_CHOICE
    CMP AL, 'R'
    JE DRAW_R1
    CMP AL, 'P'
    JE DRAW_P1
    CMP AL, 'S'
    JE DRAW_S1
    JMP P1_DRAW_DONE
DRAW_R1:
    CALL DRAW_ROCK_P1
    JMP P1_DRAW_DONE
DRAW_P1:
    CALL DRAW_PAPER_P1
    JMP P1_DRAW_DONE
DRAW_S1:
    CALL DRAW_SCISSORS_P1
P1_DRAW_DONE:

    ; Player 2
    MOV AL, PLAYER2_CHOICE
    CMP AL, 'R'
    JE DRAW_R2
    CMP AL, 'P'
    JE DRAW_P2
    CMP AL, 'S'
    JE DRAW_S2
    JMP P2_DRAW_DONE
DRAW_R2:
    CALL DRAW_ROCK_P2
    JMP P2_DRAW_DONE
DRAW_P2:
    CALL DRAW_PAPER_P2
    JMP P2_DRAW_DONE
DRAW_S2:
    CALL DRAW_SCISSORS_P2
P2_DRAW_DONE:

    RET
DISPLAY_CHOICES_ART ENDP

DRAW_BORDERS PROC
    ; Top border
    MOV AH, 06H
    MOV BH, 0FFH
    MOV CH, 0
    MOV CL, 0
    MOV DH, 0
    MOV DL, 79
    INT 10H
    ; Left border
    MOV AH, 06H
    MOV BH, 0CCH
    MOV CH, 1
    MOV CL, 0
    MOV DH, 24
    MOV DL, 0
    INT 10H 
    ; Bottom border
    MOV AH, 06H
    MOV BH, 0DDH
    MOV CH, 24
    MOV CL, 1
    MOV DH, 24
    MOV DL, 79
    INT 10H
    ; Right border
    MOV AH, 06H
    MOV BH, 0EEH
    MOV CH, 0
    MOV CL, 79
    MOV DH, 23
    MOV DL, 79
    INT 10H
    RET
DRAW_BORDERS ENDP

DRAW_SCISSORS_P1 PROC
    MOV AH, 06H
    MOV BH, 0FFH
    MOV CH, 3
    MOV CL, 11
    MOV DH, 6
    MOV DL, 11
    INT 10H
    MOV AH, 06H
    MOV BH, 0FFH
    MOV CH, 3
    MOV CL, 15
    MOV DH, 6
    MOV DL, 15
    INT 10H
    MOV AH, 06H
    MOV BH, 0FFH
    MOV CH, 7
    MOV CL, 14
    MOV DH, 7
    MOV DL, 14
    INT 10H
    MOV AH, 06H
    MOV BH, 0FFH
    MOV CH, 7
    MOV CL, 12
    MOV DH, 7
    MOV DL, 12
    INT 10H
    MOV AH, 06H
    MOV BH, 0FFH
    MOV CH, 8
    MOV CL, 13
    MOV DH, 9
    MOV DL, 13
    INT 10H
    MOV AH, 06H
    MOV BH, 0FFH
    MOV CH, 10
    MOV CL, 11
    MOV DH, 11
    MOV DL, 12
    INT 10H 
    MOV AH, 06H
    MOV BH, 0FFH
    MOV CH, 10
    MOV CL, 14
    MOV DH, 11
    MOV DL, 15
    INT 10H
    RET
DRAW_SCISSORS_P1 ENDP

DRAW_SCISSORS_P2 PROC
    MOV AH, 06H
    MOV BH, 0FFH
    MOV CH, 3
    MOV CL, 59
    MOV DH, 6
    MOV DL, 59
    INT 10H
    MOV AH, 06H
    MOV BH, 0FFH
    MOV CH, 3
    MOV CL, 63
    MOV DH, 6
    MOV DL, 63
    INT 10H
    MOV AH, 06H
    MOV BH, 0FFH
    MOV CH, 7
    MOV CL, 62
    MOV DH, 7
    MOV DL, 62
    INT 10H
    MOV AH, 06H
    MOV BH, 0FFH
    MOV CH, 7
    MOV CL, 60
    MOV DH, 7
    MOV DL, 60
    INT 10H
    MOV AH, 06H
    MOV BH, 0FFH
    MOV CH, 8
    MOV CL, 61
    MOV DH, 9
    MOV DL, 61
    INT 10H
    MOV AH, 06H
    MOV BH, 0FFH
    MOV CH, 10
    MOV CL, 59
    MOV DH, 11
    MOV DL, 60
    INT 10H 
    MOV AH, 06H
    MOV BH, 0FFH
    MOV CH, 10
    MOV CL, 62
    MOV DH, 11
    MOV DL, 63
    INT 10H
    RET
DRAW_SCISSORS_P2 ENDP

DRAW_PAPER_P1 PROC
    MOV AH, 06H
    MOV BH, 0FFH
    MOV CH, 3
    MOV CL, 11
    MOV DH, 11
    MOV DL, 11
    INT 10H
    MOV AH, 06H
    MOV BH, 0FFH
    MOV CH, 3
    MOV CL, 12
    MOV DH, 3
    MOV DL, 16
    INT 10H
    MOV AH, 06H
    MOV BH, 0FFH
    MOV CH, 4
    MOV CL, 17
    MOV DH, 4
    MOV DL, 17
    INT 10H 
    MOV AH, 06H
    MOV BH, 0FFH
    MOV CH, 5
    MOV CL, 18
    MOV DH, 5
    MOV DL, 18
    INT 10H
    MOV AH, 06H
    MOV BH, 0FFH
    MOV CH, 12
    MOV CL, 12
    MOV DH, 12
    MOV DL, 18
    INT 10H
    MOV AH, 06H
    MOV BH, 0FFH
    MOV CH, 6
    MOV CL, 19
    MOV DH, 11
    MOV DL, 19
    INT 10H
    RET
DRAW_PAPER_P1 ENDP

DRAW_PAPER_P2 PROC
    MOV AH, 06H
    MOV BH, 0FFH
    MOV CH, 3
    MOV CL, 61
    MOV DH, 11
    MOV DL, 61
    INT 10H
    MOV AH, 06H
    MOV BH, 0FFH
    MOV CH, 3
    MOV CL, 62
    MOV DH, 3
    MOV DL, 66
    INT 10H
    MOV AH, 06H
    MOV BH, 0FFH
    MOV CH, 4
    MOV CL, 67
    MOV DH, 4
    MOV DL, 67
    INT 10H 
    MOV AH, 06H
    MOV BH, 0FFH
    MOV CH, 5
    MOV CL, 68
    MOV DH, 5
    MOV DL, 68
    INT 10H
    MOV AH, 06H
    MOV BH, 0FFH
    MOV CH, 12
    MOV CL, 62
    MOV DH, 12
    MOV DL, 68
    INT 10H
    MOV AH, 06H
    MOV BH, 0FFH
    MOV CH, 6
    MOV CL, 69
    MOV DH, 11
    MOV DL, 69
    INT 10H
    RET
DRAW_PAPER_P2 ENDP

DRAW_ROCK_P1 PROC
    MOV AH, 06H
    MOV BH, 0FFH
    MOV CH, 3
    MOV CL, 15
    MOV DH, 3
    MOV DL, 18
    INT 10H
    MOV AH, 06H
    MOV BH, 0FFH
    MOV CH, 4
    MOV CL, 19
    MOV DH, 4
    MOV DL, 20
    INT 10H
    MOV AH, 06H
    MOV BH, 0FFH
    MOV CH, 5
    MOV CL, 21
    MOV DH, 9
    MOV DL, 21
    INT 10H 
    MOV AH, 06H
    MOV BH, 0FFH
    MOV CH, 10
    MOV CL, 20
    MOV DH, 10
    MOV DL, 20
    INT 10H 
    MOV AH, 06H
    MOV BH, 0FFH
    MOV CH, 11
    MOV CL, 13
    MOV DH, 11
    MOV DL, 19
    INT 10H 
    MOV AH, 06H
    MOV BH, 0FFH
    MOV CH, 10
    MOV CL, 12
    MOV DH, 10
    MOV DL, 12
    INT 10H
    MOV AH, 06H
    MOV BH, 0FFH
    MOV CH, 7
    MOV CL, 11
    MOV DH, 9
    MOV DL, 11
    INT 10H
    MOV AH, 06H
    MOV BH, 0FFH
    MOV CH, 6
    MOV CL, 12
    MOV DH, 6
    MOV DL, 12
    INT 10H
    MOV AH, 06H
    MOV BH, 0FFH
    MOV CH, 5
    MOV CL, 13
    MOV DH, 5
    MOV DL, 13
    INT 10H 
    MOV AH, 06H
    MOV BH, 0FFH
    MOV CH, 4
    MOV CL, 14
    MOV DH, 4
    MOV DL, 14
    INT 10H
    RET
DRAW_ROCK_P1 ENDP

DRAW_ROCK_P2 PROC
    MOV AH, 06H
    MOV BH, 0FFH
    MOV CH, 3
    MOV CL, 65
    MOV DH, 3
    MOV DL, 68
    INT 10H
    MOV AH, 06H
    MOV BH, 0FFH
    MOV CH, 4
    MOV CL, 69
    MOV DH, 4
    MOV DL, 70
    INT 10H
    MOV AH, 06H
    MOV BH, 0FFH
    MOV CH, 5
    MOV CL, 71
    MOV DH, 9
    MOV DL, 71
    INT 10H 
    MOV AH, 06H
    MOV BH, 0FFH
    MOV CH, 10
    MOV CL, 70
    MOV DH, 10
    MOV DL, 70
    INT 10H 
    MOV AH, 06H
    MOV BH, 0FFH
    MOV CH, 11
    MOV CL, 63
    MOV DH, 11
    MOV DL, 69
    INT 10H 
    MOV AH, 06H
    MOV BH, 0FFH
    MOV CH, 10
    MOV CL, 62
    MOV DH, 10
    MOV DL, 62
    INT 10H
    MOV AH, 06H
    MOV BH, 0FFH
    MOV CH, 7
    MOV CL, 61
    MOV DH, 9
    MOV DL, 61
    INT 10H
    MOV AH, 06H
    MOV BH, 0FFH
    MOV CH, 6
    MOV CL, 62
    MOV DH, 6
    MOV DL, 62
    INT 10H
    MOV AH, 06H
    MOV BH, 0FFH
    MOV CH, 5
    MOV CL, 63
    MOV DH, 5
    MOV DL, 63
    INT 10H 
    MOV AH, 06H
    MOV BH, 0FFH
    MOV CH, 4
    MOV CL, 64
    MOV DH, 4
    MOV DL, 64
    INT 10H
    RET
DRAW_ROCK_P2 ENDP

END MAIN
