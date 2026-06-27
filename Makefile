$(if $(MAKE_UTILS),,$(error MAKE_UTILS is not defined))
$(if $(MODULES),,$(error MODULES is not defined))

REPO_ROOT := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))

BUILD_DIR   ?= $(REPO_ROOT)/build_dir/release
INSTALL_DIR ?= $(REPO_ROOT)/install_dir/release

.PHONY: all utest libtty_util tests run_tests tty_dev_tests

all: utest libtty_util

# install utest headers (header-only library)
utest:
	mkdir -p $(INSTALL_DIR)/include/utest
	cp $(MODULES)/utest/utest.h $(INSTALL_DIR)/include/utest/utest.h

# build and install libtty_util
libtty_util:
	$(MAKE) install -f $(REPO_ROOT)/libtty_util.Makefile \
		MAKE_UTILS=$(MAKE_UTILS) \
		MODULES=$(MODULES) \
		BUILD_DIR=$(BUILD_DIR) \
		INSTALL_DIR=$(INSTALL_DIR)

tty_dev_tests: all
	$(MAKE) install -C $(REPO_ROOT)/tests -f tty_dev_tests.mk \
		MAKE_UTILS=$(MAKE_UTILS) \
		BUILD_DIR=$(BUILD_DIR) \
		INSTALL_DIR=$(INSTALL_DIR)

tests: tty_dev_tests

# build and run all tests
run_tests: tests
	$(MAKE) run -C $(REPO_ROOT)/tests -f tty_dev_tests.mk \
		MAKE_UTILS=$(MAKE_UTILS) \
		BUILD_DIR=$(BUILD_DIR) \
		INSTALL_DIR=$(INSTALL_DIR)
