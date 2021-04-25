#!/usr/bin/env ruby

require 'pry'
require 'thefox-ext'
require 'pp'

include TheFox::Range::Lexer

n1 = Number.new('123')

binding.pry

puts '-> exit pry'
