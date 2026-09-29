#define MAX_COLS 80
#define MAX_ROWS 25

#include <drivers/vgaconsole.h>
#include <drivers/ports.h>

static char* vga_memory = (char*) 0xb8000;

int VGAGetCursor(void)
{
	int pos = 0;

	PortOutB(VGA_REG_CTRL, 14);
	pos = PortInB(VGA_REG_DATA) << 8;  //move to high byte

	PortOutB(VGA_REG_CTRL, 15);
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

void VGAPut(int c, int col, int row, char attr)
{
	int offset = VGAGetOffset(col, row);
	vga_memory[offset] = c;
	vga_memory[offset+1] = attr ? attr : WHITE_ON_BLACK;

}

void VGAPutsAt(const char* s, int at)
{
	int col = VGAGetOffsetCol(at);
	int row = VGAGetOffsetRow(at);

	for (const char *p = s; *p; ++p) {
		if (*p == '\n') {
			col = 0;
			row++;
			continue;
		}

		VGAPut((int)*p, col, row, WHITE_ON_BLACK);
		col++;
	}

	//TODO: Add control with global vga flags to puts without moving cursor position
	VGASetCursor(col, row);
}

void VGAPuts(const char *s)
{
	VGAPutsAt(s, VGAGetCursor());
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
