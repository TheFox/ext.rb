#!/usr/bin/env ruby

require 'minitest/autorun'
require 'thefox-ext'

class TestInteger < MiniTest::Test
	def test_to_b
		assert_equal(true, 3.to_b)
		assert_equal(true, 2.to_b)
		assert_equal(true, 1.to_b)
		
		assert_equal(false, 0.to_b)
		
		assert_equal(true, -1.to_b)
		assert_equal(true, -2.to_b)
		assert_equal(true, -3.to_b)
		
	end
end
