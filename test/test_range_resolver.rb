#!/usr/bin/env ruby

require 'minitest/autorun'
require 'thefox-ext'

class TestRangeResolver < MiniTest::Test

  def test_range_resolver_new
    rr = TheFox::Range::Resolver.new()
    assert_equal('TheFox::Range::Resolver', rr.class.to_s)
  end

  def test_range_resolver_to_a
    rr = TheFox::Range::Resolver.new()
    assert_equal([], rr.to_a)
  end

  def test_range_resolver_number
    rr = TheFox::Range::Resolver.new('123')
    assert_equal([123], rr.to_a)
  end

  def test_range_resolver_numbers
    rr = TheFox::Range::Resolver.new('123,456')
    assert_equal([123, 456], rr.to_a)
  end

  def test_range_resolver_range
    rr = TheFox::Range::Resolver.new('123-456')
    assert_equal((123..456).to_a, rr.to_a)
  end

end
