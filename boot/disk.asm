; Arguments Needed:
; 	DH = Number of sector to read  (0-15)
; 	DL = Drive number
; 	ES:BX = pointer to buffer   memory address for copy of disk
; 	                            Used by the INT 0x13,2

disk_load:
	pusha

	; Save the arguments because INT 0x13h changes registers
	push dx

	mov ah, 0x02   ; INT 0x13,2
	mov al, dh     ; number sector to read
	mov cl, 0x02   ; sector index
	mov ch, 0x00   ; cylinder number
	mov dh, 0x00   ; head number

	int 0x13
	jc .disk_error

	pop dx
	cmp al, dh
	jne .sectors_error

	popa
	ret

.disk_error:
	mov dh, ah
	call print_word
	mov bx, .DISK_ERROR
	call print
	call print_nl

	jmp .disk_die

.sectors_error:
	mov dl, al
	call print_word
	mov bx, .SECTORS_ERROR
	call print
	call print_nl

.disk_die:

	jmp $

.DISK_ERROR: db " Disk read error", 0x00
.SECTORS_ERROR: db " Sector error", 0x00
