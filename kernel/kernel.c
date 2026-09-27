char* VGAMem = (char *) 0xb8000;

void vga_print(char* str)
{
	while (*str) {
		*VGAMem++ = *str++;
		*VGAMem++ = 0x0f;  /* white on black */
	}
}

void KMain()
{
	vga_print("Hello world");
}
