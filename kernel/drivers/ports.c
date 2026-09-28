#include <kernel/drivers/ports.h>

U8 PortInB(U16 port)
{
	U8 result;
	__asm__("in %%dx, %%al" : "=a" (result) : "d" (port));
	return result;
}

void PortOutB(U16 port, U8 data)
{
	__asm__("out %%al, %%dx" : "a" (data) : "d" (port) );
}

U16 PortInW(U16 port)
{
	U16 result;
	__asm__("in %%dx, %%ax" : "=a" (result) : "d" (port));
	return result;
}

void PortOutW(U16 port, U16 data)
{
	__asm__("out %%ax, %%dx" : "a" (data) : "d" (port) );
}

