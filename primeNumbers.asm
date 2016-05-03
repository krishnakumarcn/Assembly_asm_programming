;------------------------
;	Prime Numbers
;krishnakumarcn		|
;------------------------
.model small
.stack
		output macro msgs
			mov ah,09h
			mov dx,offset msgs
			int 21h
		endm
.data
list db 04h,03h,09h,02h,05h,08h,02h,13h
len equ $-list
count db 00h
msg1 db 13,10,"Prime Numbers are: ","$"
msg2 db 13,10,"No.of ones :","$"
.code

main proc
			mov ax,@data
			mov ds,ax
			output msg1
			mov cl,01h
			lea si,list
			mov dl,count
	again:	mov bl,[si]
			call isPrime
			inc si
			inc cl
			cmp cl,len
			jle again
			output msg2
			
			inc count

			mov dl,count
			add dl,'0'
			mov ah,02h
			int 21h

			mov ah,4ch
			int 21h
main endp

isPrime proc
			mov al,bl
			mov ah,00h
			cmp al,02h
			je prime
			push cx
			mov cl,02h
	again1:	mov al,bl
			mov ah,00h
			div cl
			cmp ah,00
			je noprime
			inc cl
			cmp cl,bl
			jl again1
			pop cx
	prime:	inc dl
			mov count,dl
			call print8
			mov dl,count
			ret
	noprime:pop cx
			mov dl,count
			ret
isPrime endp

print8 proc
			push cx
			mov al,bl
			and al,0f0h
			shr al,04h
			call printchar
			mov al,bl
			and al,0fh
			call printchar
			mov dl,' '
			mov ah,02h
			int 21h
			pop cx
			ret
print8 endp

printchar proc
			cmp al,09h
			jle num
			sub al,0ah
			add al,'A'
		num:add al,'0'
			mov dl,al
			mov ah,02h
			int 21h
			ret
printchar endp
end main