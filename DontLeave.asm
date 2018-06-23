COD SEGMENT
	ASSUME CS:COD, DS:COD, ES:COD, SS:COD
	ORG 100h

	;macro print string
	PRINTE MACRO MSG
		MOV DH,8
		MOV DL,0
		call mudarcursor
		call astvermelho
		lea dx,MSG
		mov ah,09h
		int 21h
		mov ax,00h
		mov ah,07h
		int 21h
		call atualizamapa
	ENDM

MAIN PROC NEAR
;clear registers and initialize screen
setup:
	mov ax,0h
	mov bx,0h
	mov cx,0h
	mov dx,0h

	mov ah, 0H
	mov al, 02h
	int 10H
;print game title
start:
	;print title
	call pula_linha
	lea dx,title_a
	mov ah,09h
	int 21h
	call pula_linha
	lea dx,title_b
	mov ah,09h
	int 21h
	call pula_linha
	lea dx,title_c
	mov ah,09h
	int 21h
	call pula_linha
	lea dx,title_d
	mov ah,09h
	int 21h
	call pula_linha
	lea dx,title_e
	mov ah,09h
	int 21h
	call pula_linha
	lea dx,title_f
	mov ah,09h
	int 21h
	call pula_linha
	lea dx,title_g
	mov ah,09h
	int 21h
	call pula_linha
	lea dx,prompt
	mov ah,09h
	int 21h
	;print, Press any button to start
	mov ax,00h
	mov ah,07h
	int 21h
;print history and tutorial
beggining:
	;start of game
	;initial exposition
	call clear

	call pula_linha
	call astvermelho
	lea dx,intro1
	mov ah,09h
	int 21h
	call pula_linha
	call astvermelho
	lea dx,intro2
	mov ah,09h
	int 21h
	call pula_linha
	call pula_linha
	lea dx,prompt
	mov ah,09h
	int 21h
	;print, Press any button to start
	mov ax,00h
	mov ah,07h
	int 21h

	call clear
	call pula_linha
	call astvermelho
	lea dx,tutorial1
	mov ah,09h
	int 21h
	call pula_linha
	call astvermelho
	lea dx,tutorial2
	mov ah,09h
	int 21h
	call pula_linha
	call astvermelho
	lea dx,tutorial3
	mov ah,09h
	int 21h
	call pula_linha
	call pula_linha
	lea dx,prompt
	mov ah,09h
	int 21h
	;print, Press any button to start
	mov ax,00h
	mov ah,07h
	int 21h
	call render1
waiting:
	;main loop
	;render
	;check input
	MOV DH,Y
	MOV DL,X
	call mudarcursor

	call keyboard

	jmp waiting
;|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
render1:
	;graphic function room 1
	call clear
	call pula_linha
	lea dx,sala1a
	mov ah,09h
	int 21h
	call pula_linha
	lea dx,sala1b
	mov ah,09h
	int 21h
	call pula_linha
	lea dx,sala1c
	mov ah,09h
	int 21h
	call pula_linha
	lea dx,sala1d
	mov ah,09h
	int 21h
	call pula_linha
	lea dx,sala1e
	mov ah,09h
	int 21h
	call pula_linha
	lea dx,sala1f
	mov ah,09h
	int 21h
	call pula_linha
	ret
render2:
	;graphic function room 2
	call clear
	call pula_linha
	lea dx,sala2a
	mov ah,09h
	int 21h
	call pula_linha
	lea dx,sala2b
	mov ah,09h
	int 21h
	call pula_linha
	lea dx,sala2c
	mov ah,09h
	int 21h
	call pula_linha
	lea dx,sala2d
	mov ah,09h
	int 21h
	call pula_linha
	lea dx,sala2e
	mov ah,09h
	int 21h
	call pula_linha
	lea dx,sala2f
	mov ah,09h
	int 21h
	call pula_linha
	ret
;|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
keyboard:;check input
	call readchar
	cmp al,'w'
	je moveupa
	cmp al,'a'
	je movelefta
	cmp al,'s'
	je movedowna
	cmp al,'d'
	je moverighta
	cmp al,'f'
	je interactchecka
	cmp al,1BH
	je endg

moveupa:
	jmp moveup
movelefta:
	jmp moveleft
movedowna:
	jmp movedown
moverighta:
	jmp moveright
interactchecka:
	jmp interactcheck
endg:
	jmp finish
retkey: ;plays note on wrong interaction
	MOV NOTAH,91H
	MOV NOTAL,21H
	CALL TOCANOTA
	ret
moveup:;if w
	;checks if the player is out of bounds
	dec Y
	cmp Y,YSUP
	jz nmoverys
	jmp waiting
movedown:;if s
	;checks if the player is out of bounds
	inc Y
	cmp Y,YINF
	jz nmoveryi
	jmp waiting
moveright:;if d
	;checks if the player is out of bounds
	inc X
	cmp X,XSUP
	jz nmoverxs
	jmp waiting
moveleft:;if a
	;checks if the player is out of bounds
	dec X
	cmp X,XINF
	jz nmoverxi
	jmp waiting

