#define MAX_COLS 80
#define MAX_ROWS 25

#include <kernel/utils.h>
#include <drivers/vgacon.h>
#include <drivers/ports.h>


enum
{
	VGA_REG_CTRL = 0x3d4,   //CONTROLS
	VGA_REG_DATA = 0x3d5,   //DATA / Output
} VGA_Registers;

static char* vga_memory = (char*) 0xb8000;
//TODO: Add vga_attr as last attribute than setting manually in function:
//      Set in codes \#<color_codes>
//      Set in codes \#0 reset color to WHITE_ON_BLACK

int VGAGetCursor(void)
{
	int pos = 0;

	PortOutB(VGA_REG_CTRL, 14);         //14 request high byte
	pos = PortInB(VGA_REG_DATA) << 8;   //move to high byte

	PortOutB(VGA_REG_CTRL, 15);         //15 request low byte
	pos += PortInB(VGA_REG_DATA);
	return pos * 2;
}

void VGASetCursor(int col, int row)
{
	int offset = VGAGetOffset(col, row) / 2;

	PortOutB(VGA_REG_CTRL, 14);
	PortOutB(VGA_REG_DATA, (unsigned char)(offset >> 8));
	PortOutB(VGA_REG_CTRL, 15);
	PortOutB(VGA_REG_DATA, (unsigned char)(offset & 0x00ff));
}

void VGAScroll(int n)
{
	int cursor = VGAGetCursor();

	for (int i = 0; i < n; i++)
		for (int j = 0; j < MAX_ROWS; j++)
			memcpy(vga_memory + VGAGetOffset(0, j-1), vga_memory + VGAGetOffset(0, j), MAX_COLS * 2);

	VGASetCursor(VGAGetOffsetCol(cursor), VGAGetOffsetRow(cursor) - n);
}

void VGAPut(char c, int col, int row, char attr)
{
	if (col > MAX_COLS || row > MAX_ROWS)
		return;

	int offset = VGAGetOffset(col, row);
	vga_memory[offset] = c;
	vga_memory[offset+1] = attr ? attr : WHITE_ON_BLACK;
}

void VGAPutc(char c, int col, int row, char attr)
{
	if (col >= MAX_COLS && row >= MAX_ROWS)
		VGAScroll(1);

	if (c == '\n' || col >= MAX_COLS) {
		VGASetCursor(0, row+1);
		return;
	}

	VGAPut(c, col, row, attr);
	VGASetCursor(col+1, row);
}

void VGAPutchar(char c, char attr)
{
	int cursor = VGAGetCursor();
	VGAPutc(c, VGAGetOffsetCol(cursor), VGAGetOffsetRow(cursor), WHITE_ON_BLACK);
}

void VGAPuts(const char *s)
{
	for (const char *p = s; *p; p++)
		VGAPutchar(*p, WHITE_ON_BLACK);
}

void VGAClear(void)
{
	int len = MAX_ROWS * MAX_COLS * 2;

	for (int i = 0; i < len; i += 2) {
		vga_memory[i] = 0x00;
		vga_memory[i+1] = WHITE_ON_BLACK;
	}

	VGASetCursor(0, 0);
}

int VGAGetOffset(int col, int row)
{
	return (row * MAX_COLS + col) * 2;
}

int VGAGetOffsetRow(int offset)
{
	return offset / (2 * MAX_COLS);
}

int VGAGetOffsetCol(int offset)
{
	return (offset - (VGAGetOffsetRow(offset) * 2 * MAX_COLS)) / 2;
}
