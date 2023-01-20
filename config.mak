CROSS = m68k-atari-mint-
GNAT = $(CROSS)gnatmake -I$(top_srcdir)/src -gnatwa
AR = $(CROSS)ar
GNATCFLAGS = -cargs -O2 -g

all::

.adb.o:
	$(GNAT) -c $< -o $@ $(GNATCFLAGS)

