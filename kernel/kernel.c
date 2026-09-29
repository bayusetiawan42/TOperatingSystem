#include <drivers/ports.h>

char* vga_memory = (char*) 0xb8000;

void VGAPutc(int at, char c, char attr)
{
	vga_memory[at] = c;
	vga_memory[at+1] = attr ? attr : 0x0f;
}

//Get current cursor position
int VGAGetCursor()
{
	int pos = 0;

	//Requests high byte and low byte in input 0x3d4
	//output are in 0x3d5, High = 14, low = 15
	PortOutB(0x3d4, 14);
	pos = PortInB(0x3d5); 

	//0000000010111100

	pos <<= 8; //move to high byte with 1 byte left shitf

	PortOutB(0x3d4, 15);
	pos += PortInB(0x3d5);

	pos *= 2;  //c+attr 2 byte

	return pos;
}

/*
void VGAPrint(char* str)
{
	int at = VGAGetCursor();

	while (*str) {
		VGAPutc(at, *str++, 0x0f);
		
	}
}
*/

void KMain()
{
	//VGAPrint("Hello world");
	VGAPutc(VGAGetCursor()+4, 'X', 0x0f);
}
