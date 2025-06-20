include irvine32.inc
include macros.inc
.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data
	gametitle1          db " ______ _______ ______ ___ ___ _______ ____ __ ", 0
	gametitle2          db "|   __ \   _   |      |   |   |   _   |    |  |", 0
	gametitle3          db "|    __/       |   ---|       |       |       |", 0
	gametitle4          db "|___|  |___|___|______|__|_|__|___|___|__|____|", 0

    ground              db "==============================================================================", 0
    ground1             db "||", 0
    ground2             db "||", 0
    
    temp                db ?

    lives               dd 3
    opt                 dd ?
    charIn              db ?

    level               dd 1
    score               dd 0

    player              db "C", 0
    ghost               db "G", 0

    tempx               db ?
    tempy               db ?

    playerx             db 5
    playery             db 17

    ghost1x             db ?
    ghost1y             db ?

    ghost2x             db ?
    ghost2y             db ?

    ghost3x             db ?
    ghost3y             db ?

    ghosttemp           db ?

    movCounter          db 1
    randomSeed          db 1

    playername          db 25 dup (?)

    level1title0        db "........................................................", 0
    level1title1        db ".##......######..##..##..######..##................##...", 0
    level1title2        db ".##......##......##..##..##......##...............###...", 0
    level1title3        db ".##......####....##..##..####....##................##...", 0
    level1title4        db ".##......##.......####...##......##................##...", 0
    level1title5        db ".######..######....##....######..######..........######.", 0
    level1title6        db "........................................................", 0

    level2title0        db "........................................................", 0
    level2title1        db ".##......######..##..##..######..##...............####..", 0
    level2title2        db ".##......##......##..##..##......##..................##.", 0
    level2title3        db ".##......####....##..##..####....##...............####..", 0
    level2title4        db ".##......##.......####...##......##..............##.....", 0
    level2title5        db ".######..######....##....######..######..........######.", 0
    level2title6        db "........................................................", 0

    level3title0        db "........................................................", 0
    level3title1        db ".##......######..##..##..######..##..............######.", 0
    level3title2        db ".##......##......##..##..##......##.................##..", 0
    level3title3        db ".##......####....##..##..####....##................###..", 0
    level3title4        db ".##......##.......####...##......##..................##.", 0
    level3title5        db ".######..######....##....######..######..........#####..", 0
    level3title6        db "........................................................", 0

    level1obs1          db  "__", 0
    level1obs2          db "/_ |", 0
    level1obs3          db  "| |", 0
    level1obs4          db  "| |", 0
    level1obs5          db  "| |", 0
    level1obs6          db  "| |", 0
    level1obs7          db  "|_|", 0

    level7obs1          db  "______", 0
    level7obs2          db "|____  |", 0
    level7obs3          db     "/ /", 0
    level7obs4          db    "/ /", 0
    level7obs5          db   "/ /", 0
    level7obs6          db  "/ /", 0
    level7obs7          db "/_/", 0

    level5obs1          db  "_____", 0
    level5obs2          db "| ____|", 0
    level5obs3          db "| |__", 0
    level5obs4          db "|___ \", 0
    level5obs5          db  "___) |", 0
    level5obs6          db "|     |", 0
    level5obs7          db "|____/", 0

    level9obs1          db   "___", 0
    level9obs2          db  "/ _ \", 0
    level9obs3          db "| (_) |", 0
    level9obs4          db  "\__, |", 0
    level9obs5          db    "/ /", 0
    level9obs6          db   "/ /", 0
    level9obs7          db  "/_/", 0

    coordinatedsobsx1   dw 20, 21, 19, 20, 20, 20, 20, 20, 22, 22, 22, 22, 22, 22, 21 
    coordinatedsobsy1   dw  9,  9, 10, 11, 12, 13, 14, 15,  10, 11, 12, 13, 14, 15, 15

    coordinatedsobsx7   dw 29, 28, 30, 31, 32, 33, 34, 35, 29, 30, 31, 35, 32, 34, 31, 33, 30, 32, 29, 31, 28, 30
    coordinatedsobsy7   dw  9, 10,  9,  9,  9,  9,  9,  9, 10, 10, 10, 10, 11, 11, 12, 12, 13, 13, 14, 14, 15, 15

    coordinatedsobsx5   dw 42, 43, 44, 45, 46, 41, 44, 45, 46, 47, 41, 45, 41, 46, 42, 47, 41, 47, 41, 42, 43, 44, 45, 46
    coordinatedsobsy5   dw  9,  9,  9,  9,  9, 10, 10, 10, 10, 10, 11, 11, 12, 12, 13, 13, 14, 14, 15, 15, 15, 15, 15, 14

    coordinatedsobsx9   dw 55, 56, 57, 54, 58, 53, 59, 54, 55, 59, 56, 58, 55, 57, 54, 55, 56
    coordinatedsobsy9   dw  9,  9,  9, 10, 10, 11, 11, 12, 12, 12, 13, 13, 13, 14, 15, 15, 15

