#include <stdarg.h>

void die(const char* fmt, ...)
{
	va_list ap;
	va_start(ap, fmt);
	fprintf(stderr, "error: ");
	vfprintf(stderr, fmt, ap);
	fputc('\n', stderr);
	fflush(stderr);
	exit(1);
}
