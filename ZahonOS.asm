[org 0x7c00]

call newline
call newline
call newline
call newline
call newline
call newline
call newline
call newline
call newline
call newline
call newline
call newline

mov bx, bm1
call printf

mov bx, bm2
call printf

call cls

mov bh, 70h
call color

mov bx, welmsg
call printf

wywtd:
	mov bx, welmsg2
	call printf

	call waitforkey

	cmp al, 49
	je reboot

	cmp al, 50
	je guess

	mov bx, invalidmsg
	call printf
	call waitforkey

	call cls

	mov bh, 70h
	call color

	call wywtd

jmp $

good:
	mov bx, okans
	call printf

	call waitforkey
	call reboot

guess:
	call cls

	mov bh, 70h
	call color

	mov bx, gmsg
	call printf

	call waitforkey

	cmp al, 49
	je good

	mov bx, wrongans
	call printf

	call waitforkey
	call reboot

reboot:
    db 0x0ea
    dw 0x0000
    dw 0xffff

newline:
	mov bx, nl
	call printf
	ret

color:
  mov ah, 06h
  xor al, al
  xor cx, cx
  mov dx, 184FH
  ; mov bh, 1Fh
  int 10h
  ret

waitforkey:
  mov ah, 00h
  int 16h
  ret

cls:
  pusha
  mov ah, 0x00
  mov al, 0x03
  int 0x10
  popa
  ret

printf:
  mov ah, 0x0e
  .Loop:
  cmp [bx], byte 0
  je .Exit
    mov al, [bx]
    int 0x10
    inc bx
    jmp .Loop
  .Exit:
  ret

okans: db "Correct answer!", 0x00
wrongans: db "Wrong answer!", 0x00
gmsg: db "What is 78 * 23?", 0x0a, 0x0d, "[1] 1794", 0x0a, 0x0d, "[2] 1894", 0x0a, 0x0d, "[3] 1872", 0x0a, 0x0d, 0x00
invalidmsg: db "Invalid option!", 0x0a, 0x0d, 0x00
nl: db 0x0a, 0x0d, 0x00
welmsg: db "Welcome to ZahonOS Light edition!", 0x0a, 0x0d, 0x00
welmsg2: db "what do you want to do?", 0x0a, 0x0d, "[1] Restart", 0x0a, 0x0d, "[2] Game", 0x0a, 0x0d, 0x0a, 0x0d, "Answer: ", 0x00
bm1: db "Booting ZahonOS Light edition...", 0x0a, 0x0d, 0x00
bm2: db "Done!", 0x00

times 510-($-$$) db 0
dw 0xaa55
