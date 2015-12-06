
MV = mv -nv
RM = rm -f
GEMSPEC_FILE = thefox-ext.gemspec

.PHONY: all
all:

.PHONY: install
install:
	gem_file=$$(gem build $(GEMSPEC_FILE) | grep 'File:' | tail -1 | awk '{ print $$2 }'); \
	sudo gem install $$gem_file; \
	$(RM) $$gem_file

.PHONY: release
release:
	set -e; \
	gem_file=$$(gem build $(GEMSPEC_FILE) | grep 'File:' | tail -1 | awk '{ print $$2 }'); \
	dst="releases/$$gem_file"; \
	[ ! -f $$dst ]; \
	$(MV) $$gem_file releases; \
	gem push $$dst; \
	echo 'done'
