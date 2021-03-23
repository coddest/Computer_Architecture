	org	100h	;PRZESUNIECIE
	
	mov	ah,2
	mov	dl,10	;enter1
	int	21h
	
	mov	ah,2
	mov	dl,13	;enter2
	int	21h
;----------------------------------------------------------------------

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
;----------------------------------------------------------------------

	mov	ah,2
	mov	dl,10
	int	21h
			;enter
	mov	ah,2
	mov	dl,13
	int	21h
;----------------------------------------------------------------------	

	mov	dl,[a]	;dodawanie
	add	dl,[b]
	
	mov	ah,2	;wypisz dl
	int	21h
	
	mov	ah,2
	mov	dl,32	;spacja
	int	21h
;----------------------------------------------------------------------

	mov	dl,[a]	;odejmowanie
	sub	dl,[b]
	
	mov	ah,2	;wypisz dl
	int	21h
	
	mov	ah,2
	mov	dl,32	;spacja
	int	21h
;----------------------------------------------------------------------

	mov	al,[a]	;mnozenie
	mov	ah,[b]
	mul 	ah
	mov	dl,al
	
	mov	ah,2	;wypisz dl
	int	21h
	
	mov	ah,2
	mov	dl,32	;spacja
	int	21h
;----------------------------------------------------------------------

	mov	bh,[b]
	cmp	bh,0	;sprawdzam czy b jest rowne 0
	jz	bzero	;jesli rowne przechodze do etykiety
	
	mov	ax,0
	mov	al,[a]	;dzielenie
	mov	bh,[b]
	div	bh
	mov	dl,al
		
	mov	ah,2	;wypisz dl
	int	21h
	
	mov	ax,4C00h	;KONIEC PROGRAMU
	int	21h
;----------------------------------------------------------------------

bzero:	mov	ah,2	;wypisuje wykrzyknik i zamyka program
	mov	dl,33
	int	21h
	
	mov	ax,4C00h
	int	21h
	
a	db 0
b	db 0