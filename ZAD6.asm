	org 100h	;PRZESUNIECIE
start:
	call	clear
	call	menu

	mov	cx,[wybmenu]
	cmp	cx,1
	jne	nierowne1

	call	PobierzTresc
	call	PobierzPrzesuniecie
	call	Szyfr
	call	Wypisz
nierowne1:
	mov	cx,[wybmenu]
	cmp	cx,2
	jne	start

	mov ax,4C00h	;KONIEC PROGRAMU
	int 21h
;----------------------------------------------------
c	times	255	db	10
	db	36

m	db	"\_________MENU_________/",10
	db	"(1) Zaszyfruj wiadomosc",10
	db	"(2) Zakoncz program",10,36

komtresc db	"Podaj tresc (max 25 znakow):",10,36
komprzes db	"Podaj przesuniecie:",36
komwynik db	"Wynik:",10,36

tresc	db	26
	times	28	db	36
wybmenu	db	0
przes	db	0

clear:
	xor	dx,dx
	mov	ah,9
	mov	dx,c
	int	21h
ret

menu:
	mov	ah,9
	mov	dx,m
	int	21h

	mov	ah,1
	int	21h

	xor	ah,ah
	sub	ax,48
	mov	[wybmenu],ax
ret

PobierzTresc:
	call	clear

	mov	ah,9
	mov	dx,komtresc
	int	21h

	mov	ah,10
	mov	dx,tresc
	int	21h
ret

PobierzPrzesuniecie:
	call	clear

	mov	ah,9
	mov	dx,komprzes
	int	21h

	xor	ax,ax
	mov	ah,1
	int	21h
	sub al,48
	mov	[przes],al
ret

Szyfr:
	xor	bx,bx
	xor	dx,dx
	mov	bx,1
	petla:
		inc	bx
		cmp	bx,27
		je	koniec
		mov	dl,[tresc+bx]
		cmp	dl,13
		je	koniec
		cmp	dl,65
		jb	spacja
		cmp	dl,91
		jb	lowCase
		cmp	dl,97
		jb	spacja
		cmp	dl,123
		jb	przesuniecie
		spacja:
			mov	dl,32
			mov	[tresc+bx],dl
			jmp	petla
		lowCase:
			add	dl,32
		przesuniecie:
			mov cl,[przes]
			add dl,cl
			cmp	dl,123
			jb	dalej
			sub	dl,26
		dalej:
			mov [tresc+bx],dl
			jmp	petla

	koniec:
		mov	dl,36
		mov	[tresc+bx],dl
ret

Wypisz:
	call	clear
	
	mov	ah,9
	mov	dx,komwynik
	int	21h
	
	mov	ah,9
	mov	dx,tresc+2
	int	21h

	mov	ah,1
	int	21h
ret
