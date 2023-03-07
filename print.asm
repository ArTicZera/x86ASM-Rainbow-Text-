;UPDATE 1
;
; * NOW THIS BOOTSECTOR PROGRAM WORKS FOR VMWARE THANKS TO DS:AX 
;
; * I'VE SELECTED THE MOST VIVID FADING COLORS FROM THE VGA PALETTE 

[BITS    16]
[ORG 0x7c00]

call start

start:
		;Mode 13h
		mov ax, 0x13
		int 10h
		
		;Data segment
		mov ax, cx
		mov ds, ax

		mov si, string
		mov al, [si] ;AL = First string's char
		
		;Teletype output
		mov ah, 0x0E
		mov bh, 0x00
		
		returnFirstColor:
				;Min color
				mov bl, 32

				printLoop:
						;Go to the next color
						inc bl
						
						;Maxcolor
						cmp bl, 55
						je returnFirstColor
				
						int 10h
						inc si ;Next string char
						mov al, [si]
						
						cmp al, 0x00 ;String's end
						jnz printLoop	
						ret

string: db "The quick brown fox jumps over the lazy dog!!!",0

times 510 - ($ - $$) db 0
dw 0xAA55
