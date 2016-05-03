;******************************
;matrix transpose
;krishnakumarcn
;*******************************


;for(i=0;i<col;i++)
;	for(j=0;j<row;j++)
;			output (j*col)+i
;
;

.model small
.stack

		output macro msgs
			mov ah,09h
			lea dx,msgs
			int 21h
		endm
.data
		matrix db 01h,02h,03h,04h,05,06
		col db 3h
		row db 2h
		endl db 13,10,"$"
.code
main proc
		mov ax,@data
		mov ds,ax

		lea si,matrix
		xor cx,cx
		outer:	xor bx,bx
				inner:	mov al,bl
						mul col
						add al,cl
						push bx
						mov bl,al
						mov dl,[si+bx]
						mov ah,02h
						add dl,'0'
						int 21h
						mov dl,' '
						int 21h
						pop bx
						inc bl
						inc ch
						cmp bl,row
						jl inner
				inc cl
				output endl
				cmp cl,col
				jl outer
		mov ah,4ch
		int 21h
main endp
end main
