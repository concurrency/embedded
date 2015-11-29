CC = avr-gcc
CFLAGS = -Os -mcall-prologues
LDFLAGS = -Llibtvm
LIBS = -ltvm -lm
OBJCOPY = avr-objcopy

TVMFLAGS = 	-DTVM_WORD_LENGTH=2 \
						-DF_CPU=16000000UL \
						-Datmega328p \
						-mmcu=atmega328p \
						-DBYTECODE_ADDR=0x4F00 \
						-I. \
						-I../../runtime \
						-I/usr/lib/avr/include/avr

FIRMWARE = \
	ffi.o \
	interrupts.o \
	serial.o \
	time.o \
	tbc.o \
	tvm.o


TARGET = firmware

firmware.hex: firmware
	$(OBJCOPY) -O ihex -R .eeprom firmware firmware.hex

%.o: %.c
	$(CC) $(CFLAGS) $(TVMFLAGS) -c $< -o $@ $(LDFLAGS) $(LIBS)

$(TARGET) : $(FIRMWARE)
	avr-gcc -mmcu=atmega328p \
					-I. \
					-I../../runtime \
					-L../../runtime \
					-ltvm -lm \
					ffi.o interrupts.o serial.o time.o tbc.o tvm.o \
					-o firmware \
					-ltvm
	avr-strip $(TARGET)
	echo "Done"

.PHONY: clean
clean:
	rm -f *.o
	rm -f *.old
	echo "Squeaky Clean"
