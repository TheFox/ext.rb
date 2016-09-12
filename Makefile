
GEM_NAME = thefox-ext

include Makefile.common

.PHONY: test
test:
	RUBYOPT=-w $(BUNDLER) exec ./test/suite_all.rb
