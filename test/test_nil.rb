#!/usr/bin/env ruby

require 'minitest/autorun'
require 'thefox-ext'


class TestNil < MiniTest::Test
	def test_to_utf8
		assert_equal('', nil.to_utf8)
	end
end