.code
mainscreen PROC
	mov  eax,yellow + (red * 16)
    call SetTextColor
	
	call Clrscr

    mov dl, 15
    mov dh, 5
    call GotoXY
	mov edx, OFFSET gametitle1
	call WriteString
	call Crlf
    mov dl, 15
    mov dh, 6
    call GotoXY
	mov edx, OFFSET gametitle2
	call WriteString
	call Crlf
    mov dl, 15
    mov dh, 7
    call GotoXY
	mov edx, OFFSET gametitle3
	call WriteString
	call Crlf
    mov dl, 15
    mov dh, 8
    call GotoXY
	mov edx, OFFSET gametitle4
	call WriteString

	call Crlf
	call Crlf

    mov dl, 15
    mov dh, 15
    call GotoXY

    mwrite "Enter your playername: "
    mov edx, OFFSET playername
    mov ecx, 25
    call ReadString

    mov eax, yellow + (black * 16)
    call settextcolor
    call clrscr

    menu:
        call clrscr

        mov dl, 25
        mov dh, 4
        call GotoXY

        mwrite "Playername: "
        mov edx, OFFSET playername
        call WriteString

        mov dl, 25
        mov dh, 10
        call GotoXY
        mwrite "Choose an option: "
        call Crlf
        mov dl, 25
        mov dh, 11
        call GotoXY
        mwrite "1.  Start Game"
        call Crlf
        mov dl, 25
        mov dh, 12
        call GotoXY
        mwrite "2.  How To Play"
        call Crlf
        mov dl, 25
        mov dh, 13
        call GotoXY
        mwrite "3.  Exit"
        call Crlf
        mov dl, 25
        mov dh, 14
        call GotoXY
        mwrite "> "
        call ReadDec
        mov opt, eax
        
        cmp opt, 1
        je start
        cmp opt, 2
        je instructions
        cmp opt, 3
        je gameend

        gameend:
            call clrscr
            mov dl, 25
            mov dh, 10
            call gotoxy
            mwrite "Good Bye..."
            call readchar
            Invoke ExitProcess, 0
            
        instructions:
            call clrscr
            mov dl, 18
            mov dh, 6
            call gotoxy
            mwrite "Use the following keys to move your player"
            call Crlf
            mov dl, 29
            mov dh, 8
            call gotoxy
            mwrite "W   ->    Up"
            call Crlf
            mov dl, 29
            mov dh, 9
            call gotoxy
            mwrite "A   ->   Right"
            call Crlf
            mov dl, 29
            mov dh, 10
            call gotoxy
            mwrite "S   ->   Down"
            call Crlf
            mov dl, 29
            mov dh, 11
            call gotoxy
            mwrite "D   ->   Left"
            call Crlf
            mov dl, 15
            mov dh, 15
            call gotoxy
            mwrite "Press 1 to start the game 2 to go back to main menu..."
            mov dl, 15
            mov dh, 16
            call gotoxy
            mwrite "> "
            call ReadDec

            cmp eax, 1
            je start
            cmp eax, 2
            je menu

        start:

	ret
mainscreen ENDP

drawwalls PROC
    mov eax,gray + (black * 16)
    call settextcolor
    
    call Clrscr

    mov dl, 1
    mov dh, 2
    call gotoxy
    
    mov edx, offset ground
    call writestring
    
    mov dl, 1
    mov dh, 24
    call gotoxy
    
    mov edx, offset ground
    call writestring

    mov ecx,21
    mov dh,3
    mov temp, dh

    l1:
        mov dl,0
        mov dh, temp
        call gotoxy
    
        mov edx, offset ground1
        call writestring
        
        inc temp
    
    loop l1

    mov ecx,21
    mov dh,3
    mov temp,dh
    
    l2:
        mov dh,temp
        mov dl,78
        call gotoxy
        
        mov edx, offset ground2
        call writestring
        
        inc temp
    
    loop l2

    call drawcoins
    
    cmp level, 2
    je ll2
    cmp level, 3
    je ll3
    jmp ok

    ll2:
        call drawwall2
        jmp ok

    ll3:
        call drawwall3

    ok:

    ret
drawwalls ENDP

drawwall2 PROC
    mov eax, gray + (black * 16)
    call settextcolor

    mov tempx, 2
    mov tempy, 5

    mov ecx, 32
    upper1:
        mov dl, tempx
        mov dh, tempy
        call gotoxy

        mwrite "="
        inc tempx
        loop upper1

    mov tempx, 46
    mov tempy, 5

    mov ecx, 32
    upper2:
        mov dl, tempx
        mov dh, tempy
        call gotoxy

        mwrite "="
        inc tempx
        loop upper2

    mov tempx, 2
    mov tempy, 20

    mov ecx, 32
    lower1:
        mov dl, tempx
        mov dh, tempy
        call gotoxy

        mwrite "="
        inc tempx
        loop lower1

    mov tempx, 46
    mov tempy, 20

    mov ecx, 32
    lower2:
        mov dl, tempx
        mov dh, tempy
        call gotoxy

        mwrite "="
        inc tempx
        loop lower2

    ret
drawwall2 ENDP

drawwall3 PROC
    mov eax, gray + (black * 16)
    call settextcolor

    call drawwall2

    mov tempx, 34
    mov tempy, 7

    mov ecx, 11
    upper1:
        mov dl, tempx
        mov dh, tempy
        call gotoxy
        mwrite "="
        inc tempx
        loop upper1

    mov tempx, 39
    mov tempy, 5

    mov ecx, 2
    upper2:
        mov dl, tempx
        mov dh, tempy
        call gotoxy
        mwrite "||"
        inc tempy
        loop upper2

    mov tempx, 34
    mov tempy, 18

    mov ecx, 11
    lower1:
        mov dl, tempx
        mov dh, tempy
        call gotoxy
        mwrite "="
        inc tempx
        loop lower1

    mov tempx, 39
    mov tempy, 19

    mov ecx, 2
    lower2:
        mov dl, tempx
        mov dh, tempy
        call gotoxy
        mwrite "||"
        inc tempy
        loop lower2

    mov tempx, 8
    mov tempy, 7

    mov ecx, 12
    left:
        mov dl, tempx
        mov dh, tempy
        call gotoxy
        mwrite "||"
        inc tempy
        loop left

    mov tempx, 70
    mov tempy, 7

    mov ecx, 12
    right:
        mov dl, tempx
        mov dh, tempy
        call gotoxy
        mwrite "||"
        inc tempy
        loop right

    ret
drawwall3 ENDP

