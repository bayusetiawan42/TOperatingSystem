GCC = i386-elf-gcc
LD = i386-elf-ld
QEMU = qemu-system-i386

KERNEL_OFFSET = 0x1000

kernel_entry.o: boot/kernel_entry.asm
	nasm $< -o $@  -f elf

kernel.o: kernel/kernel.c
	$(GCC) -ffreestanding -c $< -o  $@  -I.

# Always link kernel_entry.o as the first perequiretes so it can call
# KMain() correctly
kernel.bin: kernel_entry.o kernel.o
	$(LD) -o $@ -Ttext $(KERNEL_OFFSET) $^ --oformat binary

boot.bin: boot/boot.asm boot/disk.asm boot/gdt.asm boot/print.asm boot/switch32.asm
	nasm $< -o $@  -f bin

.PHONY: clean qemu
clean:
	rm -f *.bin *.o kernel.img

qemu: kernel.img
	$(QEMU) -fda $<

kernel.img: boot.bin kernel.bin
	cat $^ > kernel.img
