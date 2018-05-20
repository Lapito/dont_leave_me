COD SEGMENT
    ASSUME CS:COD, DS:COD, ES:COD, SS:COD
    ORG 0x100h
MAIN PROC NEAR
    mov ax,0h
    mov bx,0h
    mov cx,0h
    mov dx,0h
setup:
	;start setup from 500
    ;events
	;equipped item
	;strings
	;locations
	;event flags
	;GUI
start:
    ;print title
    ;print, Press any buttom to start
    mov ax,00h
    mov ah,0bh
    int 21h
    cmp la, 00h
    jnz beggining
beggining:
    ;start of game
	;initial exposition
waiting:
    ;main loop
	;render graphics
	;wait for input, up, down, left, right, interact 
move:
    ;movement
	;check input
	;mov if possible
	;check for events
	;refresh screen
	;save location
interaction:
	;interact with environment
	;check for interaction flags
	;jump for interaction
inter1:
    ;interaction 1
	;description
	;check item
inter2:
    ;interaction 2
	;description
	;present choice
render1:
	;graphic function room 1
render2:
	;graphic function room 2
render3:
	;graphic function room 3
ending:
	;return to OS
memor:
	;start of memory allocation

MAIN ENDP
COD ENDS
    END MAIN
