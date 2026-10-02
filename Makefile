CC = i386-elf-gcc
LD = i386-elf-ld
QEMU = qemu-system-i386
BOCHS = bochs

.DEFAULT_GOAL := kernel.img

COMMON_CFLAGS = -O2 -ffreestanding -nostdlib

#***********************************************
#Build kernels

KERNEL_OFFSET = 0x1000 #I dont know why someone need to change it

KERNEL_SOURCES = Kernel/KMain.c Kernel/Utils.c
KERNEL_ASM = 

DRIVERS_SOURCES = Drivers/VGACon.c
DRIVERS_ASM = Drivers/Ports.asm

KERNEL_OBJECTS = $(KERNEL_SOURCES:.c=.o) $(KERNEL_ASM:.asm=.o) 
DRIVERS_OBJECTS = $(DRIVERS_SOURCES:.c=.o) $(DRIVERS_ASM:.asm=.o)

Boot/KEntry.o: Boot/KEntry.asm

%.o: %.c
	$(CC) $(COMMON_CFLAGS) -o $@ -c $< -I.

%.o: %.asm
	nasm -f elf $< -o $@

#Always link kernel_entry.o as first to prevent failed to boot from disk
kernel.bin: Boot/KEntry.o $(KERNEL_OBJECTS) $(DRIVERS_OBJECTS)
	$(LD) -o $@ -Ttext $(KERNEL_OFFSET) $^ --oformat binary

kernel.img: boot.bin kernel.bin
	cat $^ > kernel.img

#***********************************************
#Build bootsector

BOOT_SOURCES = Boot/Boot16.asm Boot/Boot32.asm Boot/Disk.asm Boot/GDT.asm Boot/PrtScr.asm

boot.bin: $(BOOT_SOURCES)
	nasm $< -o $@  -f bin

#***********************************************
#Scripts
.PHONY: clean qemu bochs
clean:
	rm -f $(KERNEL_OBJECTS) $(DRIVERS_OBJECTS) kernel.img boot.bin kernel.bin Boot/KEntry.o

qemu: kernel.img
	$(QEMU) -fda $<

bochs: kernel.img BochSrc
	$(BOCHS) -f BochSrc