nmoverys: ;player is out of bounds
	inc Y
	call cantmove
	jmp waiting
nmoveryi: ;player is out of bounds
	dec Y
	call cantmove
	jmp waiting
nmoverxs: ;player is out of bounds
	dec X
	call cantmove
	jmp waiting
nmoverxi: ;player is out of bounds
	inc X
	call cantmove
	jmp waiting
cantmove: ;plays note to alert player
	MOV NOTAH,45h
	MOV NOTAL,60h
	call TOCANOTA
	ret
;|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||	
interactcheck:;if f
	cmp room,1h ;check if player is on room 1
	je room1inta
	cmp room,2h ;check if player is on room 1
	je room2inta
	;jump for interaction check
room1inta:
	jmp room1int
room2inta:
	jmp room2int
;|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
room1int: ;check which and if an event exists
	cmp X,EVENT1X
	je l1
	cmp X,EVENT2X
	je l2
	cmp X,ROOM12X
	je l3
	jmp retkey
;if the event exists, jump to the interaction
l1:
	cmp Y,EVENT1Y
	je event1
	jmp retkey
l2:
	cmp Y,EVENT2Y
	je event2
	jmp retkey
l3:
	cmp Y,ROOM12Y
	je event3
	jmp retkey
event1:
	call inter1
	ret
event2:
	call inter2
	ret
event3:
	call inter3
	ret
;|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
room2int:
	cmp X,EVENT4X
	je l4
	cmp X,EVENT5X
	je l5
	cmp X,ROOM21X
	je l6
	jmp retkey
l4:
	cmp Y,EVENT4Y
	je event4
	jmp retkey
l5:
	cmp Y,EVENT5Y
	je event5
	jmp retkey
l6:
	cmp Y,ROOM21Y
	je event6
	jmp retkey
event4:
	call inter4
	ret
event5:
	call inter5
	ret
event6:
	call inter6
	ret
;||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
pula_linha:
	; PUSHA
	MOV AH,06h
	MOV DL,LF
	INT 21h
	MOV AH,06h
	MOV DL,CR
	INT 21h
	RET
readchar:;read character
	mov ah,00h
	int 16h
	ret
clear:;clear screen
	mov ah,0h
	mov al,2h
	int 10H
	mov ch, 0h
	mov cl, 7h
	mov ah, 1h
	int 10h
	ret
mudarcursor: ;change cursor
	MOV BH,0H
	MOV AH,02H
	INT 10H
	ret

atualizamapa: ;renders corresponding room
	call clear
	cmp room,1h
	jz atualizar1
	call render2
	ret
atualizar1:
	call render1
	ret

inter1:
	cmp ITEM2,2h ;checks if the player has 2 fuses
	jz finisha
	cmp ITEM2,1h
	jz umfus
	jmp naofus

finisha: ;if it has, finishes the game
	PRINTE line3
	PRINTE line9
	jmp finish
umfus:
	PRINTE line2
	ret
naofus:
	PRINTE line1
	PRINTE line1b
	PRINTE line1c
	PRINTE journal1a
	ret

inter2:
	cmp ITEM1,1h ;checks if the player has a crowbar
	jz abrearmario
	PRINTE line4
	ret
abrearmario:
	cmp EVENT2FLAG,1H
	jz continuarjogoa
	PRINTE line5
	PRINTE line6
	PRINTE journal3a
	mov EVENT2FLAG,1H
	INC ITEM2
	ret

continuarjogoa: ;emits the "wrong" sound if the player has already gotten the item
	MOV NOTAH,91H
	MOV NOTAL,21H
	CALL TOCANOTA
	ret

inter3: ;changes room if the player in on the door
	mov room,2h
	call render2
	mov X,ROOM21X
	mov Y,ROOM21Y
	jmp waiting

inter4:
	cmp EVENT4FLAG,1H
	jz continuarjogob
	mov EVENT4FLAG,1H
	PRINTE line8
	PRINTE journal2a
	inc ITEM2 ;get fuse
	ret

continuarjogob: ;emits the "wrong" sound if the player has already gotten the item
	MOV NOTAH,91H
	MOV NOTAL,21H
	CALL TOCANOTA
	ret

inter5:
	cmp EVENT5FLAG,1H
	jz continuarjogob
	mov EVENT5FLAG,1H
	PRINTE line7
	inc ITEM1 ;get crowbar
	ret
inter6: ;changes room if the player in on the door
	mov room,1h
	call render1
	mov X,ROOM12X
	mov Y,ROOM12Y
	jmp waiting


TOCANOTA:
    MOV AL, 182
    OUT 43h, AL ;prepara a nota
    MOV AH, NOTAH
    MOV AL, NOTAL
    OUT 42h, AL ; manda byte menos significativo
    MOV AL, AH
    OUT 42h, AL ; manda byte mais significativo
    IN AL, 61h ; verifica qual o valor est? na porta 61h
    OR AL, 00000011b ; "seta" os dois bits menos significativos
    OUT 61h, AL ; atualiza o valor na porta 61h ... reproduz
    MOV BX, 1h ; determina a dura??o do som
