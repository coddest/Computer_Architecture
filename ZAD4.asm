	org	100h	;PRZESUNIECIE
;Program pobiera dwa znaki (zakladamy ze uzytownik podaje tylko cyfry)
;przesuwa podane wartosci o 48 zapisuje do zmiennych (a i b)
;nastepnie wykonuje kolejno dzielenie, mnozenie, odejmowanie i dodawanie
;wrzucajac wyniki na stos (a pomiedzy wyniki spacje)
;nastepnie wypisuje wartosci stosu na ekran w petli
;-----------------------------------------------------	
	xor	dx,dx
	call Enter

	call Pobieranie

	call Dzielenie
	call Spacja
	call Mnozenie
	call Spacja
	call Odejmowanie
	call Spacja
	call Dodawanie

	call Enter
;----------------------------------------------------------------------
	mov	ah,2
	xor	si,si
petla:				;petla wypisujaca wartosci ze stosu
	pop	dx
	int	21h
	
	inc	si
	cmp	si,7
	jne petla
;----------------------------------------------------------------------	
	mov	ax,4C00h	;KONIEC PROGRAMU
	int	21h
	
a	db 0
b	db 0

Pobieranie:
	mov	ah,1
	int	21h	;pobieram znak z klawiatury do al
	sub	al,48
	mov	[a],al	; po przesunieciu zapisuje znak do [a]
	
	mov	ah,2
	mov	dl,44	;rozdzielam cyfry przecinkiem
	int	21h
	
	mov	ah,1
	int	21h	; to samo dla [b]
	sub	al,48
	mov	[b],al
	
	call Enter
ret

Enter:
	mov	ah,2
	mov	dl,10	;enter1
	int	21h
	
	mov	ah,2
	mov	dl,13	;enter2
	int	21h
ret

Spacja:				;DODAJE SPACJE DO DL
	pop	cx
	mov	dl,32
	push	dx
	push	cx
ret

Dodawanie:			;DODAWANIE
	pop	cx		; w cx zachowuje adres powrotu
	mov	dl,[a]
	add	dl,[b]
	push	dx
	push	cx		;i wkladam na koniec znowu na stos
ret

Odejmowanie:			;ODEJMOWANIE
	pop	cx
	mov	dl,[a]
	sub	dl,[b]
	push	dx
	push	cx
ret	

Mnozenie:			;MNOZENIE
	pop	cx
	mov	al,[a]
	mov	ah,[b]
	mul	ah
	mov	dl,al
	push	dx
	push	cx
ret

Dzielenie:			;DZIELENIE
	pop	cx
	
	mov	bh,[b]
	cmp	bh,0	;sprawdzam czy b jest rowne 0
	jz	bzero	;jesli rowne przechodze do etykiety bzero
	
	mov	ax,0
	mov	al,[a]
	mov	bh,[b]
	div	bh
	mov	dl,al
	jmp	dalej

bzero:
	mov	dl,33	;wykrzyknik
dalej:
	push	dx
	push	cx
ret