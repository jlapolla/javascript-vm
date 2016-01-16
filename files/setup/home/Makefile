# File copy template
define $(d)template
$(d)flags/$(2): preferences/$(1)$(2)
	cp preferences/$(1)$(2) ~
	mkdir -p $(d)flags/ && touch $(d)flags/$(2)
endef

$(eval $(call $($(d)template),bash/,.bashrc))
$(eval $(call $($(d)template),git/,.gitconfig))
$(eval $(call $($(d)template),git/,.gitignore_global))
$(eval $(call $($(d)template),vim/,.vimrc))
$(eval $(d)template :=)

# Main template
define $(d)template
$(eval include helpdoc.mk)

$(d)flags/all: $(addprefix $(d)flags/,.bashrc .gitconfig .gitignore_global .vimrc)
	mkdir -p $(d)flags/ && touch $(d)flags/all

.PHONY: $(d)all
$(call helpdoc,$(d)all)
$(d)all: $(d)flags/all

.DEFAULT_GOAL := help

endef

$(eval $($(d)template))
$(eval $(d)template :=)