DURA:
    MOV CX, 0FFFFh
DURAC:
    DEC CX
    JNE DURAC
    DEC BX
    JNE DURA
    IN AL, 61h ; verifica qual o valor est? na porta 61h
    AND AL, 11111100b ; "zera" os dois bits menos significativos
    OUT 61h, AL ; atualiza valor na porta 61h, fim reprodu??o
    RET

astvermelho: ;print red asterisc
	MOV BL,04h;atributos do caractere
    MOV AL,'*';caractere a ser escrito
    MOV AH,09h;
    MOV CX,1h;n?mero de vezes a escrever o caractere
    INT 10h
    MOV BH,0h
    MOV AH,03h
    INT 10h
    INC DL
    MOV AH,02h
    INT 10h
    ret

finish: ;end game
	call clear
	MOV AH,4CH
	int 21H

MAIN ENDP
	tutorial1 db " Use the 'wasd' keys to move and the 'f' key$"
	tutorial2 db " to interact with the 'x's and doors.$"
	tutorial3 db " To quit the game press ESC$"
	title_a db "  ______            _ _     _                                       $"
	title_b db "  |  _  \          ( ) |   | |                                      $"
	title_c db "  | | | |___  _ __ |/| |_  | | ___  __ ___   _____   _ __ ___   ___ $"
	title_d db "  | | | / _ \| '_ \  | __| | |/ _ \/ _` \ \ / / _ \ | '_ ` _ \ / _ \$"
	title_e db "  | |/ / (_) | | | | | |_  | |  __/ (_| |\ V /  __/ | | | | | |  __/$"
	title_f db "  |___/ \___/|_| |_|  \__| |_|\___|\__,_| \_/ \___| |_| |_| |_|\___|$"
	title_g db "                                                                    $"
	prompt db " Press any button to continue...$"
	intro1 db " You wake up in a room. You don't know how you got here.$"
	intro2 db " ESCAPE.$"
	sala1a db "+----------------------------+$"
	sala1b db " /                       x   |$"
	sala1c db "|                            |$"
	sala1d db "|                            |$"
	sala1e db "|  x                         |$"
	sala1f db "+----------------------------+$"
	sala2a db "+----------------------------+$"
	sala2b db "|   x                       \ $"
	sala2c db "|                            |$"
	sala2d db "|                            |$"
	sala2e db "|  x                         |$"
	sala2f db "+----------------------------+$"
	exposition db " $"
	line1 db " A fuse box. Maybe it opens the front door?$"
	line1b db " Looks like I need two fuses to activate it.$"
	line1c db " Inside it was a journal page.$"
	line2 db " I need one more fuse.$"
	line3 db " I have enough fuses. I proceed to install them.$"
	line4 db " It's locked, I'm gonna need a tool to open it$"
	line5 db " I managed to open it. Inside was a fuse.$"
	line6 db " There was also a decayed corpse clutching a journal page.$"
	line7 db " I found a crowbar. Perhaps I could open something$"
	line8 db " I found a fuse. Beside it lays a journal page$"
	line9 db " I had to leave. I had no choice right? Right?$"
	journal1a db " Entry 1: I can't stand this anymore.",LF,CR
	journal1b db "   It's been barely a month after the bombs dropped,",LF,CR
	journal1c db "   and I'm already sick of staying in this damned bunker.",LF,CR
	journal1d db "   Only the company of my wife keeps me sane.$"
	journal2a db " Entry 56: The food is running out.",LF,CR
	journal2b db "   I already lost count of how many months",LF,CR
	journal2c db "   It's been since we've been stuck here.",LF,CR
	journal2d db "   All i know is that our supplies are running out.$"
	journal3a db " Entry 66: Don't leave me.",LF,CR
	journal3b db "   There's no food for the both of us anymore and",LF,CR
	journal3c db "   Evelyn is deadset on leaving.",LF,CR
	journal3d db "   She can't leave. Not now. Not ever. She'll have to kill me for that.$"
	
	LF equ 0Ah ;line feed
	CR equ 0Dh ;carriage return
	Y db 04h ;player Y pos
	X db 0EH ;player X pos
	ITEM1 db 0h ;crowbar
	ITEM2 db 0h ;fuse
	XSUP equ 1Dh ;room upper X limit
	XINF equ 0h ;room lower X limit
	YSUP equ 1H ;room upper Y limit
	YINF equ 6h ;room lower Y limit
	NOTAH db 0H ;higher byte note
	NOTAL db 0H ;lower byte note
	;doors
	ROOM12X equ 1H
	ROOM12Y equ 2H
	ROOM21X equ 1CH 
	ROOM21Y equ 2H
	;room 1
	EVENT1X equ 19H
	EVENT1Y equ 2H
	EVENT2X equ 3H
	EVENT2Y equ 5H
	EVENT2FLAG db 0H
	;room 2
	EVENT4X equ 4H
	EVENT4Y equ 2H
	EVENT5X equ 3H
	EVENT5Y equ 5H
	EVENT4FLAG db 0H
	EVENT5FLAG db 0H
	room db 1h
COD ENDS
	END MAIN
