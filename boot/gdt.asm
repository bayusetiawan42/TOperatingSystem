[bits 16]
gdt_start:

gdt_null:           ; 0x00
	dd 0x0000
	dd 0x0000

gdt_code:           ; 0x08
	dw 0xffff
	dw 0x0000
	db 0x00
	db 10011010b  ; P=1, DPL=00, S=1, E=1, DC=0, RW=1, A=0
	db 11001111b  ; G=1, DB=1, L=0, 0,  SEGMENT LIMIT 1111
	db 0x00

gdt_data:           ; 0x16
	dw 0xffff
	dw 0x0000
	db 0x00
	db 10010010b  ; P=1, DPL=00, S=1, E=0. DC=0, RW=1, A=0
	db 11001111b  ; G1, DB=1, L=0, 0, SEGMENT LIMIT 1111
	db 0x00

gdt_end:

gdt_descriptor:
	dw gdt_end - gdt_start - 1   ; 16 bits GDT size (idk why always - 1)
	dd gdt_start                 ; gdt address

CODE_SEGMENT equ gdt_code - gdt_start
DATA_SEGMENT equ gdt_data - gdt_start
