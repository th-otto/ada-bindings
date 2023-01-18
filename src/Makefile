CROSS = m68k-atari-mint-
GNAT = $(CROSS)gnatmake -I../src -gnatwa
AR = $(CROSS)ar
GNATCFLAGS = -cargs -O2 -g

.adb.o:
	$(GNAT) -c $< -o $@ $(GNATCFLAGS)

all:: libgem.a

OBJS = \
	atari.o \
	atari-aes.o \
	atari-vdi.o \
	atari-vdi-nvdi.o \
	$(empty)

libgem.a: $(OBJS)
	@$(RM) $@
	$(AR) rcs $@ $(OBJS)

atari.o: atari.adb atari.ads
	$(GNAT) -c $< -o $@ $(GNATCFLAGS)

atari-aes.o: atari-aes.adb atari-aes.ads atari.ads
	$(GNAT) -c $< -o $@ $(GNATCFLAGS)

atari-vdi.o: atari-vdi.adb atari-vdi.ads atari.ads
	$(GNAT) -c $< -o $@ $(GNATCFLAGS)

atari-vdi-nvdi.o: atari-vdi-nvdi.adb atari-vdi-nvdi.ads atari-vdi.ads atari.ads
	$(GNAT) -c $< -o $@ $(GNATCFLAGS)

clean::
	rm -f *.o *.ali
