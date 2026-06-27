include $(MAKE_UTILS)/Makefile.defs

TARGET := libtty_util

CSRCS := \
	src/buf.c \
	src/gnu.c \
	src/log.c \
	src/time_util.c \
	src/tty.c \
	src/tty_pair.c \
	src/util.c

PUBLIC_HEADERS := include/public/tty_util

CFLAGS += \
	-I$(CURDIR)/include \
	-I$(CURDIR)/include/public \
	-Wno-unused-function

include $(MAKE_UTILS)/Makefile.a_rules
