top_srcdir = ..
include $(top_srcdir)/config.mak

all:: libgem.a

OBJS = \
	atari.o \
	atari-aes.o \
	atari-aes-form.ali \
	atari-aes-appl.ali \
	atari-aes-event.ali \
	atari-aes-extensions.o \
	atari-aes-wdialog.o \
	atari-aes-fslx.o \
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

atari-aes-form.ali: atari-aes-form.ads atari-aes.ads atari.ads
	$(GNAT) -c $< -o $@ $(GNATCFLAGS)

atari-aes-appl.ali: atari-aes-appl.ads atari-aes.ads atari.ads
	$(GNAT) -c $< -o $@ $(GNATCFLAGS)

atari-aes-event.ali: atari-aes-event.ads atari-aes.ads atari.ads
	$(GNAT) -c $< -o $@ $(GNATCFLAGS)

atari-aes-extensions.o: atari-aes-extensions.adb atari-aes-extensions.ads atari-aes.ads atari.ads
	$(GNAT) -c $< -o $@ $(GNATCFLAGS)

atari-aes-wdialog.o: atari-aes-wdialog.adb atari-aes-wdialog.ads atari-aes.ads atari.ads
	$(GNAT) -c $< -o $@ $(GNATCFLAGS)

atari-aes-fslx.o: atari-aes-fslx.adb atari-aes-fslx.ads atari-aes.ads atari.ads
	$(GNAT) -c $< -o $@ $(GNATCFLAGS)

atari-vdi.o: atari-vdi.adb atari-vdi.ads atari.ads
	$(GNAT) -c $< -o $@ $(GNATCFLAGS)

atari-vdi-nvdi.o: atari-vdi-nvdi.adb atari-vdi-nvdi.ads atari-vdi.ads atari.ads
	$(GNAT) -c $< -o $@ $(GNATCFLAGS)

clean::
	rm -f *.o *.ali
