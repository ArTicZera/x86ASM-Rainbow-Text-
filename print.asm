[BITS    16]
[ORG 0x7c00]

call start

start:

		mov ax, 13h ; mode 13h
		int 10h

		mov si, string
		mov al, [si] ; al = first string char
		
		mov ah, 0x0E ; teletype output
		mov bh, 0x00
		
		returnFirstColor:
				mov bl, 08h ; min color
				printLoop:
						add bl, 01h ; go to the next color
						
						cmp bl, 10h ; max color
						je returnFirstColor
				
						int 10h
						inc si ; next string char
						mov al, [si]
						
						cmp al, 0 ; string end
						jnz printLoop	
						ret

string: db "The quick brown fox jumps over the lazy dog!!!",0

times 510 - ($ - $$) db 0
dw 0xAA55
