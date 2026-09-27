KERNEL_OFFSET equ 0x1000

[org 0x7c00]
[bits 16]

	mov [BOOT_DRIVE], dl  ; Nick Blundell said BIOS stores boot drvie in DL
	                      ; and he said its good to remember that. In this case the BOOT_DRIVE
	                      ; variable.

	mov bp, 0x9000
	mov sp, bp

	call kernel_load

	mov bx, DEBUG_SWITCH_32
	call print

	call switch_to_32

	jmp $

kernel_load:
	mov bx, DEBUG_KERNEL_LOAD
	call print

	;disk_load(es:bx, 15, BOOT_DRIVE)
	mov bx, KERNEL_OFFSET
	mov dh, 15
	mov dl, [BOOT_DRIVE]
	call disk_load

	ret

%include "print.asm"
%include "gdt.asm"
%include "disk.asm"
%include "switch32.asm"

[bits 32]

START_32:
	call KERNEL_OFFSET

	jmp $

BOOT_DRIVE:   db 0x00

DEBUG_SWITCH_32:       db "Starting 32-bit mode...", 0x0
DEBUG_KERNEL_LOAD:     db "Loading kernel to memory...", 0xa, 0x0

times 510 - ($-$$) db 0x00
dw 0xaa55
