[bits 32]
[extern KMain]
	; the reason we load KMain() here rather in START_32 is because
	; binary output format does not support external references

	call KMain
	jmp $
