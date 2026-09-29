#ifndef _PORTS_H
#define _PORTS_H

unsigned char PortInB(unsigned short port);
void PortOutB(unsigned short port, unsigned char data);

unsigned short PortInW(unsigned short port);
void PortOutW(unsigned short port, unsigned short data);

#endif
