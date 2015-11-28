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

OBJECTS = 	ins_alt.o \
						ins_chan.o \
						ins_barrier.o \
						ins_pri.o \
						ins_proc.o \
						ins_sec.o \
						ins_t800.o \
						ins_timer.o \
						jumptbl_pri.o \
						jumptbl_sec.o \
						instructions.o \
						interpreter.o \
						mem.o \
						mem_avr.o \
						scheduler.o


TARGET = libtvm.a

%.o: %.c
	$(CC) $(CFLAGS) $(TVMFLAGS) -c $< -o $@

$(TARGET): $(OBJECTS)
	avr-ar rcs  $(TARGET) $(OBJECTS)
	avr-strip $(TARGET)

.PHONY: clean
clean:
	rm -f *.o
	rm -f *.old
	rm -f *.gch
	rm -f libtvm.a
	echo "Squeaky Clean"
