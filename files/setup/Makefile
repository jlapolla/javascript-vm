# GNU Make Toolkit (GMTK) may not be installed
-include require.mk

# Check for GMTK
ifdef require # GMTK is installed
# Load modules and targets

# Download required modules
# Check for preferences module
ifeq ($(wildcard preferences/Makefile),) # Preferences module is not installed
  # Download preferences module
  include exec.mk
  $(call exec,git clone https://github.com/jlapolla/preferences.git preferences,Failed to clone https://github.com/jlapolla/preferences.git)
endif # End check for preferences module
# Check for provisions module
ifeq ($(wildcard provisions/Makefile),) # Provisions module is not installed
  # Download provisions module
  include exec.mk
  $(call exec,git clone https://github.com/jlapolla/provisions.git provisions,Failed to clone https://github.com/jlapolla/provisions.git)
endif # End check for provisions module

# Load required modules
# Load preferences module and extensions
$(call ,$(call require,$(addprefix ,$(addsuffix /Makefile,home node npm preferences provisions))))
$(call ,$(call require,preferences/extensions/ext_vundle_update.mk))

# Include libraries used in THIS Makefile
include helpdoc.mk

.make/all: $(addsuffix .make/all,home/ node/ npm/)
	mkdir -p .make/ && touch .make/all

# Summary rules
.PHONY: all
$(call helpdoc,all,Install all required files)
all: .make/all

.PHONY: update
$(call helpdoc,update,Check for updates and update existing installation if required)
update: .make/all $(call ext_vundle_update,~/) preferences/vim-plugin-update
	cd ~/usr/local/gmtk && git pull
	cd preferences && git pull
	cd provisions && git pull

# Default goal
.DEFAULT_GOAL := help

else # GMTK is not installed
# Diagnostic message
$(info GNU Make Toolkit (GMTK) not set up)
$(info Run "make" to set up GMTK)

# Default goal to install GMTK
.DEFAULT_GOAL := ~/usr/local/bin/make

endif # End check for GMTK

# Install GMTK
~/usr/local/gmtk/bin/make:
	mkdir -p ~/usr/local/
	git clone https://github.com/jlapolla/gnu-make-toolkit.git ~/usr/local/gmtk/

# Place GMTK wrapper script on PATH
~/usr/local/bin/make: ~/usr/local/gmtk/bin/make
	mkdir -p ~/usr/local/bin/
	ln -sf ~/usr/local/gmtk/bin/make ~/usr/local/bin/make

