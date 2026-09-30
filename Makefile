CC = i386-elf-gcc
LD = i386-elf-ld
QEMU = qemu-system-i386
BOCHS = bochs

.DEFAULT_GOAL := kernel.img

COMMON_CFLAGS = -O2 -ffreestanding -nostdlib

#***********************************************
#Build kernels

KERNEL_OFFSET = 0x1000 #I dont know why someone need to change it

KERNEL_SOURCES = kernel/kernel.c kernel/utils.c
KERNEL_ASM = 

DRIVERS_SOURCES = drivers/vgacon.c
DRIVERS_ASM = drivers/ports.asm

KERNEL_OBJECTS = $(KERNEL_SOURCES:.c=.o) $(KERNEL_ASM:.asm=.o) 
DRIVERS_OBJECTS = $(DRIVERS_SOURCES:.c=.o) $(DRIVERS_ASM:.asm=.o)

boot/kernel_entry.o: boot/kernel_entry.asm

%.o: %.c
	$(CC) $(COMMON_CFLAGS) -o $@ -c $< -I.

%.o: %.asm
	nasm -f elf $< -o $@

#Always link kernel_entry.o as first to prevent failed to boot from disk
kernel.bin: boot/kernel_entry.o $(KERNEL_OBJECTS) $(DRIVERS_OBJECTS)
	$(LD) -o $@ -Ttext $(KERNEL_OFFSET) $^ --oformat binary

kernel.img: boot.bin kernel.bin
	cat $^ > kernel.img

#***********************************************
#Build bootsector

boot.bin: boot/boot.asm boot/disk.asm boot/gdt.asm boot/print.asm boot/switch32.asm
	nasm $< -o $@  -f bin

#***********************************************
#Scripts
.PHONY: clean qemu bochs
clean:
	rm -f $(KERNEL_OBJECTS) $(DRIVERS_OBJECTS) kernel.img boot.bin kernel.bin boot/kernel_entry.o

qemu: kernel.img
	$(QEMU) -fda $<

bochs: kernel.img bochsrc
	$(BOCHS)
