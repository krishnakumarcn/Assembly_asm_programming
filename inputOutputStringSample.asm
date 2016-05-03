;--------------------------------
;input and output string
;krishnakumarcn
;--------------------------------


;NOTE: test program,input string with size less than 10, len is defined as byte for easy print
output macro mesgs
	lea dx,mesgs
	mov ah,09h
	int 21h
endm
.model small
.stack

.data

;*************************************************************
msg db 50,0,50 dup('$')				;dup('$') must for input string from keyboard
;*****************************************************************

msg1 db 13,10,"Input string: ","$"
pr 	db 13,10,"output is:","$"
lenmsg db 13,10,"length of string is: ","$"
len db ?
.code
main proc
	mov ax,@data
	mov ds,ax

	output msg1

; TO ACCEPT A STRING msg FROM KEYBOARD 
;**************************************
	mov ah,0Ah
	mov dx,offset msg
	int 21h
;***************************************




;TO FIND LENGTH len OF A STRING msg
;*****************************************
	mov ah,msg+1
	mov byte ptr[len],ah
;*****************************************

	output pr

;while printing it need to select msg+2  dont know why!!!
;*******************************
	lea dx,msg+2
	mov ah,09h
	int 21h
;*************************
	
	output lenmsg

	mov ah,02
	mov dl,len
	add dl,'0'
	int 21h

	mov ah,4ch
	int 21h

main endp



end 