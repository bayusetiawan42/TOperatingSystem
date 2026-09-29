#include <drivers/ports.h>
#include <drivers/vgaconsole.h>

void KMain()
{
	VGAClear();
	VGAPuts("Hello world\n");
	VGAPuts("Kernel booted.\nTerry\nDavis.\nYe\n");
	VGAPuts("This is a very very very long long long long omg text idk generalpurposeregister general abc rockncrool crocodile abcn\ntext2");
}
