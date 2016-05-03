;*******************************
;			sorting
;krishnakumarcn
;*******************************

.model small
.stack
			output macro msgs
					mov ah,09h
					lea dx,msgs
					int 21h
			endm
.data
			array dw 10h,3h,15h,1h,6h,9h,4h
			len equ 07h
			msg1 db 13,10,"Initial Array: ","$"
			msg2 db 13,10,"Sorted Array: ","$"

.code

main proc
			mov ax,@data
			mov ds,ax

			output msg1
			call displaym
			call sort
			output msg2
			call displaym
			mov ah,4ch
			int 21h

main endp


sort proc
			
			mov dl,len
	outer:	mov cl,dl
			dec cl
			lea si,array
	inner:				mov ah,[si]
						cmp ah,[si+2]
						jle contn
						xchg ah,[si+2]
						xchg ah,[si]
				contn:	add si,2
						dec cl
						cmp cl,00h
						jne inner
			dec dl
			cmp dl,01h
			jne outer
			ret


sort endp

displaym proc
			xor cx,cx
			lea si,array
			mov cl,len
again:		mov bl,[si]
			call print8
			add si,02h
			dec cl
			jnz again
			ret
displaym	endp


print8 proc
			push cx
			mov ah,02h
			mov dl,' '
			int 21h
			mov al,bl
			and al,0f0h
			mov cl,04
			shr al,cl
			mov cl,al
			call printchar
			mov al,bl
			and al,0fh
			mov cl,al
			call printchar
			pop cx
			ret
print8 endp

printchar proc
			push cx
			cmp cl,09
			jle lesser
			sub cl,0ah
			add	cl,'A'
			jmp xx
	lesser:	add cl,'0'	; or    (add cl,30h)
		xx:	mov ah,02h
			mov dl,cl
			int 21h
			pop cx
			ret
printchar endp

end main