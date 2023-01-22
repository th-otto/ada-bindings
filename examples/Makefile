top_srcdir = ..
include $(top_srcdir)/config.mak

all:: hello.prg hellogem.prg eyes.prg wdlgdemo.prg

hello.prg: hello.adb
	$(GNAT) $< -o $@ $(GNATCFLAGS) $(GNATLDFLAGS)

hellogem.prg: hellogem.adb ../src/libgem.a
	$(GNAT) $< -o $@ $(GNATCFLAGS) $(GNATLDFLAGS)

eyes.prg: eyes.adb ../src/libgem.a
	$(GNAT) $< -o $@ $(GNATCFLAGS) $(GNATLDFLAGS)

wdlgdemo.prg: wdlgdemo.adb wdlgdemo_resource.ads wdlgdemo_callbacks.adb wdlgdemo_callbacks.ads ../src/libgem.a
	$(GNAT) $< -o $@ $(GNATCFLAGS) $(GNATLDFLAGS)

../src/libgem.a::
	$(MAKE) -C ../src

clean::
	$(MAKE) -C ../src clean
	rm -f *.o *.ali *.prg
