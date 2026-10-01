; Arguments Needed:
; 	DH = Number of sector to read  (0-15)
; 	DL = Drive number
; 	ES:BX = pointer to buffer   memory address for copy of disk
; 	                            Used by the INT 0x13,2

DISK_LOAD:
	PUSHA

	;Save the arguments because int 0x13h changes registers
	PUSH DX

	MOV AH, 0X02   ;INT 0X13,2
	MOV AL, DH     ;NUMBER SECTOR TO READ
	MOV CL, 0X02   ;SECTOR INDEX
	MOV CH, 0X00   ;CYLINDER NUMBER
	MOV DH, 0X00   ;HEAD NUMBER

	INT 0X13
	JC .DISK_ERROR

	POP DX
	CMP AL, DH
	JNE .SECTORS_ERROR

	POPA
	RET

.DISK_ERROR:
	MOV DH, AH
	CALL PRINT_WORD
	MOV BX, .DISK_ERRMSG
	CALL PRINT
	CALL PRINT_NL

	JMP .DISK_DIE

.SECTORS_ERROR:
	MOV DL, AL
	CALL PRINT_WORD
	MOV BX, .SECTORS_ERRMSG
	CALL PRINT
	CALL PRINT_NL

.DISK_DIE:

	JMP $

.DISK_ERRMSG: DB " disk read error", 0X00
.SECTORS_ERRMSG: DB " sector read error", 0X00
