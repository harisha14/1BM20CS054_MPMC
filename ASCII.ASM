;PROGRAM::PROGRAM TO READ ALPHANUMERIC CHARACTER AND DISPLAY ITS EQUIVALENT ASCII
;CODE AT THE CENTRE OF THE SCREEN

.MODEL SMALL

 DISPLAY MACRO MSG
         LEA DX, MSG
         MOV AH, 09H
         INT 21H

 ENDM

 ;MACRO TO DISPLAY A CHARACTER.
DISPCHAR MACRO
          MOV AH, 02H
          INT 21H

 ENDM

.DATA
MSG1 DB 0DH, 0AH, "ENTER AN ALPHANUMERIC CHARACTER :: $"

.CODE
START : MOV AX, @DATA
        MOV DS, AX
        DISPLAY MSG1
        MOV AH, 01H
        INT 21H
        PUSH AX
        ; SET MODE AND CLEAR THE SCREEN
        ; ROW =25 AND COLUMN =00
        MOV AH, 00H
        MOV AL, 03H
       INT 10H
        ; MOVE THE CURSOR TO THE MID POINT OF THE SCREEB
        MOV AH, 02H
        MOV BH, 00H            ; PAGE NUMBER
        MOV DH, 12D            ; ROW VALUE
        MOV DL, 40D            ; COLUMN VALUE
         INT 10H
         POP AX                ; RESTORE THE CHARACTER.
         AAM
         PUSH AX
         MOV AL, AH
         XOR AH, AH
         AAM
         ADD AX, 3030H
         MOV DL, AH
         PUSH AX
         DISPCHAR              ; DISPLAY THE ASCII VALUE
         POP AX
         MOV DL, AL
         DISPCHAR
         POP AX
         ADD AL, 30H
         MOV DL, AL
         DISPCHAR
         ;WAIT FOR THE USER TO PRESS ANY KEY
         MOV AH, 07H
         INT 21H
         ;FINISH ...JOB OVER
         JMP FINAL
;PROCEDURE ENDS HERE

FINAL :MOV AH,4CH
       INT 21H

END START
