
GEM_NAME = thefox-ext

include Makefile.common

.PHONY: test
test:
	RUBYOPT=-w ./tests/ts_all.rb
