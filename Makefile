ifeq ($(shell [ -f ./framework/makefiles/common.mk ] && echo 1 || echo 0),0)
all clean package install::
	git submodule update --init
	./framework/git-submodule-recur.sh init
	$(MAKE) $(MAKEFLAGS) MAKELEVEL=0 $@
else

TWEAK_NAME = pickup2silence
pickup2silence_OBJC_FILES = Tweak.m
pickup2silence_FRAMEWORKS = UIKit

include framework/makefiles/common.mk
include framework/makefiles/tweak.mk

endif
