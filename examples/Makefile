GNAT = m68k-atari-mint-gnatmake -I../src -gnatwa
GNATCFLAGS = -cargs -O2 -g

all:: hello hellogem eyes

hello: hello.adb
	$(GNAT) $< $(GNATCFLAGS)

hellogem: hellogem.adb ../src/libgem.a
	$(GNAT) $< $(GNATCFLAGS)

eyes: eyes.adb ../src/libgem.a
	$(GNAT) $< $(GNATCFLAGS)

../src/libgem.a::
	$(MAKE) -C ../src

clean::
	$(MAKE) -C ../src clean
	rm -f *.o *.ali eyes hello hellogem
