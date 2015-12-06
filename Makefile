
MV = mv -nv

.PHONY: all
all:

release:
	set -e; \
	gem_file=$$(gem build thefox-ext.gemspec | grep 'File:' | tail -1 | awk '{ print $$2 }'); \
	dst="releases/$$gem_file"; \
	[ ! -f $$dst ]; \
	$(MV) $$gem_file releases; \
	gem push $$dst; \
	echo 'done'
