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
    $(call exec,git clone https://github.com/jlapolla/provisions.git provsions,Failed to clone https://github.com/jlapolla/provisions.git)
  endif # End check for provisions module

  # Load required modules
  # Load preferences module and extensions
  $(call ,$(call require,$(addprefix ,$(addsuffix /Makefile,preferences provisions))))
  $(call ,$(call require,$(addprefix preferences/extensions/,ext_vundle_install.mk ext_vundle_update.mk) $(addprefix provisions/extensions/, nodejs_install.mk)))

  # Include libraries used in THIS Makefile
  include helpdoc.mk

# Create targets for THIS Makefile
# Home directory preferences
~/.bashrc: preferences/bash/.bashrc
	cp $< $@

~/.gitconfig: preferences/git/.gitconfig
	cp $< $@

~/.gitignore_global: preferences/git/.gitignore_global
	cp $< $@

~/.vimrc: preferences/vim/.vimrc
	cp $< $@

# Node.js
nodejs_binary := $(call ext_nodejs_install)
/usr/local/bin/node: $(filter %/node,$(nodejs_binary))
	sudo ln -sf $(abspath $<) $@

/usr/local/bin/npm: $(filter %/npm,$(nodejs_binary)) | /usr/local/bin/node
	sudo ln -sf $(abspath $<) $@

~/.npmrc: | /usr/local/bin/npm
	sudo npm update -g npm
	sudo rm -rf ~/.npm
	printf '%s\n' 'prefix=~/usr/local' >$@

# Perl App::cpanminus
/usr/local/bin/cpanm: provisions/cpanm/cpanm.pl
	perl provisions/cpanm/cpanm.pl --sudo App::cpanminus

# Summary rules
$(call helpdoc,all,Install all required files.)
all: $(addprefix ~/,.bashrc .gitconfig .gitignore_global .npmrc .vimrc) $(call ext_vundle_install,~/) $(addprefix /usr/local/bin/,cpanm node)
	touch $@

.PHONY: update
$(call helpdoc,update,Check for updates and update existing installation if required.)
update: all $(call ext_vundle_update,~/) preferences/vim-plugin-update
	cd ~/usr/local/gmtk && git pull
	cd preferences && git pull
	cd provisions && git pull

# Default goal
.DEFAULT_GOAL := help

else # GMTK is not installed
# Diagnostic message
$(info GNU Make Toolkit (GMTK) not set up. Most targets are disabled.)
$(info Run "make" to set up GMTK.)

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
