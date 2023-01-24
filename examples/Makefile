top_srcdir = ..
include $(top_srcdir)/config.mak

all:: hello.tos hellogem.prg eyes.prg wdlgdemo.prg gemwin.prg clock.prg

hello.tos: hello.adb
	$(GNAT) $< -o $@ $(GNATCFLAGS) $(GNATLDFLAGS)

hellogem.prg: hellogem.adb ../src/libgem.a
	$(GNAT) $< -o $@ $(GNATCFLAGS) $(GNATLDFLAGS)

eyes.prg: eyes.adb ../src/libgem.a
	$(GNAT) $< -o $@ $(GNATCFLAGS) $(GNATLDFLAGS)

wdlgdemo.prg: wdlgdemo.adb wdlgdemo_resource.ads adaptrsc.adb adaptrsc.ads ../src/libgem.a
	$(GNAT) $< -o $@ $(GNATCFLAGS) $(GNATLDFLAGS)

gemwin.prg: gemwin.adb ../src/libgem.a
	$(GNAT) $< -o $@ $(GNATCFLAGS) $(GNATLDFLAGS)

clock.prg: clock.adb ../src/libgem.a
	$(GNAT) $< -o $@ $(GNATCFLAGS) $(GNATLDFLAGS)

../src/libgem.a::
	$(MAKE) -C ../src

clean::
	$(MAKE) -C ../src clean
	rm -f *.o *.ali *.prg