drawobstacles1 PROC
    mov eax, gray + (black * 16)
    call settextcolor
    
    mov dl, 20
    mov dh, 9
    call GotoXY
	mov edx, OFFSET level1obs1
	call WriteString
	call Crlf
    mov dl, 19
    mov dh, 10
    call GotoXY
	mov edx, OFFSET level1obs2
	call WriteString
	call Crlf
    mov dl, 20
    mov dh, 11
    call GotoXY
	mov edx, OFFSET level1obs3
	call WriteString
	call Crlf
    mov dl, 20
    mov dh, 12
    call GotoXY
	mov edx, OFFSET level1obs4
	call WriteString
    call Crlf
    mov dl, 20
    mov dh, 13
    call GotoXY
	mov edx, OFFSET level1obs5
	call WriteString
    call Crlf
    mov dl, 20
    mov dh, 14
    call GotoXY
	mov edx, OFFSET level1obs6
	call WriteString
    mov dl, 20
    mov dh, 15
    call GotoXY
	mov edx, OFFSET level1obs7
	call WriteString

    mov dl, 29
    mov dh, 9
    call GotoXY
	mov edx, OFFSET level7obs1
	call WriteString
	call Crlf
    mov dl, 28
    mov dh, 10
    call GotoXY
	mov edx, OFFSET level7obs2
	call WriteString
	call Crlf
    mov dl, 32
    mov dh, 11
    call GotoXY
	mov edx, OFFSET level7obs3
	call WriteString
	call Crlf
    mov dl, 31
    mov dh, 12
    call GotoXY
	mov edx, OFFSET level7obs4
	call WriteString
    call Crlf
    mov dl, 30
    mov dh, 13
    call GotoXY
	mov edx, OFFSET level7obs5
	call WriteString
    call Crlf
    mov dl, 29
    mov dh, 14
    call GotoXY
	mov edx, OFFSET level7obs6
	call WriteString
    mov dl, 28
    mov dh, 15
    call GotoXY
	mov edx, OFFSET level7obs7
	call WriteString

    mov dl, 42
    mov dh, 9
    call GotoXY
	mov edx, OFFSET level5obs1
	call WriteString
	call Crlf
    mov dl, 41
    mov dh, 10
    call GotoXY
	mov edx, OFFSET level5obs2
	call WriteString
	call Crlf
    mov dl, 41
    mov dh, 11
    call GotoXY
	mov edx, OFFSET level5obs3
	call WriteString
	call Crlf
    mov dl, 41
    mov dh, 12
    call GotoXY
	mov edx, OFFSET level5obs4
	call WriteString
    call Crlf
    mov dl, 42
    mov dh, 13
    call GotoXY
	mov edx, OFFSET level5obs5
	call WriteString
    call Crlf
    mov dl, 41
    mov dh, 14
    call GotoXY
	mov edx, OFFSET level5obs6
	call WriteString
    mov dl, 41
    mov dh, 15
    call GotoXY
	mov edx, OFFSET level5obs7
	call WriteString

    mov dl, 55
    mov dh, 9
    call GotoXY
	mov edx, OFFSET level9obs1
	call WriteString
	call Crlf
    mov dl, 54
    mov dh, 10
    call GotoXY
	mov edx, OFFSET level9obs2
	call WriteString
	call Crlf
    mov dl, 53
    mov dh, 11
    call GotoXY
	mov edx, OFFSET level9obs3
	call WriteString
	call Crlf
    mov dl, 54
    mov dh, 12
    call GotoXY
	mov edx, OFFSET level9obs4
	call WriteString
    call Crlf
    mov dl, 56
    mov dh, 13
    call GotoXY
	mov edx, OFFSET level9obs5
	call WriteString
    call Crlf
    mov dl, 57
    mov dh, 14
    call GotoXY
	mov edx, OFFSET level9obs6
	call WriteString
    mov dl, 54
    mov dh, 15
    call GotoXY
	mov edx, OFFSET level9obs7
	call WriteString

    ret
drawobstacles1 ENDP

drawcoins PROC
    mov eax, yellow
    call settextcolor

    mov tempx, 2
    mov tempy, 3

    mov ebx, 22

    loopingcoins:
        mov ecx, 38
        coinprint1:
            mov dl, tempx
            mov dh, tempy
            call gotoxy
            mwrite "."
            add tempx, 2
            loop coinprint1

        add tempy, 1
        dec ebx
        mov tempx, 2
        cmp ebx, 1
        jg loopingcoins

    ret
drawcoins ENDP

playerdraw PROC
    mov eax, yellow
    call settextcolor

    mov dl, playerx
    mov dh, playery
    call gotoxy

    mwritestring offset player

    ret
playerdraw ENDP

playerupdate PROC
    mov al, playerx
    mov tempx, al
    mov al, playery
    mov tempy, al

    mov eax, 100
    call Delay

    mov dl, tempx
    mov dh, tempy
    call gotoxy
    mwrite " "

    cmp charIn, "w"
    je up
    cmp charIn, "W"
    je up
    cmp charIn, "a"
    je left
    cmp charIn, "A"
    je left
    cmp charIn, "s"
    je down
    cmp charIn, "S"
    je down
    cmp charIn, "d"
    je right
    cmp charIn, "D"
    je right

    up:
        mov temp, "u"
        dec playery
        jmp playerupdatefin
    left:
        mov temp, "a"
        dec playerx
        jmp playerupdatefin
    down:
        mov temp, "s"
        inc playery
        jmp playerupdatefin
    right:
        mov temp, "d"
        inc playerx
        jmp playerupdatefin

    playerupdatefin:
        call wallcollision
        call obscollisiondetection1
        call ghostcollision

        cmp level, 2
        je l2
        jmp s2
        l2:
            call obscollisiondetection2
            jmp ok

        s2:

        cmp level, 3
        je l3
        jmp ok
        l3:
            call obscollisiondetection2
            call obscollisiondetection3
            jmp ok

    ok:

    call playerdraw

    ret
playerupdate ENDP

undothedid PROC
    cmp temp, "u"
    je up
    cmp temp, "a"
    je left
    cmp temp, "s"
    je down

    dec playerx
    jmp fin

    up:
        inc playery
        jmp fin
    left:
        inc playerx
        jmp fin
    down:
        dec playery
        jmp fin

    fin:

    ret
undothedid ENDP

wallcollision PROC
    mov al, playerx
    mov bl, playery

    cmp al, 1
    jng notok
    cmp al, 78
    jnl notok

    cmp bl, 2
    jng notok
    cmp bl, 24
    jnl notok

    jmp ok

    notok:
        call undothedid

    ok:

    ret
wallcollision ENDP

obscollisiondetection1 PROC
    mov ecx, lengthof coordinatedsobsx1
    mov edi, 0
        
    check1:
        movzx eax, playerx
        cmp ax, coordinatedsobsx1[edi]
        jne ok1
        movzx eax, playery
        cmp ax, coordinatedsobsy1[edi]
        je equal
        ok1:
            add edi, 2
            loop check1

    mov ecx, lengthof coordinatedsobsx7
    mov edi, 0
        
    check7:
        movzx eax, playerx
        cmp ax, coordinatedsobsx7[edi]
        jne ok7
        movzx eax, playery
        cmp ax, coordinatedsobsy7[edi]
        je equal
        ok7:
            add edi, 2
            loop check7

    mov ecx, lengthof coordinatedsobsx5
    mov edi, 0
        
    check5:
        movzx eax, playerx
        cmp ax, coordinatedsobsx5[edi]
        jne ok5
        movzx eax, playery
        cmp ax, coordinatedsobsy5[edi]
        je equal
        ok5:
            add edi, 2
            loop check5

    mov ecx, lengthof coordinatedsobsx9
    mov edi, 0
        
    check9:
        movzx eax, playerx
        cmp ax, coordinatedsobsx9[edi]
        jne ok9
        movzx eax, playery
        cmp ax, coordinatedsobsy9[edi]
        je equal
        ok9:
            add edi, 2
            loop check9
            jmp fin

    equal:
        call undothedid

    fin:

    ret
