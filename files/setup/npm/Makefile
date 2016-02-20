define $(d)template
$(eval include helpdoc.mk)

$(d).make/npm: node/.make/all
	rm -rf ~/.npm ~/.npmrc
	sudo npm update -g npm
	sudo rm -rf ~/.npm
	printf '%s\n' 'prefix=~/usr/local' >~/.npmrc
	mkdir -p $(d).make/ && touch $(d).make/npm

$(d).make/all: $(d).make/npm
	mkdir -p $(d).make/ && touch $(d).make/all

.PHONY: $(d)all
$(call helpdoc,$(d)all)
$(d)all: $(d).make/all

.DEFAULT_GOAL := help

endef

$(eval $($(d)template))
$(eval $(d)template :=)

