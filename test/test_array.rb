#!/usr/bin/env ruby

require 'minitest/autorun'
require 'thefox-ext'

class TestArray < MiniTest::Test

  def test_resolve_range_str
    assert_equal([], Array.resolve_range_str(nil))
    assert_equal([], Array.resolve_range_str(''))
    assert_equal([0], Array.resolve_range_str('a'))

    assert_equal([1], Array.resolve_range_str('1'))

    assert_equal([1, 2], Array.resolve_range_str('1, 2'))
    assert_equal([1, 2], Array.resolve_range_str('1,2'))
    assert_equal([1, 2, 4], Array.resolve_range_str('1,2,4'))

    assert_equal([2, 3], Array.resolve_range_str('2..3'))
    assert_equal([2, 3, 4, 5], Array.resolve_range_str('2..5'))
    assert_equal([2, 3, 4, 5], Array.resolve_range_str('2-5'))
    assert_equal([2, 3], Array.resolve_range_str('2 .. 3'))
    assert_equal([2, 3], Array.resolve_range_str('2 - 3'))

    assert_equal([2, 3, 4, 5, 7, 8], Array.resolve_range_str('2..5,7..8'))
    assert_equal([2, 3, 4, 5, 3, 4, 5, 6], Array.resolve_range_str('2..5,3..6'))
    assert_equal([1, 2, 3, 4, 5, 3, 4, 5, 6], Array.resolve_range_str('1,2..5,3..6'))

    assert_equal([21, 22], Array.resolve_range_str('21+'))
    assert_equal([21, 22, 23], Array.resolve_range_str('21++'))
    assert_equal([21, 22, 23, 24], Array.resolve_range_str('21+++'))
  end

end