obscollisiondetection1 ENDP

obscollisiondetection2 PROC
    mov al, playerx
    mov bl, playery

    jmp s1

    y1:
    mov tempx, 34
    mov ecx, 12
    l1:
        cmp al, tempx
        je ok
        inc tempx
        loop l1
        jne notok

    s1:
        cmp bl, 5
        je y1

    cmp bl, 20
    je y2
    jmp ok
    y2:
    mov tempx, 34
    mov ecx, 12
    l2:
        cmp al, tempx
        je ok
        inc tempx
        loop l2
        jmp notok

    jmp ok

    notok:
        call undothedid

    ok:

    ret
obscollisiondetection2 ENDP

obscollisiondetection3 PROC
    mov al, playerx
    mov bl, playery

    jmp s1

    y1:
    mov tempx, 34
    mov ecx, 10
    l1:
        cmp al, tempx
        je notok
        inc tempx
        loop l1
        je ok
        jmp s2

    s1:
        cmp bl, 7
        je y1
        jmp s2

    y2:
        mov tempx, 34
        mov ecx, 10
        l2:
            cmp al, tempx
            je notok
            inc tempx
            loop l2
            jmp s3

    s2:
        cmp bl, 18
        je y2

    s3:

    cmp al, 39
    je x1
    jmp s4
    x1:
        mov tempy, 5
        mov ecx, 2
        l3:
            cmp bl, tempy
            je notok
            inc tempy
            loop l3
            je ok

    s4:

    cmp al, 40
    je x2
    jmp s5
    x2:
        mov tempy, 5
        mov ecx, 2
        l4:
            cmp bl, tempy
            je notok
            inc tempy
            loop l4
            je ok

    s5:

    cmp al, 39
    je x3
    jmp s6
    x3:
        mov tempy, 19
        mov ecx, 2
        l5:
            cmp bl, tempy
            je notok
            inc tempy
            loop l5
            je ok

    s6:

    cmp al, 40
    je x4
    jmp s7
    x4:
        mov tempy, 19
        mov ecx, 2
        l6:
            cmp bl, tempy
            je notok
            inc tempy
            loop l6
            je ok

    s7:

    cmp al, 8
    je x5
    jmp s8
    x5:
        mov tempy, 7
        mov ecx, 12
        l7:
            cmp bl, tempy
            je notok
            inc tempy
            loop l7
            je ok

    s8:

    cmp al, 9
    je x6
    jmp s9
    x6:
        mov tempy, 7
        mov ecx, 12
        l8:
            cmp bl, tempy
            je notok
            inc tempy
            loop l8
            je ok

    s9:

    cmp al, 70
    je x7
    jmp s10
    x7:
        mov tempy, 7
        mov ecx, 12
        l9:
            cmp bl, tempy
            je notok
            inc tempy
            loop l9
            je ok

    s10:

    cmp al, 71
    je x8
    jmp ok
    x8:
        mov tempy, 7
        mov ecx, 12
        l10:
            cmp bl, tempy
            je notok
            inc tempy
            loop l10
            je ok

    jmp ok

    notok:
        call undothedid

    ok:

    ret
obscollisiondetection3 ENDP

ghost1starting PROC
    mov eax, red
    call settextcolor

    mov ghost1x, 67
    mov dl, ghost1x
    mov ghost1y, 4
    mov dh, ghost1y
    call gotoxy

    mwritestring offset ghost

    ret
ghost1starting ENDP

ghost1mov PROC
    mov al, ghost1x
    mov tempx, al
    mov al, ghost1y
    mov tempy, al

    mov dl, tempx
    mov dh, tempy
    call gotoxy
    mwrite "  "

    mov al, [movCounter]
    inc al
    mov [movCounter], al
    cmp al, 3
    jne fin
    mov byte ptr [movCounter], 0

    mov al, [playerx]
    sub al, [ghost1x]
    mov ah, al

    mov al, [playery]
    sub al, [ghost1y]
    mov bl, al

    mov al, [randomSeed]
    and al, 1
    cmp al, 0
    je s

    cmp ah, 0
    je vertical
    jg right
    jl left

    right:
        inc byte ptr [ghost1x]
        mov temp, "r"
        jmp vertical

    left:
        dec byte ptr [ghost1x]
        mov temp, "l"
        jmp vertical

    vertical:
        cmp bl, 0
        je collision
        jg down
        jl up

    down:
        inc byte ptr [ghost1y]
        mov temp, "d"
        jmp collision

    up:
        dec byte ptr [ghost1y]
        mov temp, "u"
        jmp collision

    collision:
        mov al, [playerx]
        cmp al, [ghost1x]
        jne fin

        mov al, [player]
        cmp al, [ghost1x]
        jne fin

        dec byte ptr [lives]
        mov byte ptr [playerx], 10
        mov byte ptr [playery], 15
        mov byte ptr [ghost1x], 20
        mov byte ptr [ghost1y], 15

    s:
    fin:

    mov eax, red
    call settextcolor

    cmp level, 1
    je l1
    cmp level, 2
    je l2
    cmp level, 3
    je l3
    
    l3:
        call ghostobscollisiondetection31

    l2:
        call ghostobscollisiondetection21

    l1:
        call ghostobscollisiondetection11


    mov al, ghost1x
    mov dh, ghost1y
    call gotoxy

    mwriteString OFFSET ghost

    ret
ghost1mov ENDP

undothedidghostver1 PROC
    cmp temp, "u"
    je up
    cmp temp, "l"
    je left
    cmp temp, "d"
    je down

    dec ghost1x
    jmp fin

    up:
        inc ghost1y
        jmp fin
    left:
        inc ghost1x
        jmp fin
    down:
        dec ghost1y
        jmp fin

    fin:

    ret
