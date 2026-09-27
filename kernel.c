#define VGA_MEMORY 0xb8000

void KMain()
{
	char* VGAMem = (char *) VGA_MEMORY;
	*VGAMem = 'N';
}
