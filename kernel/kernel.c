#include <kernel/drivers/ports.h>

char* VGAMem = (char *) 0xb8000;

void VGAPrint(char* str)
{
	while (*str) {
		*VGAMem++ = *str++;
		*VGAMem++ = 0x0f;
	}
}

void KMain()
{
	VGAPrint("Hello world");
	//PortInB(0x3f2);
	//PortOutB(0x3f2, 0b00001000);
}
