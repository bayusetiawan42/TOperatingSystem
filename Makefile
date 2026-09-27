GCC = i386-elf-gcc
LD = i386-elf-ld
QEMU = qemu-system-i386

KERNEL_OFFSET = 0x1000

kernel_entry.o: kernel_entry.asm
	nasm $< -o $@  -f elf

kernel.o: kernel.c
	$(GCC) -ffreestanding -c $< -o  $@

kernel.bin: kernel_entry.o kernel.o
	$(LD) -o $@ -Ttext $(KERNEL_OFFSET) $^ --oformat binary

boot.bin: boot.asm disk.asm gdt.asm print.asm switch32.asm
	nasm $< -o $@  -f bin

.PHONY: clean qemu image
clean:
	rm -f *.bin *.o os-image

qemu: os-image
	$(QEMU) -fda $<

image: os-image

os-image: boot.bin kernel.bin
	cat $^ > os-image
