#!/usr/bin/env ruby

require 'minitest/autorun'
require 'thefox-ext'

class TestTrue < MiniTest::Test

  def test_to_i
    assert_equal(1, true.to_i)
  end

end
