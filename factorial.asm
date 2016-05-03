;------------------------
;	factorial	
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
num dw 0000h
ans dw 0000h
msg1 db 13,10,"Enter the number: ","$"
msg2 db 13,10,"Factorial: ","$"
msg3 db 13,10,"No.of Ones: ","$"
.code
main proc
			call startpro
			output msg1
			mov ah,01h
			int 21h
			sub al,30h
			mov ah,00h
			mov num,ax
			call factorial
			output msg2
			mov bx,ans
			call print16
			call no_of_ones
			mov ch,cl
			output msg3
			call print8
			call endpro			
main endp

factorial proc
			mov bx,ax
			cmp bx,02h
			jge loophere
			mov ax,01h
			jmp res
   loophere:sub bx,1
			mul	bx
			cmp bx,1
			jg	loophere
		res:mov ans,ax
			ret
		
factorial endp

no_of_ones proc
			mov ax,ans
			mov cl,00h
	looph:	shr ax,01h
			adc cl,00
			cmp ax,00
			jnz looph
			ret
no_of_ones endp

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