undothedidghostver1 ENDP

ghostobscollisiondetection11 PROC
    mov ecx, lengthof coordinatedsobsx1
    mov edi, 0
        
    check1:
        movzx eax, ghost1x
        cmp ax, coordinatedsobsx1[edi]
        jne ok1
        movzx eax, ghost1y
        cmp ax, coordinatedsobsy1[edi]
        je equal
        ok1:
            add edi, 2
            loop check1

    mov ecx, lengthof coordinatedsobsx7
    mov edi, 0
        
    check7:
        movzx eax, ghost1x
        cmp ax, coordinatedsobsx7[edi]
        jne ok7
        movzx eax, ghost1y
        cmp ax, coordinatedsobsy7[edi]
        je equal
        ok7:
            add edi, 2
            loop check7

    mov ecx, lengthof coordinatedsobsx5
    mov edi, 0
        
    check5:
        movzx eax, ghost1x
        cmp ax, coordinatedsobsx5[edi]
        jne ok5
        movzx eax, ghost1y
        cmp ax, coordinatedsobsy5[edi]
        je equal
        ok5:
            add edi, 2
            loop check5

    mov ecx, lengthof coordinatedsobsx9
    mov edi, 0
        
    check9:
        movzx eax, ghost1x
        cmp ax, coordinatedsobsx9[edi]
        jne ok9
        movzx eax, ghost1y
        cmp ax, coordinatedsobsy9[edi]
        je equal
        ok9:
            add edi, 2
            loop check9
            jmp fin

    equal:
        call undothedidghostver1

    fin:

    ret
ghostobscollisiondetection11 ENDP

ghostobscollisiondetection21 PROC
    mov al, ghost1x
    mov bl, ghost1y

    jmp s1

    y1:
    mov tempx, 34
    mov ecx, 12
    l1:
        cmp al, tempx
        je ok
        inc tempx
        loop l1
        jne notok

    s1:
        cmp bl, 5
        je y1

    cmp bl, 20
    je y2
    jmp ok
    y2:
    mov tempx, 34
    mov ecx, 12
    l2:
        cmp al, tempx
        je ok
        inc tempx
        loop l2
        jmp notok

    jmp ok

    notok:
        call undothedidghostver1

    ok:

    ret
ghostobscollisiondetection21 ENDP

ghostobscollisiondetection31 PROC
    mov al, ghost1x
    mov bl, ghost1y

    jmp s1

    y1:
    mov tempx, 34
    mov ecx, 10
    l1:
        cmp al, tempx
        je notok
        inc tempx
        loop l1
        je ok
        jmp s2

    s1:
        cmp bl, 7
        je y1
        jmp s2

    y2:
        mov tempx, 34
        mov ecx, 10
        l2:
            cmp al, tempx
            je notok
            inc tempx
            loop l2
            jmp s3

    s2:
        cmp bl, 18
        je y2

    s3:

    cmp al, 39
    je x1
    jmp s4
    x1:
        mov tempy, 5
        mov ecx, 2
        l3:
            cmp bl, tempy
            je notok
            inc tempy
            loop l3
            je ok

    s4:

    cmp al, 40
    je x2
    jmp s5
    x2:
        mov tempy, 5
        mov ecx, 2
        l4:
            cmp bl, tempy
            je notok
            inc tempy
            loop l4
            je ok

    s5:

    cmp al, 39
    je x3
    jmp s6
    x3:
        mov tempy, 19
        mov ecx, 2
        l5:
            cmp bl, tempy
            je notok
            inc tempy
            loop l5
            je ok

    s6:

    cmp al, 40
    je x4
    jmp s7
    x4:
        mov tempy, 19
        mov ecx, 2
        l6:
            cmp bl, tempy
            je notok
            inc tempy
            loop l6
            je ok

    s7:

    cmp al, 8
    je x5
    jmp s8
    x5:
        mov tempy, 7
        mov ecx, 12
        l7:
            cmp bl, tempy
            je notok
            inc tempy
            loop l7
            je ok

    s8:

    cmp al, 9
    je x6
    jmp s9
    x6:
        mov tempy, 7
        mov ecx, 12
        l8:
            cmp bl, tempy
            je notok
            inc tempy
            loop l8
            je ok

    s9:

    cmp al, 70
    je x7
    jmp s10
    x7:
        mov tempy, 7
        mov ecx, 12
        l9:
            cmp bl, tempy
            je notok
            inc tempy
            loop l9
            je ok

    s10:

    cmp al, 71
    je x8
    jmp ok
    x8:
        mov tempy, 7
        mov ecx, 12
        l10:
            cmp bl, tempy
            je notok
            inc tempy
            loop l10
            je ok

    jmp ok

    notok:
        call undothedidghostver1

    ok:

    ret
ghostobscollisiondetection31 ENDP

ghost2starting PROC
    mov eax, red
    call settextcolor

    mov ghost2x, 70
    mov dl, ghost2x
    mov ghost2y, 20
    mov dh, ghost2y
    call gotoxy

    mwritestring offset ghost

    ret
ghost2starting ENDP

ghost2mov PROC
    mov al, ghost2x
    mov tempx, al
    mov al, ghost2y
    mov tempy, al

    mov dl, tempx
    mov dh, tempy
    call gotoxy
    mwrite "  "

    mov al, [movCounter]
    inc al
    mov [movCounter], al
    cmp al, 3
    jne fin
    mov byte ptr [movCounter], 0

    mov al, [playerx]
    sub al, [ghost2x]
    mov ah, al

    mov al, [playery]
    sub al, [ghost2y]
    mov bl, al

    mov al, [randomSeed]
    and al, 1
    cmp al, 0
    je s

    cmp ah, 0
    je vertical
    jg right
    jl left

    right:
        inc byte ptr [ghost2x]
        mov temp, "r"
        jmp vertical

    left:
        dec byte ptr [ghost2x]
        mov temp, "l"
        jmp vertical

    vertical:
        cmp bl, 0
        je collision
        jg down
        jl up

    down:
        inc byte ptr [ghost2y]
        mov temp, "d"
        jmp collision

    up:
        dec byte ptr [ghost2y]
        mov temp, "u"
        jmp collision

    collision:
        mov al, [playerx]
        cmp al, [ghost2x]
        jne fin

        mov al, [player]
        cmp al, [ghost2x]
        jne fin

        dec byte ptr [lives]
        mov byte ptr [playerx], 10
        mov byte ptr [playery], 15
        mov byte ptr [ghost2x], 20
        mov byte ptr [ghost2y], 15

    s:
    fin:

    mov eax, red
    call settextcolor

    cmp level, 1
    je l1
    cmp level, 2
    je l2
    cmp level, 3
    je l3
    
    l3:
        call ghostobscollisiondetection32

    l2:
        call ghostobscollisiondetection22

    l1:
        call ghostobscollisiondetection12


    mov al, ghost2x
    mov dh, ghost2y
    call gotoxy

    mwriteString OFFSET ghost

    ret
