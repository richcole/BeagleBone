ARMGNU = arm-linux-gnueabi

AOPS = --warn --fatal-warnings
COPS = -Wall -Werror -O2 -nostdlib -nostartfiles -ffreestanding 
BUILD_DIR = ./build

all: $(BUILD_DIR)/boot.bin $(BUILD_DIR)/serial

$(BUILD_DIR)/marker:
	mkdir -p build
	touch $(BUILD_DIR)/marker

$(BUILD_DIR)/boot.bin: boot.asm $(BUILD_DIR)/marker
	$(ARMGNU)-as boot.asm -o $(BUILD_DIR)/boot.o
	$(ARMGNU)-ld -T linker.ld $(BUILD_DIR)/boot.o -o $(BUILD_DIR)/boot.elf
	$(ARMGNU)-objcopy $(BUILD_DIR)/boot.elf -O binary $(BUILD_DIR)/boot.bin

$(BUILD_DIR)/serial: serial.c $(BUILD_DIR)/marker
	g++ -ggdb -o $(BUILD_DIR)/serial serial.c

bootstrap:
	sudo adduser $USER dialout
	sudo apt-get install gcc-4.4-arm-linux-gnueabi
	sudo modprobe ftdi_sio vendor=0x0403 product=0xa6d0

run: $(BUILD_DIR)/boot.bin $(BUILD_DIR)/serial
	$(BUILD_DIR)/serial

clean:
	rm -rf $(BUILD_DIR)

.PHONY: run boostrap build_dir clean
