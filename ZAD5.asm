;PROGRAM LICZENIA SILNI DO 8
;Program pobiera od uzytkownika znak ASCII i wykonuje przesuniecie o -48
;nastepnie sprawdza czy podana liczba jest w zakresie 0=<x=<8
;jesli nie -> wyrzuca na ekran napis "Error" i konczy działanie
;jesli tak sprawdza czy jest rowne 0 lub 1
;jesli tak wyswietla wynik -> 1 i konczy program
;jesli nie petla wykonuje dzialanie silnie
;nastepnie dzieli przez 10 i wrzuca reszte na stos
;po skonczeniu dzielenia wypisuje reszty ze stosu z przesunieciem +48
;zamyka program

	org	100h	;PRZESUNIECIE

	call Enter
	call Enter

	call Pobieranie
	call Silnia

	mov	ax,4C00h	;KONIEC PROGRAMU
	int	21h

komunik	db	"Error"
;----------------------------------------------------------
Enter:
	mov	ah,2
	mov	dl,10	;enter1
	int	21h

	mov	ah,2
	mov	dl,13	;enter2
	int	21h
ret

Pobieranie:
	pop	bx		;adres powrotu do bx

	mov	ah,1	;do ah 1
	int	21h	;pobieram znak z klawiatury do al
	sub	al,48	;przesuniecie znaku ascii
	mov	ah,0	;zeruje ah
	push	ax

	mov	ah,2
	mov	dl,33
	int	21h
			;wypisuje "!=" na ekran
	mov	dl,61
	int	21h

	push	bx	;adres powrotu na stos
ret
;----------------------------------------------------------
Silnia:
	pop	si	;adres powrotu do si
	pop	cx	;podana liczba ze stosu do cx
	push	si	;adres powrotu na stos
	cmp	cl,1
	je	wynikJeden	;Sprawdzam podana przez uzytkownika liczbe
	cmp	cl,0		;dla 0 lub 1 przeskakuje do wypisania na ekran '1'
	je	wynikJeden
	jl	wynikError	;dla <0 lub >8 przeskakuje do wypisania bledu
	cmp	cl,8
	jg	wynikError
				;przechodze dalej jesli podana liczba spelnia wszystkie warunki
	mov	ax,1
	mnozenie:
		mul	cx
		loop	mnozenie
		call	Wypisanie	;przechodze do wypisania wyniku
		jmp	koniecSilni

	wynikJeden:
		mov	ah,2
		mov	dl,49	;wpisuje 1 jako wynik
		int	21h
		jmp	koniecSilni

	wynikError:
		mov	ah,2
		mov	dl,[komunik]
		xor	si,si
		Error:
			int	21h
			inc	si
			mov	dl,[komunik+si]

			cmp	si,5
			jne	Error
	koniecSilni:
ret
;----------------------------------------------------------
Wypisanie:
	xor	cx,cx		;zeruje cx

	dzielenie:
		xor	dx,dx	;zeruje rejestr dla reszty
		mov	bx,10	;10 do bx
		div	bx	;wykonuje dzielenie
		push dx		;reszta na stos
		inc	cx	;cx++
	cmp	ax,0		;sprawdzam czy dzielna jest >0
	jne dzielenie	;jesli tak wracam na poczatek dzielenie

	drukowanie:	;
		mov	ah,2	;2 do ah aby wypisywac
		pop	dx	;sciagam znak ze stosu
		add	dx,48	;przesuniecie ASCII +48
		int	21h	;wypisuje na ekran
		loop	drukowanie	;dzieki licznikowi z dzielenia sciagnie
					;ze stosu dokladnie tyle ile wrzucilo
ret
