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

//Characters
void VGAPut(int c, int col, int row, char attr);         //Direct put character at col,row with attr(ibute)
void VGAPutsAt(const char* s, int at);                   //Puts list of characters starting from at
void VGAPuts(const char *s);                             //Puts list of characters at current cursor position

//Screen
void VGAClear(void);                                     //Clears the VGA screen

//Cursor
int VGAGetCursor(void);                                  //Get logical cursor position
void VGASetCursor(int col, int row);                     //Set cursor physical position

//Misc.
int VGAGetOffset(int col, int row);                      //Get logical offset position from col,row
int VGAGetOffsetRow(int offset);                         //Get physical row position from logical offset
int VGAGetOffsetCol(int offset);                         //Get physical col position from logical offset

#endif
