top_srcdir = ..
include $(top_srcdir)/config.mak

all:: libgem.a

OBJS = \
	atari.o \
	atari-aes.o \
	atari-aes-application.o \
	atari-aes-event.ali \
	atari-aes-menu.o \
	atari-aes-objects.o \
	atari-aes-form.o \
	atari-aes-graf.o \
	atari-aes-scrap.ali \
	atari-aes-filesel.ali \
	atari-aes-window.ali \
	atari-aes-resource.ali \
	atari-aes-shell.ali \
	atari-aes-extensions.o \
	atari-aes-wdialog.o \
	atari-aes-fslx.o \
	atari-aes-fontsel.o \
	atari-aes-listbox.o \
	atari-aes-pdlg.o \
	atari-aes-edit.o \
	atari-vdi.o \
	atari-vdi-nvdi.o \
	atari-gemdos.o \
	atari-bios.o \
	atari-xbios.o \
	$(empty)

libgem.a: $(OBJS)
	@$(RM) $@
	$(AR) rcs $@ $(OBJS)

atari.o: atari.adb atari.ads
	$(GNAT) -c $< -o $@ $(GNATCFLAGS)

atari-aes.o: atari-aes.adb atari-aes.ads atari.ads
	$(GNAT) -c $< -o $@ $(GNATCFLAGS)

atari-aes-application.o: atari-aes-application.adb atari-aes-application.ads atari-aes.ads atari.ads
	$(GNAT) -c $< -o $@ $(GNATCFLAGS)

atari-aes-event.ali: atari-aes-event.ads atari-aes.ads atari.ads
	$(GNAT) -c $< -o $@ $(GNATCFLAGS)

atari-aes-menu.o: atari-aes-menu.adb atari-aes-menu.ads atari-aes.ads atari.ads
	$(GNAT) -c $< -o $@ $(GNATCFLAGS)

atari-aes-objects.o: atari-aes-objects.adb atari-aes-objects.ads atari-aes.ads atari.ads
	$(GNAT) -c $< -o $@ $(GNATCFLAGS)

atari-aes-form.o: atari-aes-form.adb atari-aes-form.ads atari-aes.ads atari.ads
	$(GNAT) -c $< -o $@ $(GNATCFLAGS)

atari-aes-graf.o: atari-aes-graf.adb atari-aes-graf.ads atari-aes.ads atari.ads
	$(GNAT) -c $< -o $@ $(GNATCFLAGS)

atari-aes-scrap.ali: atari-aes-scrap.ads atari-aes.ads atari.ads
	$(GNAT) -c $< -o $@ $(GNATCFLAGS)

atari-aes-filesel.ali: atari-aes-filesel.ads atari-aes.ads atari.ads
	$(GNAT) -c $< -o $@ $(GNATCFLAGS)

atari-aes-window.ali: atari-aes-window.ads atari-aes.ads atari.ads
	$(GNAT) -c $< -o $@ $(GNATCFLAGS)

atari-aes-resource.ali: atari-aes-resource.adb atari-aes-resource.ads atari-aes.ads atari.ads
	$(GNAT) -c $< -o $@ $(GNATCFLAGS)

atari-aes-shell.ali: atari-aes-shell.ads atari-aes.ads atari.ads
	$(GNAT) -c $< -o $@ $(GNATCFLAGS)

atari-aes-extensions.o: atari-aes-extensions.adb atari-aes-extensions.ads atari-aes.ads atari.ads
	$(GNAT) -c $< -o $@ $(GNATCFLAGS)

atari-aes-wdialog.o: atari-aes-wdialog.adb atari-aes-wdialog.ads atari-aes.ads atari.ads
	$(GNAT) -c $< -o $@ $(GNATCFLAGS)

atari-aes-fslx.o: atari-aes-fslx.adb atari-aes-fslx.ads atari-aes.ads atari.ads
	$(GNAT) -c $< -o $@ $(GNATCFLAGS)

atari-aes-fontsel.o: atari-aes-fontsel.adb atari-aes-fontsel.ads atari-aes.ads atari.ads
	$(GNAT) -c $< -o $@ $(GNATCFLAGS)

atari-aes-listbox.o: atari-aes-listbox.adb atari-aes-listbox.ads atari-aes.ads atari.ads
	$(GNAT) -c $< -o $@ $(GNATCFLAGS)

atari-aes-pdlg.o: atari-aes-pdlg.adb atari-aes-pdlg.ads atari-aes.ads atari.ads
	$(GNAT) -c $< -o $@ $(GNATCFLAGS)

atari-aes-edit.o: atari-aes-edit.adb atari-aes-edit.ads atari-aes.ads atari.ads
	$(GNAT) -c $< -o $@ $(GNATCFLAGS)

atari-vdi.o: atari-vdi.adb atari-vdi.ads atari.ads
	$(GNAT) -c $< -o $@ $(GNATCFLAGS)

atari-vdi-nvdi.o: atari-vdi-nvdi.adb atari-vdi-nvdi.ads atari-vdi.ads atari.ads
	$(GNAT) -c $< -o $@ $(GNATCFLAGS)

atari-gemdos.o: atari-gemdos.adb atari-gemdos.ads atari.ads
	$(GNAT) -c $< -o $@ $(GNATCFLAGS)

atari-bios.o: atari-bios.adb atari-bios.ads atari.ads
	$(GNAT) -c $< -o $@ $(GNATCFLAGS)

atari-xbios.o: atari-xbios.adb atari-xbios.ads atari.ads
	$(GNAT) -c $< -o $@ $(GNATCFLAGS)

clean::
	rm -f *.o *.ali
