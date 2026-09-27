[bits 16]
gdt_start:

gdt_null:           ; 0x00
	dd 0x0000
	dd 0x0000

gdt_code:           ; 0x08
	dw 0xffff
	dw 0x0000
	db 0x00
	db 10011010b
	db 11001111b
	db 0x00

gdt_data:           ; 0x16
	dw 0xffff
	dw 0x0000
	db 0x00
	db 10010010b
	db 11001111b
	db 0x00

gdt_end:

gdt_descriptor:
	dw gdt_end - gdt_start - 1   ; 16 bits GDT size (idk why always - 1)
	dd gdt_start                 ; gdt address

CODE_SEGMENT equ gdt_code - gdt_start
DATA_SEGMENT equ gdt_data - gdt_start
