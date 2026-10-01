[bits 32]
global PortOutB
global PortOutW
global PortInB
global PortInW

PortOutB:
	mov dx, [esp+0x04]  ; port
	mov al, [esp+0x08]  ; data
	out dx, al
	ret

PortOutW:
	mov dx, [esp+0x04]
	mov ax, [esp+0x08]
	out dx, ax
	ret

PortInB:
	mov dx, [esp+0x04]
	xor ax, ax
	in al, dx
	ret

PortInW:
	mov dx, [esp+0x04]
	xor ax, ax
	in ax, dx
	ret
