define $(d)template
$(eval include helpdoc.mk)
$(eval include require.mk)
$(call ,$(call require,provisions/extensions/nodejs_install.mk))
$(eval $(d)nodejs_binary := $(call ext_nodejs_install))

$(d).make/node: $(filter %/node,$($(d)nodejs_binary))
	sudo ln -sf $(abspath $(filter %/node,$($(d)nodejs_binary))) /usr/local/bin/node
	mkdir -p $(d).make/ && touch $(d).make/node

$(d).make/npm: $(filter %/npm,$($(d)nodejs_binary)) $(d).make/node
	sudo ln -sf $(abspath $(filter %/npm,$($(d)nodejs_binary))) /usr/local/bin/npm
	mkdir -p $(d).make/ && touch $(d).make/npm

$(d).make/all: $(addprefix $(d).make/,node npm)
	mkdir -p $(d).make/ && touch $(d).make/all

.PHONY: $(d)all
$(call helpdoc,$(d)all)
$(d)all: $(d).make/all

.DEFAULT_GOAL := help

$(eval $(d)nodejs_binary :=)

endef

$(eval $($(d)template))
$(eval $(d)template :=)

