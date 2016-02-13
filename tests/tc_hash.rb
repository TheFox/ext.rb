#!/usr/bin/env ruby

require 'minitest/autorun'
require 'thefox-ext'
require 'pp'


class TestHash < MiniTest::Test
	def test_merge_recursive1
		h1 = {'k1' => 1, 'k2' => 1}
		h2 = {'k1' => 2, 'k2' => 2}
		
		assert_equal({'k1' => 2, 'k2' => 2}, h1.merge_recursive(h2))
	end
	
	def test_merge_recursive2
		h1 = {'k1' => 1, 'k2' => 1}
		h2 = {'k1' => 2, 'k3' => 2}
		
		assert_equal({'k1' => 2, 'k2' => 1, 'k3' => 2}, h1.merge_recursive(h2))
	end
	
	def test_merge_recursive3
		h1 = {'k1' => 1, 'k2' => {'sk1' => 1}}
		h2 = {'k1' => 2, 'k2' => 2}
		
		assert_equal({'k1' => 2, 'k2' => 2}, h1.merge_recursive(h2))
	end
	
	def test_merge_recursive4
		h1 = {'k1' => 1, 'k2' => 1}
		h2 = {'k1' => 2, 'k2' => {'sk2' => 2}}
		
		assert_equal({'k1' => 2, 'k2' => {'sk2' => 2}}, h1.merge_recursive(h2))
	end
	
	def test_merge_recursive5
		h1 = {'k1' => 1, 'k2' => {'sk1' => 1}}
		h2 = {'k1' => 2, 'k2' => {'sk2' => 2}}
		
		assert_equal({'k1' => 2, 'k2' => {'sk1' => 1, 'sk2' => 2}}, h1.merge_recursive(h2))
	end
	
	def test_merge_recursive6
		h1 = {'k1' => 1, 'k2' => 1, 'k4' => {'sk1' => 1}}
		h2 = {'k1' => 2, 'k3' => 2, 'k4' => {'sk2' => 2}}
		
		assert_equal({'k1' => 2, 'k2' => 1, 'k3' => 2, 'k4' => {'sk1' => 1, 'sk2' => 2}}, h1.merge_recursive(h2))
	end
end
