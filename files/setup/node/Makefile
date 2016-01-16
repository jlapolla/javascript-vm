define $(d)template
$(eval include require.mk)
$(eval include helpdoc.mk)
$(call ,$(call require,provisions/extensions/nodejs_install.mk))
$(eval $(d)nodejs_binary := $(call ext_nodejs_install))

$(d)flags/node: $(filter %/node,$($(d)nodejs_binary))
	sudo ln -sf $(abspath $(filter %/node,$($(d)nodejs_binary))) /usr/local/bin/node
	mkdir -p $(d)flags/ && touch $(d)flags/node

$(d)flags/npm: $(filter %/npm,$($(d)nodejs_binary)) $(d)flags/node
	sudo ln -sf $(abspath $(filter %/npm,$($(d)nodejs_binary))) /usr/local/bin/npm
	mkdir -p $(d)flags/ && touch $(d)flags/npm

$(d)flags/all: $(addprefix $(d)flags/,node npm)
	mkdir -p $(d)flags/ && touch $(d)flags/all

.PHONY: $(d)all
$(call helpdoc,$(d)all)
$(d)all: $(d)flags/all

.DEFAULT_GOAL := help

$(eval $(d)nodejs_binary :=)

endef

$(eval $($(d)template))
$(eval $(d)template :=)
