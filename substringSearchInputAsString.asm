;-------------------------------------
;		Substring Search
;krishnakumarcn
;--------------------------------------

.model small
.stack
		output macro msgs
			mov ah,09h
			mov dx,offset msgs
			int 21h
		endm

		

.data
		source db 100,0,100 dup("$")
		key	db 100,0,100 dup("$")
		msg1 db 13,10,"enter the string: ","$"
		msg2 db 13,10,"enter the key: ","$"
		present db 13,10," is present in the string","$"
		absent db  13,10,"is not in the string","$"
		dummy db 13,10,"dummy","$"
		sourcelen dw ?
		keylen dw ?
		newline db 13,10," ","$"
		nosubst dw 0
.code
main proc
		mov ax,@data
		mov ds,ax
		mov es,ax

		output msg1

		mov ah,0ah			;input source string
		lea dx,source
		int 21h



		output msg2

		mov ah,0ah			;input key
		lea dx,key
		int 21h
		
							;find length
		mov ah,source+1
		mov byte ptr[sourcelen],ah

		mov ah,key+1
		mov byte ptr[keylen],ah
		

		call search

		mov ah,4ch
		int 21h

main endp

proc search		
		mov ax,sourcelen
		sub ax,keylen
		inc ax
		mov nosubst,ax
		mov dx,0
		cld
here:	lea si,source+2
		add si,dx
		lea di,key+2
		mov cx,keylen
		repe cmpsb
		je issubs
		inc dx
		cmp dx,nosubst
		jb here
		jmp notsubs
notsubs:output absent
		jmp stop	
issubs:	output present
		jmp stop
stop:	ret
search endp


end main