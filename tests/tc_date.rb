#!/usr/bin/env ruby

require 'minitest/autorun'
require 'thefox-ext'
#require 'date'
#require 'pp'


class TestDate < MiniTest::Test
	def test_today
		assert_equal(true, Date.today.today?)
		
		assert_equal(false, Date.new(2001, 2, 3).today?)
		assert_equal(false, Date.new(2001, 2, 4).today?)
		
		# This test may fail on 01.01.2018 ;)
		assert_equal(false, Date.new(2018, 1, 1).today?)
	end
end
