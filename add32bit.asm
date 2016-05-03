;--------------------------------------
;add two 32bit
;krishnakumarcn
;--------------------------------------
.model small
.stack
.data

num11	dw	1910h
num12	dw	0001h
num21	dw	1510h
num22	dw	0210h
ans1	dw	0000h
ans2	dw	0000h

.code
main proc
			call startpro

			mov ax,num12
			add	ax,num22
			mov ans2,ax
			mov ax,num11
			adc ax,num21
			mov ans1,ax
			mov bx,ans1
			call print16
			mov bx,ans2
			call print16

			call endpro

main endp

print16 proc
			mov ch,bh
			call print8
			mov ch,bl
			call print8
			ret
print16 endp

print8 proc
			mov al,ch
			and al,0f0h
			mov cl,04
			shr al,cl
			mov cl,al
			call printchar
			mov al,ch
			and al,0fh
			mov cl,al
			call printchar
			ret
print8 endp

printchar proc
			cmp cl,09
			jle lesser
			sub cl,0ah
			add	cl,'A'
			jmp xx
	lesser:	add cl,'0'	; or    (add cl,30h)
		xx:	mov ah,02h
			mov dl,cl
			int 21h
			ret
printchar endp

startpro proc
			mov ax,@data
			mov ds,ax
			ret
startpro endp

endpro proc
			mov ah,4ch
			int 21h
			ret
endpro endp

end main

