;*****************
;	hex to dec
;krishnakumacn
;**************

.model small
.stack
		output macro msgs
				mov ah,09h
				lea dx,msgs
				int 21h
		endm
.data
		num dw 78h
		res db 10 dup("$")
		msg db 13,10,"Res: ","$"
.code
main proc
		mov ax,@data
		mov ds,ax
		mov cx,0h
		mov ax,num
here:	mov bx,10
		mov dx,0
		div bx
		push dx
		inc cx
		cmp al,09
		jg here
		push ax
		inc cx
		lea si,res
opl:	pop ax
		mov ah,02h
		mov dl,al
		add dl,'0'
		mov [si],dl
		inc si
		int 21h
		loop opl
		output msg
		output res
		mov ah,4ch
		int 21h
main endp
end main
