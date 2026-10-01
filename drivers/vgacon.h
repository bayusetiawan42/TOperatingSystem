#ifndef _VGACONSOLE_H
#define _VGACONSOLE_H

#define WHITE_ON_BLACK 0x0f

//Characters
void VGAPut(char c, int col, int row, char attr);        //Direct put character at col,row with attr(ibute)   (limited, pixel like doesn't set cursor)
void VGAPutC(char c, int col, int row, char attr);       //Put character starting from col,row.  sets cursor
void VGAPutChar(char c, char attr);                      //Put character starting from current cursor position.  sets cursor
void VGAPuts(const char *s);                             //Puts list of characters at current cursor position.  sets cursor

//Screen
void VGAClear(void);                                     //Clears the VGA screen
void VGAScroll(int n);                                   //Scroll screen N times

//Cursor
int VGAGetCursor(void);                                  //Get logical cursor position
void VGASetCursor(int col, int row);                     //Set cursor physical position

//Misc.
int VGAGetOffset(int col, int row);                      //Get logical offset position from col,row
int VGAGetOffsetRow(int offset);                         //Get physical row position from logical offset
int VGAGetOffsetCol(int offset);                         //Get physical col position from logical offset

#endif
