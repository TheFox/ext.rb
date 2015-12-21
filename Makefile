
GEM_NAME = thefox-ext

include Makefile.common

.PHONY: test
test:
	RUBYOPT=-w $(BUNDLER) exec ./tests/ts_all.rb