ghost2mov ENDP

undothedidghostver2 PROC
    cmp temp, "u"
    je up
    cmp temp, "l"
    je left
    cmp temp, "d"
    je down

    dec ghost2x
    jmp fin

    up:
        inc ghost2y
        jmp fin
    left:
        inc ghost2x
        jmp fin
    down:
        dec ghost2y
        jmp fin

    fin:

    ret
undothedidghostver2 ENDP

ghostobscollisiondetection12 PROC
    mov ecx, lengthof coordinatedsobsx1
    mov edi, 0
        
    check1:
        movzx eax, ghost2x
        cmp ax, coordinatedsobsx1[edi]
        jne ok1
        movzx eax, ghost2y
        cmp ax, coordinatedsobsy1[edi]
        je equal
        ok1:
            add edi, 2
            loop check1

    mov ecx, lengthof coordinatedsobsx7
    mov edi, 0
        
    check7:
        movzx eax, ghost2x
        cmp ax, coordinatedsobsx7[edi]
        jne ok7
        movzx eax, ghost2y
        cmp ax, coordinatedsobsy7[edi]
        je equal
        ok7:
            add edi, 2
            loop check7

    mov ecx, lengthof coordinatedsobsx5
    mov edi, 0
        
    check5:
        movzx eax, ghost2x
        cmp ax, coordinatedsobsx5[edi]
        jne ok5
        movzx eax, ghost2y
        cmp ax, coordinatedsobsy5[edi]
        je equal
        ok5:
            add edi, 2
            loop check5

    mov ecx, lengthof coordinatedsobsx9
    mov edi, 0
        
    check9:
        movzx eax, ghost2x
        cmp ax, coordinatedsobsx9[edi]
        jne ok9
        movzx eax, ghost2y
        cmp ax, coordinatedsobsy9[edi]
        je equal
        ok9:
            add edi, 2
            loop check9
            jmp fin

    equal:
        call undothedidghostver2

    fin:

    ret
ghostobscollisiondetection12 ENDP

ghostobscollisiondetection22 PROC
    mov al, ghost2x
    mov bl, ghost2y

    jmp s1

    y1:
    mov tempx, 34
    mov ecx, 12
    l1:
        cmp al, tempx
        je ok
        inc tempx
        loop l1
        jne notok

    s1:
        cmp bl, 5
        je y1

    cmp bl, 20
    je y2
    jmp ok
    y2:
    mov tempx, 34
    mov ecx, 12
    l2:
        cmp al, tempx
        je ok
        inc tempx
        loop l2
        jmp notok

    jmp ok

    notok:
        call undothedidghostver2

    ok:

    ret
ghostobscollisiondetection22 ENDP

ghostobscollisiondetection32 PROC
    mov al, ghost2x
    mov bl, ghost2y

    jmp s1

    y1:
    mov tempx, 34
    mov ecx, 10
    l1:
        cmp al, tempx
        je notok
        inc tempx
        loop l1
        je ok
        jmp s2

    s1:
        cmp bl, 7
        je y1
        jmp s2

    y2:
        mov tempx, 34
        mov ecx, 10
        l2:
            cmp al, tempx
            je notok
            inc tempx
            loop l2
            jmp s3

    s2:
        cmp bl, 18
        je y2

    s3:

    cmp al, 39
    je x1
    jmp s4
    x1:
        mov tempy, 5
        mov ecx, 2
        l3:
            cmp bl, tempy
            je notok
            inc tempy
            loop l3
            je ok

    s4:

    cmp al, 40
    je x2
    jmp s5
    x2:
        mov tempy, 5
        mov ecx, 2
        l4:
            cmp bl, tempy
            je notok
            inc tempy
            loop l4
            je ok

    s5:

    cmp al, 39
    je x3
    jmp s6
    x3:
        mov tempy, 19
        mov ecx, 2
        l5:
            cmp bl, tempy
            je notok
            inc tempy
            loop l5
            je ok

    s6:

    cmp al, 40
    je x4
    jmp s7
    x4:
        mov tempy, 19
        mov ecx, 2
        l6:
            cmp bl, tempy
            je notok
            inc tempy
            loop l6
            je ok

    s7:

    cmp al, 8
    je x5
    jmp s8
    x5:
        mov tempy, 7
        mov ecx, 12
        l7:
            cmp bl, tempy
            je notok
            inc tempy
            loop l7
            je ok

    s8:

    cmp al, 9
    je x6
    jmp s9
    x6:
        mov tempy, 7
        mov ecx, 12
        l8:
            cmp bl, tempy
            je notok
            inc tempy
            loop l8
            je ok

    s9:

    cmp al, 70
    je x7
    jmp s10
    x7:
        mov tempy, 7
        mov ecx, 12
        l9:
            cmp bl, tempy
            je notok
            inc tempy
            loop l9
            je ok

    s10:

    cmp al, 71
    je x8
    jmp ok
    x8:
        mov tempy, 7
        mov ecx, 12
        l10:
            cmp bl, tempy
            je notok
            inc tempy
            loop l10
            je ok

    jmp ok

    notok:
        call undothedidghostver2

    ok:

    ret
ghostobscollisiondetection32 ENDP

ghost3starting PROC
    mov eax, red
    call settextcolor

    mov ghost3x, 7
    mov dl, ghost3x
    mov ghost3y, 7
    mov dh, ghost3y
    call gotoxy

    mwritestring offset ghost

    ret
ghost3starting ENDP

