	org 100h	; PRZESUNIECIE
	
	mov	ah,2
	mov	dl,10	;enter1
	int	21h
	
	mov	ah,2
	mov	dl,13	;enter2
	int	21h
	
	mov	ah,2
	mov	dl,71	;G
	int	21h
	
	mov	ah,2
	mov	dl,97	;a
	int	21h

	mov	ah,2
	mov	dl,98	;b
	int	21h
	
	mov	ah,2
	mov	dl,114	;r
	int	21h
	
	mov	ah,2
	mov	dl,105	;i
	int	21h
	
	mov	ah,2
	mov	dl,101	;e
	int	21h
	
	mov	ah,2
	mov	dl,108	;l
	int	21h
	
	mov	ah,2
	mov	dl,32	;spacja 
	int	21h
	
	mov	ah,2
	mov	dl,83	;S
	int	21h
	
	mov	ah,2
	mov	dl,101	;e
	int	21h
	
	mov	ah,2
	mov	dl,114	;r
	int	21h
	
	mov	ah,2
	mov	dl,111	;o
	int	21h
	
	mov	ah,2
	mov	dl,99	;c
	int	21h
	
	mov	ah,2
	mov	dl,122	;z
	int	21h
	
	mov	ah,2
	mov	dl,121	;y
	int	21h
	
	mov	ah,2
	mov	dl,228	;ä
	int	21h
	
	mov	ah,2
	mov	dl,115	;s
	int	21h
	
	mov	ah,2
	mov	dl,107	;k
	int	21h
	
	mov	ah,2
	mov	dl,105	;i
	int	21h
	
	mov	ah,1	;zapisanie znaku z klawiatury
	int	21h
	
	mov	ax, 4C00h	; KONIEC PROGRAMU
	int	21h