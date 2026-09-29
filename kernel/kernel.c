#include <drivers/ports.h>
#include <drivers/vgaconsole.h>

void KMain()
{
	VGAPuts("Hello world\n");
	VGAPuts("Kernel booted.\nTerry\nDavis.\nYe");
}
