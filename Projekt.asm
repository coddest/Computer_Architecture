;Program pobiera od uzytkownika dwa lancuchy znakowe, o dlugosci 50 znakow,
;nastepnie zlicza w kazdym ilosc liter (AaBb), porownuje wyniki i
;nastepnie wyswietla komunikat czy ilosc liter obu lancuchach
;jest rowna czy nie.
;Kod zapetla sie, mozna go zakonczyc w kazdym momencie wpisujac tylko *enter*

	org 100h	;PRZESUNIECIE

	call EkranStartowy

start:
	call	PobierzTresc
	call	Liczenie
	call	Clear

	pop	bx
	pop	cx
	cmp	bx,cx
	je	rowne 		;skacze do etykiety jesli rowne
	mov	ah,9
	mov	dx,komniero	;wyswietla odpowiedni komunikat
	int	21h

	call	KoncoweKomentarze

	mov	ah,1	;zatrzymanie
	int	21h
	cmp	al,13
	je	zamknij	;jesli enter zamknij program

	jmp	start	;zapetlenie programu

rowne:
	mov	ah,9
	mov	dx,komrowne	;wyswietla komunikat
	int	21h

	call	KoncoweKomentarze

	mov	ah,1	;zatrzymanie
	int	21h
	cmp	al,13
	je	zamknij	;jesli enter zamknij program

	jmp	start	;zapetlenie programu

zamknij:
	mov ax,4C00h	;KONIEC PROGRAMU
	int 21h
;------------------------------------------------------------
c	times	255	db	10	;zmienna do czyszczenia ekranu
	db	36

komstar0 db	9,9,9,9,36
komstar1 db	"Projekt nr 79",36
komstar2 db	10,"			Gabriel Seroczynski 200878",10,36
komstar3 db	"--------------------------------------------------------------------------------",36
komstar4 db	"   Program pobiera od uzytkownika dwa lancuchy znakowe, o dlugosci 50 znakow,",10,36
komstar5 db	"   nastepnie zlicza w kazdym ilosc liter (AaBb), porownuje wyniki i wyswietla",10,36
komstar6 db	"         komunikat czy ilosc liter obu lancuchach jest rowna czy nie.",10,10,36
komstar7 db	"  Kod zapetla sie, mozna go zakonczyc w kazdym momencie wpisujac tylko *enter*",10,36
komstar8 db	"  (Aby zakonczyc program, wcisnij enter, aby kontynowac dowolny inny przycisk)",36

komtres1 db	"Podaj pierwszy lancuch:",10,36
komtres2 db	"Podaj drugi lancuch:",10,36

komrowne db	"LANCUCHY MAJA TYLE SAMO LITER",36
komniero db	"LANCUCHY MAJA ROZNO ILOSC LITER",36

komilos1 db	10,"Ilosc liter w pierwszym lancuchu: ",36
komilos2 db	10,"Ilosc liter w drugim lancuchu: ",36

tresc1	db	50
	times	52	db	36	;tresc pierwszego lancucha
tresc2	db	50
	times	52	db	36	;tresc drugiego lancucha
;------------------------------------------------------------
Clear:		;procedura do czyszczenia ekranu
	xor	dx,dx
	mov	ah,9
	mov	dx,c
	int	21h
ret

PobierzTresc:	;procedura do pobierania dwoch ciagow
	call	Clear		;czyszczenie ekranu

	mov	ah,9
	mov	dx,komtres1	;komentarz proszacy o pierwszy ciag
	int	21h

	mov	ah,10
	mov	dx,tresc1	;pobranie pierwszego ciagu
	int	21h

	mov	dl,[tresc1+2]	;jesli uzytkownik wprowadzil tylko enter
	cmp	dl,13		;zamyka program
	je	zamknij

	call	Clear		;czyszczenie ekranu

	mov	ah,9
	mov	dx,komtres2	;komentarz o drugi ciag
	int	21h

	mov	ah,10
	mov	dx,tresc2	;pobranie drugiego ciagu
	int	21h

	mov	dl,[tresc2+2]	;jesli tylko enter - zamyka program
	cmp	dl,13
	je	zamknij
ret

Liczenie:
	pop	di

	xor	bx,bx
	xor	dx,dx
	xor	cx,cx
	mov	bx,1
	petla1:
		inc	bx		;zwieksza indeks
		mov	dl,[tresc1+bx]	;znak do DL
		cmp	dl,13		;warunek przerwania petli
		je	drugi
		cmp	dl,65
		jb	petla1
		cmp	dl,91
		jb	litera1
		cmp	dl,97
		jb	petla1
		cmp	dl,123
		jb	litera1
		jmp	petla1
		litera1:
			inc	cx
			jmp	petla1

	drugi:
		push	cx	;przechowuje wynik pierwszego lancucha
		xor	bx,bx	;na stosie
		xor	dx,dx
		xor	cx,cx
		mov	bx,1
		petla2:
			inc	bx		;zwiekszam indeks
			mov	dl,[tresc2+bx]	;znak do DL
			cmp	dl,13		;warunek przerwania petli
			je	return
			cmp	dl,65
			jb	petla2
			cmp	dl,91
			jb	litera2
			cmp	dl,97
			jb	petla2
			cmp	dl,123
			jb	litera2
			jmp	petla2
			litera2:
				inc	cx
				jmp	petla2
	return:
		push	cx

	push	di
ret

KoncoweKomentarze:
	mov	ah,9
	mov	dx,komilos1
	int	21h

	mov	ah,2
	mov	dx,cx
	int	21h

	mov	ah,9
	mov	dx,komilos2
	int	21h

	mov	ah,2
	mov	dx,bx
	int	21h
ret

Czekaj1:		;funkcja Sleep 0,5 sekunda
	mov     cx,07h
	mov     dx,0A120h
	mov     ah,86h
	int     15h
ret

Czekaj2:		;funkcja Sleep 0,1 sekundy
	mov     cx,01h
	mov     dx,86A0h
	mov     ah,86h
	int     15h
ret

EkranStartowy:	;procedura ekranu startowego
	call	Clear	;czyszci ekran
	call	Czekaj1

	mov	ah,9
	mov	dx,komstar0	;tabulatory
	int	21h

	xor	di,di
	petlaStartowa1:	;pierwszy komentarz startowy
		mov	ah,2
		mov	dx,[komstar1+di]
		int	21h
		call Czekaj2
		inc	di
		cmp	di,12
		jne	petlaStartowa1

		xor	di,di
		petlaStartowa2:	;drugi komentarz startowy
			mov	ah,2
			mov	dx,[komstar2+di]
			int	21h
			call Czekaj2
			inc	di
			cmp	di,31
			jne	petlaStartowa2

	mov	ah,9
	mov	dx,komstar3	;trzeci komentarz startowy
	int	21h
	call	Czekaj1

	mov	ah,9
	mov	dx,komstar4	;czwarty komentarz startowy
	int	21h
	call	Czekaj1

	mov	ah,9
	mov	dx,komstar5	;piaty komentarz startowy
	int	21h
	call	Czekaj1

	mov	ah,9
	mov	dx,komstar6	;szosty komentarz startowy
	int	21h
	call	Czekaj1

	mov	ah,9
	mov	dx,komstar7	;siodmy komentarz startowy
	int	21h
	call	Czekaj1

	mov	ah,9
	mov	dx,komstar8	;osmy komentarz startowy
	int	21h
	call	Czekaj1

	mov	ah,1
	int	21h		;zatrzymanie i czekanie na uzytkownika
	cmp	al,13
	je	zamknij
ret
