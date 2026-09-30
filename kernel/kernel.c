#include <drivers/ports.h>
#include <drivers/vgacon.h>

void int_to_ascii(int n, char str[]) {
    int i, sign;
    if ((sign = n) < 0) n = -n;
    i = 0;
    do {
        str[i++] = n % 10 + '0';
    } while ((n /= 10) > 0);

    if (sign < 0) str[i++] = '-';
    str[i] = '\0';

    /* TODO: implement "reverse" */
}

void KMain()
{
	VGAClear();

	for (int i = 0; i < 20; i++) {
		char s[12];
		int_to_ascii(i, s);
		VGAPuts(s);
		VGAPutchar('\n',0x0f);
	}

	VGAPuts("Hello world\n");
	VGAPuts("Kernel booted.\nTerry\nDavis.\nYe\n");
	VGAPuts("This is a very very very long long long long omg text idk generalpurposeregister general abc rockncrool crocodile abcn\ntext2");
	VGAScroll(2);
}
