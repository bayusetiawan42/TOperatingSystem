CC = i386-elf-gcc
LD = i386-elf-ld
QEMU = qemu-system-i386

#***********************************************
#Build kernels

KERNEL_OFFSET = 0x1000 #I dont know why someone need to change it

KERNEL_SOURCES = kernel/kernel.c
DRIVERS_SOURCES = drivers/ports.c drivers/vgaconsole.c

DRIVERS_OBJECTS = $(DRIVERS_SOURCES:.c=.o)
KERNEL_OBJECTS = $(KERNEL_SOURCES:.c=.o)

kernel_entry.o: boot/kernel_entry.asm
	nasm $< -o $@  -f elf

#Always link kernel_entry.o as the first perequiretes so it can call KMain() correctly
kernel.bin: kernel_entry.o $(KERNEL_OBJECTS) $(DRIVERS_OBJECTS)
	$(LD) -o $@ -Ttext $(KERNEL_OFFSET) $^ --oformat binary

%.o: %.c
	$(CC)  -ffreestanding -o $@ -c $< -I.

kernel.img: boot.bin kernel.bin
	cat $^ > kernel.img

#***********************************************
#Build bootsector

boot.bin: boot/boot.asm boot/disk.asm boot/gdt.asm boot/print.asm boot/switch32.asm
	nasm $< -o $@  -f bin

#***********************************************
#Scripts
.PHONY: clean qemu
clean:
	rm -f kernel_entry.o $(KERNEL_OBJECTS) $(DRIVERS_OBJECTS) kernel.img boot.bin kernel.bin

qemu: kernel.img
	$(QEMU) -fda $<
