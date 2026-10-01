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

	VGASetAttr(0x8f);
	for (int i = 1; i <= 50; i++) {
		char s[256];
		int_to_ascii(i, s);
		VGAPuts(s);
		VGAPutChar('\n');
	}

	VGASetAttr(WHITE_ON_BLACK);
	VGAPuts("Hello world\n");
	VGAPuts("Kernel booted.\n");

	VGASetAttr(0x3f);
	VGAPuts("Hello terry davis!\n");
	VGASetAttr(WHITE_ON_BLACK);

	VGAPuts("This is a very very very long long long long omg text idk generalpurposeregister general abc rockncrool crocodile abcn.\n");
	VGAPuts("Text2 test uhuy.!\n");
	VGAPuts("END");
	VGAScroll(3);
}
