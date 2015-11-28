CC = avr-gcc
CFLAGS = -Os

TVMFLAGS = 	-DF_CPU=16000000UL \
						-mmcu=atmega328p \
						-DTVM_WORD_LENGTH=2 \
						-DTVM_INTERNALS \
						-DTVM_DISPATCH_SWITCH \
						-DTVM_EMULATE_T2 \
						-DTVM_LITTLE_ENDIAN \
						-DTVM_MEM_INTF_AVR \
						-DTVM_PACKED_ECTX \
						-DTVM_OS_NONE \
						-DTVM_USE_INLINE \
						-I.

OBJECTS = 	ins_pri.o \
						ins_sec.o

TARGET = libtvm.a

%.o: %.c
	$(CC) $(CFLAGS) $(TVMFLAGS) -c $< -o $@

$(TARGET): $(OBJECTS)

.PHONY: clean
clean:
	rm -f *.o
	rm -f *.old
	rm -f *.gch
	rm -f libtvm.a
	echo "Squeaky Clean"
