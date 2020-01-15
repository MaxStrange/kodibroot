Q=@

BUILDROOT := $(CURDIR)/../buildroot

# Usage
help:
	@echo "Usage: "
	@echo "make <board> OR make clean-<board>"
	@echo "Where <board> is one of:"
	@ls $(CURDIR)/configs | sed s:_defconfig::

%_defconfig:: configs/%_defconfig
	@echo Make defconfig from external $<
	$(Q)$(MAKE) -C $(BUILDROOT) BR2_EXTERNAL=$(CURDIR) O=$(CURDIR)/output/$* $@

%_defconfig:: $(BUILDROOT)/configs/%_defconfig
	@echo Make defconfig from buildroot $@
	$(Q)$(MAKE) -C $(BUILDROOT) BR2_EXTERNAL=$(CURDIR) O=$(CURDIR)/output/$* $@

# make <board>
#
# Makes the SD card image for the given board by trying to find the right defconfig
# and invoking buildroot's top level Makefile on it.
%: %_defconfig
	$(Q)$(MAKE) -C output/$* all

# make clean-<board> OR make clean-all
#
# Removes all build products, including the images and build directories.
clean-%:
	$(Q)$(MAKE) -C $(BUILDROOT) BR2_EXTERNAL=$(CURDIR) O=$(CURDIR)/output/$* clean $*_defconfig
