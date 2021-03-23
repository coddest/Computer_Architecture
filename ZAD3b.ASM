	org	100h	;PRZESUNIECIE
;Program wypisuje dwa komunikaty proszac o podanie imienia i nazwiska
;wcisniecie ENTER konczy pobieranie nazwiska/imienia
;imie i nazwisko maja rozmiar 25
;w trakcie podawania znakow program sprawdza czy podany znak znajduje sie w
;zakresie A-Z lub a-z
;w zaleznosci od wyniku wypisuje odpowiedni komentarz po pobraniu
;wszystkich znakow
;na sam koniec zwraca imie i nazwisko oddzielone spacja

start:
	xor	di,di
	mov	dl,[komimie]
	mov	ah,2
	
komunikat1:			;wyswietlanie komunikatu o imie
	int	21h
	inc	di
	mov	dl,[komimie+di]

	cmp	di,18
	jne	komunikat1
;--------------------------------------------------------
	xor	di,di
	mov	ah,1
pobierzimie:			;pobieranie imienia
	int	21h
	cmp	al,13
	je	zakonczPobieranieImienia

	mov	[imie+di],al
	inc	di
	
	cmp	al,65
	jl	zmianaBoolaImie
	cmp	al,91
	jl	pominBoolaImie
	
	cmp	al,97
	jl	zmianaBoolaImie
	cmp	al,123
	jl	pominBoolaImie

zmianaBoolaImie:
	mov	si,1
	mov	[bool],si

pominBoolaImie:
	jmp	pobierzimie
;--------------------------------------------------------
zakonczPobieranieImienia:
	xor	di,di
	mov	ah,2
	mov	dl,[komnazw]
komunikat2:			;wyswietlanie komunikatu o nazwisko
	int	21h
	inc	di
	mov	dl,[komnazw+di]

	cmp	di,22
	jne	komunikat2	;zapetlam do pobrania
;---------------------------------------------------------	
	xor	di,di
	mov	ah,1
pobierznazwisko:			;pobieranie nazwiska
	int	21h
	cmp	al,13
	je	zakonczPobieranieNazwiska

	mov	[nazwisko+di],al
	inc	di
	
	cmp	al,65
	jl	zmianaBoolaNazwisko
	cmp	al,91
	jl	pominBoolaNazwisko
	
	cmp	al,97
	jl	zmianaBoolaNazwisko
	cmp	al,123
	jl	pominBoolaNazwisko
	
zmianaBoolaNazwisko:
	mov	si,1
	mov	[bool],si

pominBoolaNazwisko:
	jmp	pobierznazwisko
;-------------------------------------------------------
zakonczPobieranieNazwiska:
	xor	di,di
	mov	cl,[bool]
	cmp	cl,0		;sprawdzam zawartosc boola

	mov	ah,2
	mov	dl,[samelit]
	je	boolzero	;zaleznie od zawartosci przeskakuje
	mov	dl,[nielite]	;do odpowiedniej etykiety
	jne	booljeden
;--------------------------------------------------------
boolzero:
	int	21h
	inc	di
	mov	dl,[samelit+di]

	cmp	di,14
	jne	boolzero
	jmp	dalej

booljeden:
	int	21h
	inc	di
	mov	dl,[nielite+di]

	cmp	di,18
	jne	booljeden
	;kontynuuje do wypisania imienia i nazwiska
;-------------------------------------------------------
dalej:
	xor	di,di
	mov	dl,[nazwisko]
	mov	ah,2
wypisznazwisko:			;wypisywanie nazwiska
	int	21h
	inc	di
	mov	dl,[nazwisko+di]

	cmp	dl,36
	jne	wypisznazwisko

	mov	ah,2
	mov	dl,32		;spacja, iddzielam nazwisko i imie
	int	21h
	
	xor	di,di
	mov	dl,[imie]
	mov	ah,2
wypiszimie:				;wypisywanie imienia
	int	21h
	inc	di
	mov	dl,[imie+di]

	cmp	dl,36
	jne	wypiszimie
	
	mov	ax,4C00h ; KONIEC PROGRAMU
	int	21h
;----------------------------------------------------------
komimie	db	'P','o','d','a','j',' ','s','w','o','j','e',' ','i','m','i','e',':',10
komnazw	db	'P','o','d','a','j',' ','s','w','o','j','e',' ','n','a','z','w','i','s','k','o',':',10
samelit	db	10,'T','y','l','k','o',' ','l','i','t','e','r','y',10
nielite	db	10,'N','i','e',' ','t','y','l','k','o',' ','l','i','t','e','r','y',10

imie	times	25	db	36
nazwisko	times	25	db	36

bool	db	0