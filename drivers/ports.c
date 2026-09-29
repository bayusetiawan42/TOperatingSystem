#include <drivers/ports.h>

unsigned char PortInB(unsigned short port)
{
	unsigned char result;

	__asm__(
	"in %%dx, %%al"
		: "=a" (result)
		: "d" (port)
	);

	return result;
}

void PortOutB(unsigned short port, unsigned char data)
{
	__asm__(
	"out %%al, %%dx"
		:
		: "a" (data), "d" (port)
	);
}

unsigned short PortInW(unsigned short port)
{
	unsigned short result;

	__asm__(
	"in %%dx, %%ax"
		: "=a" (result)
		: "d" (port)
	);

	return result;
}

void PortOutW(unsigned short port, unsigned short data)
{
	__asm__(
	"out %%ax, %%dx"
		:
		: "a" (data), "d" (port)
	);
}

