GNAT = m68k-atari-mint-gnatmake -I../src -gnatwa
GNATCFLAGS = -cargs  -O2 -g

DEPS = \
	../src/atari-aes.adb \
	../src/atari-aes.ads \
	../src/atari-vdi.adb \
	../src/atari-vdi.ads \
	../src/atari.adb \
	../src/atari.ads \
	$(empty)

all:: hello hellogem eyes

hello: hello.adb
	$(GNAT) $< $(GNATCFLAGS)

hellogem: hellogem.adb $(DEPS)
	$(GNAT) $< $(GNATCFLAGS)

eyes: eyes.adb $(DEPS)
	$(GNAT) $< $(GNATCFLAGS)

clean::
	rm -f *.o *.ali eyes hello hellogem
