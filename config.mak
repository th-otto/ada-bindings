CROSS = m68k-atari-mint-
GNAT = $(CROSS)gnatmake -I$(top_srcdir)/src -gnatwa -gnatn1 -gnateE -we
AR = $(CROSS)ar
GNATCFLAGS = -cargs -O2 -Werror
GNATLDFLAGS =
ifneq ($(shell echo "" | $(CROSS)gcc -dM -E - | grep __ELF__),)
GNATCFLAGS += -ffunction-sections -fdata-sections
GNATLDFLAGS += -largs -Wl,--gc-sections
endif

all::

.adb.o:
	$(GNAT) -c $< -o $@ $(GNATCFLAGS)

