[bits 16]

switch_to_32:
; enter 32-bit protected mode
	cli
	lgdt [gdt_descriptor]

	; set last bit
	mov eax, cr0
	or eax, 00000001b
	mov cr0, eax

	; Make a far jump so it flush CPU pipeline
	; ensure not processing invalid CPU instruction mode
	jmp CODE_SEGMENT:init_32

[bits 32]

init_32:
; setup stack and data segment pointers
	mov ax, DATA_SEGMENT
	mov ds, ax
	mov es, ax
	mov ss, ax
	mov fs, ax	
	mov gs, ax

	mov ebp, 0x90000
	mov esp, ebp

	call START_32
