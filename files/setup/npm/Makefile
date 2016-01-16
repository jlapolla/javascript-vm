define $(d)template
$(eval include helpdoc.mk)

$(d)flags/npm: node/flags/all
	rm -rf ~/.npm ~/.npmrc
	sudo npm update -g npm
	sudo rm -rf ~/.npm
	printf '%s\n' 'prefix=~/usr/local' >~/.npmrc
	mkdir -p $(d)flags/ && touch $(d)flags/npm

$(d)flags/all: $(d)flags/npm
	mkdir -p $(d)flags/ && touch $(d)flags/all

.PHONY: $(d)all
$(call helpdoc,$(d)all)
$(d)all: $(d)flags/all

.DEFAULT_GOAL := help

endef

$(eval $($(d)template))
$(eval $(d)template :=)