ghost3mov PROC
    mov al, ghost3x
    mov tempx, al
    mov al, ghost3y
    mov tempy, al

    mov dl, tempx
    mov dh, tempy
    call gotoxy
    mwrite "  "

    mov al, [movCounter]
    inc al
    mov [movCounter], al
    cmp al, 3
    jne fin
    mov byte ptr [movCounter], 0

    mov al, [playerx]
    sub al, [ghost3x]
    mov ah, al

    mov al, [playery]
    sub al, [ghost3y]
    mov bl, al

    mov al, [randomSeed]
    and al, 1
    cmp al, 0
    je s

    cmp ah, 0
    je vertical
    jg right
    jl left

    right:
        inc byte ptr [ghost3x]
        mov temp, "r"
        jmp vertical

    left:
        dec byte ptr [ghost3x]
        mov temp, "l"
        jmp vertical

    vertical:
        cmp bl, 0
        je collision
        jg down
        jl up

    down:
        inc byte ptr [ghost3y]
        mov temp, "d"
        jmp collision

    up:
        dec byte ptr [ghost3y]
        mov temp, "u"
        jmp collision

    collision:
        mov al, [playerx]
        cmp al, [ghost3x]
        jne fin

        mov al, [player]
        cmp al, [ghost3x]
        jne fin

        dec byte ptr [lives]
        mov byte ptr [playerx], 10
        mov byte ptr [playery], 15
        mov byte ptr [ghost3x], 20
        mov byte ptr [ghost3y], 15

    s:
    fin:

    mov eax, red
    call settextcolor

    cmp level, 1
    je l1
    cmp level, 2
    je l2
    cmp level, 3
    je l3
    
    l3:
        call ghostobscollisiondetection33

    l2:
        call ghostobscollisiondetection23

    l1:
        call ghostobscollisiondetection13


    mov al, ghost3x
    mov dh, ghost3y
    call gotoxy

    mwriteString OFFSET ghost

    ret
ghost3mov ENDP

undothedidghostver3 PROC
    cmp temp, "u"
    je up
    cmp temp, "l"
    je left
    cmp temp, "d"
    je down

    dec ghost3x
    jmp fin

    up:
        inc ghost3y
        jmp fin
    left:
        inc ghost3x
        jmp fin
    down:
        dec ghost3y
        jmp fin

    fin:

    ret
undothedidghostver3 ENDP

ghostobscollisiondetection13 PROC
    mov ecx, lengthof coordinatedsobsx1
    mov edi, 0
        
    check1:
        movzx eax, ghost3x
        cmp ax, coordinatedsobsx1[edi]
        jne ok1
        movzx eax, ghost3y
        cmp ax, coordinatedsobsy1[edi]
        je equal
        ok1:
            add edi, 2
            loop check1

    mov ecx, lengthof coordinatedsobsx7
    mov edi, 0
        
    check7:
        movzx eax, ghost3x
        cmp ax, coordinatedsobsx7[edi]
        jne ok7
        movzx eax, ghost3y
        cmp ax, coordinatedsobsy7[edi]
        je equal
        ok7:
            add edi, 2
            loop check7

    mov ecx, lengthof coordinatedsobsx5
    mov edi, 0
        
    check5:
        movzx eax, ghost3x
        cmp ax, coordinatedsobsx5[edi]
        jne ok5
        movzx eax, ghost3y
        cmp ax, coordinatedsobsy5[edi]
        je equal
        ok5:
            add edi, 2
            loop check5

    mov ecx, lengthof coordinatedsobsx9
    mov edi, 0
        
    check9:
        movzx eax, ghost3x
        cmp ax, coordinatedsobsx9[edi]
        jne ok9
        movzx eax, ghost3y
        cmp ax, coordinatedsobsy9[edi]
        je equal
        ok9:
            add edi, 2
            loop check9
            jmp fin

    equal:
        call undothedidghostver3

    fin:

    ret
ghostobscollisiondetection13 ENDP

ghostobscollisiondetection23 PROC
    mov al, ghost3x
    mov bl, ghost3y

    jmp s1

    y1:
    mov tempx, 34
    mov ecx, 12
    l1:
        cmp al, tempx
        je ok
        inc tempx
        loop l1
        jne notok

    s1:
        cmp bl, 5
        je y1

    cmp bl, 20
    je y2
    jmp ok
    y2:
    mov tempx, 34
    mov ecx, 12
    l2:
        cmp al, tempx
        je ok
        inc tempx
        loop l2
        jmp notok

    jmp ok

    notok:
        call undothedidghostver3

    ok:

    ret
ghostobscollisiondetection23 ENDP

ghostobscollisiondetection33 PROC
    mov al, ghost3x
    mov bl, ghost3y

    jmp s1

    y1:
    mov tempx, 34
    mov ecx, 10
    l1:
        cmp al, tempx
        je notok
        inc tempx
        loop l1
        je ok
        jmp s2

    s1:
        cmp bl, 7
        je y1
        jmp s2

    y2:
        mov tempx, 34
        mov ecx, 10
        l2:
            cmp al, tempx
            je notok
            inc tempx
            loop l2
            jmp s3

    s2:
        cmp bl, 18
        je y2

    s3:

    cmp al, 39
    je x1
    jmp s4
    x1:
        mov tempy, 5
        mov ecx, 2
        l3:
            cmp bl, tempy
            je notok
            inc tempy
            loop l3
            je ok

    s4:

    cmp al, 40
    je x2
    jmp s5
    x2:
        mov tempy, 5
        mov ecx, 2
        l4:
            cmp bl, tempy
            je notok
            inc tempy
            loop l4
            je ok

    s5:

    cmp al, 39
    je x3
    jmp s6
    x3:
        mov tempy, 19
        mov ecx, 2
        l5:
            cmp bl, tempy
            je notok
            inc tempy
            loop l5
            je ok

    s6:

    cmp al, 40
    je x4
    jmp s7
    x4:
        mov tempy, 19
        mov ecx, 2
        l6:
            cmp bl, tempy
            je notok
            inc tempy
            loop l6
            je ok

    s7:

    cmp al, 8
    je x5
    jmp s8
    x5:
        mov tempy, 7
        mov ecx, 12
        l7:
            cmp bl, tempy
            je notok
            inc tempy
            loop l7
            je ok

    s8:

    cmp al, 9
    je x6
    jmp s9
    x6:
        mov tempy, 7
        mov ecx, 12
        l8:
            cmp bl, tempy
            je notok
            inc tempy
            loop l8
            je ok

    s9:

    cmp al, 70
    je x7
    jmp s10
    x7:
        mov tempy, 7
        mov ecx, 12
        l9:
            cmp bl, tempy
            je notok
            inc tempy
            loop l9
            je ok

    s10:

    cmp al, 71
    je x8
    jmp ok
    x8:
        mov tempy, 7
        mov ecx, 12
        l10:
            cmp bl, tempy
            je notok
            inc tempy
            loop l10
            je ok

    jmp ok

    notok:
        call undothedidghostver3

    ok:

    ret
