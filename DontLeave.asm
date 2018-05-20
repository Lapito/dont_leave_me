COD SEGMENT
    ASSUME CS:COD, DS:COD, ES:COD, SS:COD
    ORG 0x100h
MAIN PROC NEAR
    mov ax,0h
    mov bx,0h
    mov cx,0h
    mov dx,0h
memor:
    ;setup
start:
    ;start screen
beggining:
    ;start of game
waiting:
    ;main loop
move:
    ;movement
inter1:
    ;I don't feel so good
inter2:
    ;why is gamora

MAIN ENDP
COD ENDS
    END MAIN
