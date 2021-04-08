#!/usr/bin/env ruby

require 'simplecov'
require 'simplecov-phpunit'

SimpleCov.formatter = SimpleCov::Formatter::PHPUnit
SimpleCov.start do
  add_filter 'test'
end

require_relative 'test_date'
require_relative 'test_false'
require_relative 'test_hash'
require_relative 'test_integer'
require_relative 'test_nil'
require_relative 'test_string'
require_relative 'test_true'
require_relative 'test_console'
