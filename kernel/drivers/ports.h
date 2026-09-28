#ifndef _PORTS_H
#define _PORTS_H

#include <kernel/types.h>

U8 PortInB(U16 port);
void PortOutB(U16 port, U8 data);

U16 PortInW(U16 port);
void PortOutW(U16 port, U16 data);

#endif
