#ifndef _VGACONSOLE_H
#define _VGACONSOLE_H

//0x3d4
//  14     High byte cursor/horizontal
//  15     Low byte cursor/horizontal
enum {
	VGA_REG_CTRL = 0x3d4,  //CONTROLS
	VGA_REG_DATA = 0x3d5,  //DATA / Output
} VGA_Registers;

#define WHITE_ON_BLACK 0x0f

void VGAPut(int c, int col, int row, char attr);

void VGAPutsAt(const char* s, int at);
void VGAPuts(const char *s);

int VGAGetCursor(void);
void VGASetCursor(int col, int row);

int VGAGetOffset(int col, int row);
int VGAGetOffsetRow(int offset);
int VGAGetOffsetCol(int offset);

#endif
