#!/usr/bin/env ruby

require 'pry'
require 'thefox-ext'
require 'pp'

n1 = TheFox::Range::Lexer2::Number.new('123')

binding.pry

puts '-> exit pry'
