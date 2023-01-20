top_srcdir = ..
include $(top_srcdir)/config.mak

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
