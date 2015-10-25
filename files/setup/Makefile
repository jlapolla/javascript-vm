# GNU Make Toolkit (GMTK) may not be installed
-include require.mk

# Check for GMTK
ifdef require # GMTK is installed
  # Load modules and targets

  # Download required modules
  # Check for preferences module
  ifeq ($(wildcard $(d)pref/Makefile),) # Preferences module is not installed
    # Download preferences module
    include exec.mk
    $(call exec,git clone 'https://github.com/jlapolla/preferences.git' $(d)pref,Failed to download "preferences" module)
  endif # End check for preferences module
  # Check for provisions module
  ifeq ($(wildcard $(d)prov/Makefile),) # Provisions module is not installed
    # Download provisions module
    include exec.mk
    $(call exec,git clone 'https://github.com/jlapolla/provisions.git' $(d)prov,Failed to download "provisions" module)
  endif # End check for provisions module

  # Load required modules
  # Load preferences module and extensions
  $(call ,$(call require,$(addprefix $(d),$(addsuffix /Makefile,pref prov))))
  $(call ,$(call require,$(addprefix $(d)pref/extensions/,ext_vundle_install.mk ext_vundle_update.mk) $(addprefix $(d)prov/extensions/, nodejs_install.mk)))

  # Include libraries used in THIS Makefile
  include helpdoc.mk

# Create targets for THIS Makefile
# Specific rules
$(HOME)/.bashrc: $(d)pref/bash/.bashrc
	cp $< $@

$(HOME)/.gitconfig: $(d)pref/git/.gitconfig
	cp $< $@

$(HOME)/.gitignore_global: $(d)pref/git/.gitignore_global
	cp $< $@

$(HOME)/.vimrc: $(d)pref/vim/.vimrc
	cp $< $@

nodejs_binary := $(call ext_nodejs_install)
/usr/local/bin/node: $(filter %/node,$(nodejs_binary))
	sudo ln -sf $(abspath $<) $@

/usr/local/bin/npm: $(filter %/npm,$(nodejs_binary)) | /usr/local/bin/node
	sudo ln -sf $(abspath $<) $@

$(HOME)/.npmrc: | /usr/local/bin/npm
	sudo npm update -g npm
	sudo rm -rf $(HOME)/.npm
	printf '%s\n' 'prefix=$(HOME)/usr/local' >$@

# Summary rules
$(call helpdoc,$(d)all,Install all required files.)
$(d)all: $(addprefix $(HOME)/,.bashrc .gitconfig .gitignore_global .npmrc .vimrc) $(call ext_vundle_install,$(HOME)/) /usr/local/bin/node
	touch $@

.PHONY: $(d)update
$(call helpdoc,$(d)update,Check for updates and update existing installation if required.)
$(d)update: $(d)all $(call ext_vundle_update,$(HOME)/) $(d)pref/vim-plugin-update
	cd $(HOME)/usr/local/gmtk && git pull
	cd $(d)pref && git pull
	cd $(d)prov && git pull

# Default goal
.DEFAULT_GOAL := help

else # GMTK is not installed
# Diagnostic message
$(info GNU Make Toolkit (GMTK) not set up. Most targets are disabled.)
$(info Run "make" to set up GMTK.)

# Default goal to install GMTK
.DEFAULT_GOAL := $(HOME)/usr/local/bin/make

endif # End check for GMTK

# Install GMTK
$(HOME)/usr/local/gmtk/bin/make:
	mkdir -p $(HOME)/usr/local
	git clone 'https://github.com/jlapolla/gnu-make-toolkit.git' $(HOME)/usr/local/gmtk

# Place GMTK wrapper script on PATH
$(HOME)/usr/local/bin/make: $(HOME)/usr/local/gmtk/bin/make
	mkdir -p $(@D)
	ln -s $< $@
