CROSS = m68k-atari-mint-
GNAT = $(CROSS)gnatmake -I$(top_srcdir)/src -gnatwa -gnatn1
AR = $(CROSS)ar
GNATCFLAGS = -cargs -O2
ifeq ($(CROSS),m68k-atari-mintelf-)
GNATCFLATS += -ffunction-sections -fdata-sections
endif
GNATLDFLAGS = -largs -Wl,--gc-sections

all::

.adb.o:
	$(GNAT) -c $< -o $@ $(GNATCFLAGS)

