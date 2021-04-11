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

  def test_range_resolver_range1
    rr = TheFox::Range::Resolver.new('123-456')
    assert_equal((123..456).to_a, rr.to_a)
  end

  def test_range_resolver_range2
    rr = TheFox::Range::Resolver.new('99-101')
    assert_equal((99..101).to_a, rr.to_a)
  end

  def test_range_resolver_range3a
    rr = TheFox::Range::Resolver.new('99.101')
    assert_equal((99..101).to_a, rr.to_a)
  end

  def test_range_resolver_range3b
    rr = TheFox::Range::Resolver.new('99..101')
    assert_equal((99..101).to_a, rr.to_a)
  end

  def test_range_resolver_range_inc
    rr = TheFox::Range::Resolver.new('99+,999++')
    assert_equal([99, 100, 999, 1000, 1001], rr.to_a)
  end

  def test_range_resolver_block1
    rr = TheFox::Range::Resolver.new('1{2}')
    assert_equal([12], rr.to_a)
  end

  def test_range_resolver_block2
    rr = TheFox::Range::Resolver.new('1{2{3}}')
    assert_equal([123], rr.to_a)
  end

  def test_range_resolver_block3
    rr = TheFox::Range::Resolver.new('1{2,3{4}}')
    assert_equal([12, 134], rr.to_a)
  end

  def test_range_resolver_block4
    rr = TheFox::Range::Resolver.new('1{2,3{4,5,6}}')
    assert_equal([12, 134, 135, 136], rr.to_a)
  end

  def test_range_resolver_block5
    rr = TheFox::Range::Resolver.new('1{2,3{4-7}}')
    assert_equal([12, 134, 135, 136, 137], rr.to_a)
  end

  def test_range_resolver_block6
    rr = TheFox::Range::Resolver.new('1{02}')
    assert_equal([102], rr.to_a)
  end

  def test_range_resolver_block7
    rr = TheFox::Range::Resolver.new('1{02,03{1-3}}')
    assert_equal([102, 1031, 1032, 1033], rr.to_a)
  end

  def test_range_resolver_block8
    rr = TheFox::Range::Resolver.new('1{02},3{04}')
    assert_equal([102, 304], rr.to_a)
  end

  def test_range_resolver_block9
    rr = TheFox::Range::Resolver.new('1{02,03{1-3}},2{3+}')
    assert_equal([102, 1031, 1032, 1033, 23, 24], rr.to_a)
  end

  def test_range_resolver_block10
    rr = TheFox::Range::Resolver.new('1{02,03{1-3,4..6}},2{3+}')
    assert_equal([102, 1031, 1032, 1033, 1034, 1035, 1036, 23, 24], rr.to_a)
  end

end
