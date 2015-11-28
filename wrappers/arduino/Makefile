CC = avr-gcc
CFLAGS = -Os
LDFLAGS = -Llibtvm
LIBS = -ltvm -lm
OBJCOPY = avr-objcopy

TVMFLAGS = 	-DF_CPU=16000000UL \
						-mmcu=atmega328p \
						-DBYTECODE_ADDR=0x4F00 \
						-I.

FIRMWARE = \
	ffi.o \
	interrupts.o \
	serial.o \
	tbc.o \
	time.o \
	tvm.o


TARGET = firmware

firmware.hex: firmware
	$(OBJCOPY) -O ihex -R .eeprom firmware firmware.hex

	%.o: %.c
		$(CC) $(CFLAGS) $(TVMFLAGS) -c $< -o $@ $(LDFLAGS) $(LIBS)

$(TARGET) : $(FIRMWARE)
