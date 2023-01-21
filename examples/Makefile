top_srcdir = ..
include $(top_srcdir)/config.mak

all:: hello hellogem eyes

hello: hello.adb
	$(GNAT) $< $(GNATCFLAGS) $(GNATLDFLAGS)

hellogem: hellogem.adb ../src/libgem.a
	$(GNAT) $< $(GNATCFLAGS) $(GNATLDFLAGS)

eyes: eyes.adb ../src/libgem.a
	$(GNAT) $< $(GNATCFLAGS) $(GNATLDFLAGS)

../src/libgem.a::
	$(MAKE) -C ../src

clean::
	$(MAKE) -C ../src clean
	rm -f *.o *.ali eyes hello hellogem
