#!/usr/bin/env ruby

require 'minitest/autorun'
require 'thefox-ext'

class TestFalse < MiniTest::Test

  def test_false
    assert_equal(0, false.to_i)
  end

end
