#include <drivers/ports.h>
#include <drivers/vgaconsole.h>

void KMain()
{
	VGAClear();
	VGAPuts("Hello world\n");
	VGAPuts("Kernel booted.\nTerry\nDavis.\nYe");
}
