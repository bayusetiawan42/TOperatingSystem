GCC = i386-elf-gcc
LD = i386-elf-ld
QEMU = qemu-system-i386

KERNEL_OFFSET = 0x1000

kernel.o:
	$(GCC) -ffreestanding -c kernel.c -o  $@

kernel.bin: kernel.o
	$(LD) -o $@ -Ttext $(KERNEL_OFFSET) $^ --oformat binary

boot.bin: boot.asm disk.asm gdt.asm print.asm switch32.asm
	nasm $< -o $@

.PHONY: clean qemu image
clean:
	rm -f *.bin *.o

qemu: os-image
	$(QEMU)  -kernel $<

image: os-image

os-image: boot.bin kernel.bin
	cat $^ > os-image
