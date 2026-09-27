KERNEL_OFFSET equ 0x1000

[org 0x7c00]
[bits 16]
	mov bx, DEBUG_REAL_MODE
	call print

	mov [BOOT_DRIVE], dl  ; Nick Blundell said BIOS stores boot drvie in DL
	                      ; and he said its good to remember that in this case BOOT_DRIVE
	                      ; variable.

	mov bp, 0x9000
	mov sp, bp

	call kernel_load

	call switch_to_32

	jmp $

kernel_load:
	mov bx, DEBUG_KERNEL_LOAD
	call print

	mov bx, KERNEL_OFFSET
	mov dh, 15 ; read 15 sectors
	mov dl, [BOOT_DRIVE] ; reuse
	call disk_load

	ret

%include "print.asm"
%include "gdt.asm"
%include "disk.asm"
%include "switch32.asm"

[bits 32]
START_32:
	mov ebx, DEBUG_SWITCH_32
	call vga_print

	jmp $

BOOT_DRIVE db 0x00

DEBUG_REAL_MODE    db "Started in 16-bit real mode", 0xa, 0x0
DEBUG_SWITCH_32    db "Succesfully loaded 32-bit mode", 0x0
DEBUG_KERNEL_LOAD  db "Loading kernel to memory...", 0xa, 0x0

times 510 - ($-$$) db 0x00
dw 0xaa55
