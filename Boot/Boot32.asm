[BITS 16]

BOOT32:
;Enter 32-bit protected mode
	CLI
	LGDT [GDT_DESCRIPTOR]

	; SET LAST BIT
	MOV EAX, CR0
	OR EAX, 00000001B
	MOV CR0, EAX

	;Make a far jump so it flush cpu pipeline
	;to ensure not processing invalid cpu instruction mode
	JMP CODE_SEGMENT:INIT32

[BITS 32]

INIT32:
;Setup stack and data segment pointers
	MOV AX, DATA_SEGMENT
	MOV DS, AX
	MOV ES, AX
	MOV SS, AX
	MOV FS, AX	
	MOV GS, AX

	MOV EBP, 0X90000
	MOV ESP, EBP

	CALL START32
