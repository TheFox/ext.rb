#!/usr/bin/env ruby

require 'minitest/autorun'
require 'thefox-ext'


class TestHash < MiniTest::Test
	def test_merge_recursive_clone1
		h1 = {'k1' => 1, 'k2' => 1}
		h2 = {'k1' => 2, 'k2' => 2}
		
		assert_equal({'k1' => 2, 'k2' => 2}, h1.merge_recursive(h2))
	end
	
	def test_merge_recursive_clone2
		h1 = {'k1' => 1, 'k2' => 1}
		h2 = {'k1' => 2, 'k3' => 2}
		
		assert_equal({'k1' => 2, 'k2' => 1, 'k3' => 2}, h1.merge_recursive(h2))
	end
	
	def test_merge_recursive_clone3
		h1 = {'k1' => 1, 'k2' => {'sk1' => 1}}
		h2 = {'k1' => 2, 'k2' => 2}
		
		assert_equal({'k1' => 2, 'k2' => 2}, h1.merge_recursive(h2))
	end
	
	def test_merge_recursive_clone4a
		h1 = {'k1' => 1, 'k2' => 1}
		h2 = {'k1' => 2, 'k2' => {'sk2' => 2}}
		
		assert_equal({'k1' => 2, 'k2' => {'sk2' => 2}}, h1.merge_recursive(h2))
	end
	
	def test_merge_recursive_clone4b
		h1 = {'k1' => 1, 'k2' => {'sk1' => 1}}
		h2 = {'k1' => 2, 'k2' => 1}
		
		assert_equal({'k1' => 2, 'k2' => 1}, h1.merge_recursive(h2))
	end
	
	def test_merge_recursive_clone5
		h1 = {'k1' => 1, 'k2' => {'sk1' => 1}}
		h2 = {'k1' => 2, 'k2' => {'sk2' => 2}}
		
		assert_equal({'k1' => 2, 'k2' => {'sk1' => 1, 'sk2' => 2}}, h1.merge_recursive(h2))
	end
	
	def test_merge_recursive_clone6
		h1 = {'k1' => 1, 'k2' => 1, 'k4' => {'sk1' => 1}}
		h2 = {'k1' => 2, 'k3' => 2, 'k4' => {'sk2' => 2}}
		
		assert_equal({'k1' => 2, 'k2' => 1, 'k3' => 2, 'k4' => {'sk1' => 1, 'sk2' => 2}}, h1.merge_recursive(h2))
	end
	
	def test_merge_recursive_clone7
		h1 = {'k1' => 1, 'k2' => {'sk1' => 1}}
		h2 = {'k1' => 2}
		
		assert_equal({'k1' => 2, 'k2' => {'sk1' => 1}}, h1.merge_recursive(h2))
	end
	
	def test_merge_recursive_self1
		h1 = {'k1' => 1, 'k2' => 1}
		h2 = {'k1' => 2, 'k2' => 2}
		
		h1.merge_recursive!(h2)
		
		assert_equal({'k1' => 2, 'k2' => 2}, h1)
	end
	
	def test_merge_recursive_self2
		h1 = {'k1' => 1, 'k2' => 1}
		h2 = {'k1' => 2, 'k3' => 2}
		
		h1.merge_recursive!(h2)
		
		assert_equal({'k1' => 2, 'k2' => 1, 'k3' => 2}, h1)
	end
	
	def test_merge_recursive_self3
		h1 = {'k1' => 1, 'k2' => {'sk1' => 1}}
		h2 = {'k1' => 2, 'k2' => 2}
		
		h1.merge_recursive!(h2)
		
		assert_equal({'k1' => 2, 'k2' => 2}, h1)
	end
	
	def test_merge_recursive_self4a
		h1 = {'k1' => 1, 'k2' => 1}
		h2 = {'k1' => 2, 'k2' => {'sk2' => 2}}
		
		h1.merge_recursive!(h2)
		
		assert_equal({'k1' => 2, 'k2' => {'sk2' => 2}}, h1)
	end
	
	def test_merge_recursive_self4b
		h1 = {'k1' => 1, 'k2' => {'sk2' => 1}}
		h2 = {'k1' => 2, 'k2' => 1}
		
		h1.merge_recursive!(h2)
		
		assert_equal({'k1' => 2, 'k2' => 1}, h1)
	end
	
	def test_merge_recursive_self5
		h1 = {'k1' => 1, 'k2' => {'sk1' => 1}}
		h2 = {'k1' => 2, 'k2' => {'sk2' => 2}}
		
		h1.merge_recursive!(h2)
		
		assert_equal({'k1' => 2, 'k2' => {'sk1' => 1, 'sk2' => 2}}, h1)
	end
	
	def test_merge_recursive_self6
		h1 = {'k1' => 1, 'k2' => 1, 'k4' => {'sk1' => 1}}
		h2 = {'k1' => 2, 'k3' => 2, 'k4' => {'sk2' => 2}}
		
		h1.merge_recursive!(h2)
		
		assert_equal({'k1' => 2, 'k2' => 1, 'k3' => 2, 'k4' => {'sk1' => 1, 'sk2' => 2}}, h1)
	end
	
	def test_merge_recursive_self7
		h1 = {'k1' => 1, 'k2' => {'sk1' => 1}}
		h2 = {'k1' => 2}
		
		h1.merge_recursive!(h2)
		
		assert_equal({'k1' => 2, 'k2' => {'sk1' => 1}}, h1)
	end
end
