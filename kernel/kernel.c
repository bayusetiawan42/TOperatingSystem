char* VGAMem = (char *) 0xb8000;

void VGAPrint(char* str)
{
	while (*str) {
		*VGAMem++ = *str++;
		*VGAMem++ = 0x0f;  /* white on black */
	}
}

void KMain()
{
	VGAPrint("Hello world");
}
