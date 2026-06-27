include $(MAKE_UTILS)/Makefile.defs

TARGET := tty_dev_tests

CSRCS := \
	tty_dev_tests.c

CFLAGS += \
	-DTTY_ASYNC_LOW_LATENCY \
	-I$(CURDIR)/../include \
	-I$(INSTALL_DIR)/include \
	-I$(INSTALL_DIR)/include/utest \
	-Wno-unused-function

LDFLAGS += \
	-L$(INSTALL_DIR)/lib \
	-Wl,-rpath,$(INSTALL_DIR)/lib \
	-lpthread \
	-lrt \
	-ltty_util

include $(MAKE_UTILS)/Makefile.rules

run: install
	$(INSTALL_DIR)/bin/$(TARGET)
