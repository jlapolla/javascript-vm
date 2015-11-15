define $(d)template
-include helpdoc.mk

$(d)share/Vagrantfile: $(d)Vagrantfile-fake
	mkdir -p $(d)share
	cp $(d)Vagrantfile-fake $(d)share/Vagrantfile

$(d)files.tar.gz: $(shell find $(d)files -type f)
	tar -C $(d)files -czf $(d)files.tar.gz $(shell find $(d)files -mindepth 1 -maxdepth 1 | sed 's:^$(d)files/::')

.PHONY: $(d)all
$(call helpdoc,$(d)all,Set up files for Vagrant)
$(d)all: $(d)share/Vagrantfile $(d)files.tar.gz $(d)prov.sh

.PHONY: $(d)clean
$(call helpdoc,$(d)clean,Delete all generated files except files in share/)
$(d)clean:
	rm -f $(d)files.tar.gz

ifdef helpdoc
.DEFAULT_GOAL := help
else # ifdef helpdoc
.DEFAULT_GOAL := $(d)all
endif # ifdef helpdoc
endef

$(eval $($(d)template))
$(eval $(d)template :=)