ghostobscollisiondetection33 ENDP

ghostcollision PROC
    mov al, playerx
    cmp al, ghost1x
    jne ok
    mov al, playery
    cmp al, ghost1y
    je notok
    jmp ok

    notok:
        dec lives

        mov dl, 62
        mov dh, 1
        call gotoxy

        mwrite "COLLISION DETECTED"

        mov eax, white
        call settextcolor

        mov dl, 75
        mov dh, 0
        call gotoxy

        mwrite "   "

        mov dl, 75
        mov dh, 0
        call gotoxy

        mov eax, lives
        call WriteDec

        mov eax, 3000
        call Delay

        mov dl, 62
        mov dh, 1
        call gotoxy

        mwrite "                    "

    ok:

    ret
ghostcollision ENDP

gamescreenl1 PROC
    start: 

    mov eax, level
    cmp eax, 1
    je l1
    cmp eax, 2
    je l2
    cmp eax, 3
    je l3
    jmp fin

    l1:
        mov eax, green + (yellow * 16)
        call settextcolor
        call clrscr

        mov dl, 12
        mov dh, 7
        call gotoxy
        mwritestring OFFSET level1title0
        call Crlf
        mov dl, 12
        mov dh, 8
        call gotoxy
        mwritestring OFFSET level1title1
        call Crlf
        mov dl, 12
        mov dh, 9
        call gotoxy
        mwritestring OFFSET level1title2
        call Crlf
        mov dl, 12
        mov dh, 10
        call gotoxy
        mwritestring OFFSET level1title3
        call Crlf
        mov dl, 12
        mov dh, 11
        call gotoxy
        mwritestring OFFSET level1title4
        call Crlf
        mov dl, 12
        mov dh, 12
        call gotoxy
        mwritestring OFFSET level1title5
        call Crlf
        mov dl, 12
        mov dh, 13
        call gotoxy
        mwritestring OFFSET level1title6
        call Crlf

        jmp fin

    l2:
        mov eax, brown + (white * 16)
        call settextcolor
        call clrscr

        mov dl, 12
        mov dh, 7
        call gotoxy
        mwritestring OFFSET level2title0
        call Crlf
        mov dl, 12
        mov dh, 8
        call gotoxy
        mwritestring OFFSET level2title1
        call Crlf
        mov dl, 12
        mov dh, 9
        call gotoxy
        mwritestring OFFSET level2title2
        call Crlf
        mov dl, 12
        mov dh, 10
        call gotoxy
        mwritestring OFFSET level2title3
        call Crlf
        mov dl, 12
        mov dh, 11
        call gotoxy
        mwritestring OFFSET level2title4
        call Crlf
        mov dl, 12
        mov dh, 12
        call gotoxy
        mwritestring OFFSET level2title5
        call Crlf
        mov dl, 12
        mov dh, 13
        call gotoxy
        mwritestring OFFSET level2title6
        call Crlf

        jmp fin

    l3:
        mov eax, red + (lightgray * 16)
        call settextcolor
        call clrscr

        mov dl, 12
        mov dh, 7
        call gotoxy
        mwritestring OFFSET level3title0
        call Crlf
        mov dl, 12
        mov dh, 8
        call gotoxy
        mwritestring OFFSET level3title1
        call Crlf
        mov dl, 12
        mov dh, 9
        call gotoxy
        mwritestring OFFSET level3title2
        call Crlf
        mov dl, 12
        mov dh, 10
        call gotoxy
        mwritestring OFFSET level3title3
        call Crlf
        mov dl, 12
        mov dh, 11
        call gotoxy
        mwritestring OFFSET level3title4
        call Crlf
        mov dl, 12
        mov dh, 12
        call gotoxy
        mwritestring OFFSET level3title5
        call Crlf
        mov dl, 12
        mov dh, 13
        call gotoxy
        mwritestring OFFSET level3title6
        call Crlf

        jmp fin

    fin:

    mov dl, 24
    mov dh, 18
    call gotoxy
    call WaitMsg

    call drawwalls
    call drawobstacles1

    mov eax, white
    call settextcolor

    mov dl, 2
    mov dh, 0
    call gotoxy

    mwrite "Name: "
    mov edx, OFFSET playername
    mov ecx, 25
    call WriteString

    mov dl, 33
    mov dh, 0
    call gotoxy

    mwrite "Score: "
    mov eax, score
    call WriteDec

    mov dl, 68
    mov dh, 0
    call gotoxy

    mwrite "Lives: "
    mov eax, lives
    call WriteDec

    mov dl, 35
    mov dh, 1
    call gotoxy
    mov eax, lightcyan
    call settextcolor

    mwrite "LEVEL "
    mov eax, level
    call WriteDec

    call playerdraw
    call ghost1starting
    call ghost2starting
    call ghost3starting

    call readchar
    mov charIn, al

    gameloop:
        cmp score, 20
        je next
        call ghost1mov
        call ghost2mov
        call ghost3mov
        call playerupdate
        call checkInput
        cmp al, 1
        je gameloop
        jmp gameloop

        next:
            inc level
            jmp start

    ret
gamescreenl1 ENDP

checkInput PROC
    mov al, 0
    call ReadKey
    cmp al, "w"
    je key
    cmp al, "a"
    je key
    cmp al, "s"
    je key
    cmp al, "d"
    je key
    cmp al, "p"
    ;je pause
    cmp al, "P"
    ;je pause

    jmp nokey

    ;pause:
    ;    call pausegame

    key:
        mov charIn, al

    nokey:

    ret
checkInput ENDP

main PROC
	call mainscreen

    maingameloop:
        cmp level, 3
        jg bye
        call gamescreenl1
        jmp maingameloop

    bye:

    call Crlf
    mwrite "Good Bye"
    call ReadChar

Invoke ExitProcess, 0
main ENDP

END main
