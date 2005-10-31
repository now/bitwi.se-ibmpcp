# contents: Build PCF's from BDF's.
#
# Copyright © 2004,2005 Nikolai Weibull <nikolai@bitwi.se>

# Package information
PACKAGE_NAME = ibmpcp
PACKAGE_VERSION = 1.0.0
PACKAGE_TARNAME = $(PACKAGE_NAME)-$(PACKAGE_VERSION)

# Directories
fontsdir = /usr/share/fonts/$(PACKAGE_NAME)

# External programs
INSTALL = install
INSTALL_DATA = ${INSTALL} -m 644
BDFTOPCF = bdftopcf
MKFONTDIR = mkfontdir
XSET = xset

# Sources and targets
PCFS = \
       src/ibmpcp-5x10.pcf.gz \
       src/ibmpcp-7x10.pcf.gz

all: $(PCFS)

%.pcf.gz: %.bdf
	$(BDFTOPCF) $< | gzip -9 -c > $@

install: all
	$(INSTALL) -d -m755 $(fontsdir)
	$(INSTALL_DATA) $(PCFS) $(fontsdir)
	$(MKFONTDIR) $(fontsdir)
	$(XSET) +fp $(fontsdir)
	$(XSET) fp rehash

clean:
	-rm -f $(PCFS)

dist:
	git-tar-tree HEAD $(PACKAGE_TARNAME) | gzip -f -9 -c > $(PACKAGE_TARNAME).tar.gz
