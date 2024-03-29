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

  def test_range_resolver_number1
    rr = TheFox::Range::Resolver.new('1')
    assert_equal([1], rr.to_a)
  end

  def test_range_resolver_number2
    rr = TheFox::Range::Resolver.new('123')
    assert_equal([123], rr.to_a)
  end

  def test_range_resolver_numbers1
    rr = TheFox::Range::Resolver.new('1,2')
    assert_equal([1, 2], rr.to_a)
  end

  def test_range_resolver_numbers2
    rr = TheFox::Range::Resolver.new('123,456')
    assert_equal([123, 456], rr.to_a)
  end

  def test_range_resolver_numbers3
    rr = TheFox::Range::Resolver.new('123,456,456')
    assert_equal([123, 456, 456], rr.to_a)
  end

  def test_range_resolver_minus_range1
    rr = TheFox::Range::Resolver.new('123-456')
    assert_equal((123..456).to_a, rr.to_a)
  end

  def test_range_resolver_minus_range2
    rr = TheFox::Range::Resolver.new('99-101')
    assert_equal((99..101).to_a, rr.to_a)
  end

  def test_range_resolver_minus_range3
    rr = TheFox::Range::Resolver.new('1-1')
    assert_equal([1], rr.to_a)
  end

  def test_range_resolver_dot_range1
    rr = TheFox::Range::Resolver.new('99.101')
    assert_equal((99..101).to_a, rr.to_a)
  end

  def test_range_resolver_dot_range2
    rr = TheFox::Range::Resolver.new('99..101')
    assert_equal((99..101).to_a, rr.to_a)
  end

  def test_range_resolver_plus_range1
    rr = TheFox::Range::Resolver.new('999+')
    assert_equal([999, 1000], rr.to_a)
  end

  def test_range_resolver_plus_range2
    rr = TheFox::Range::Resolver.new('999++')
    assert_equal([999, 1000, 1001], rr.to_a)
  end

  def test_range_resolver_plus_range3
    rr = TheFox::Range::Resolver.new('999+++')
    assert_equal([999, 1000, 1001, 1002], rr.to_a)
  end

  def test_range_resolver_plus_range4
    rr = TheFox::Range::Resolver.new('99+,999++')
    assert_equal([99, 100, 999, 1000, 1001], rr.to_a)
  end

  def test_range_resolver_rang_minuls_and_plus1
    rr = TheFox::Range::Resolver.new('9-15++')
    assert_equal((9..17).to_a, rr.to_a)
  end

  def test_range_resolver_block_simple
    rr = TheFox::Range::Resolver.new('1{2}')
    assert_equal([12], rr.to_a)
  end

  def test_range_resolver_block_subblocks_simple1
    rr = TheFox::Range::Resolver.new('1{2{3}}')
    assert_equal([123], rr.to_a)
  end

  def test_range_resolver_block_subblocks_simple2
    rr = TheFox::Range::Resolver.new('1{2,3{4}}')
    assert_equal([12, 134], rr.to_a)
  end

  def test_range_resolver_block_subblocks_list
    rr = TheFox::Range::Resolver.new('1{2,3{4,5,6}}')
    assert_equal([12, 134, 135, 136], rr.to_a)
  end

  def test_range_resolver_block_subblocks_ranges1
    rr = TheFox::Range::Resolver.new('1{2,3{4-7}}')
    assert_equal([12, 134, 135, 136, 137], rr.to_a)
  end

  def test_range_resolver_block_subblocks_ranges2
    rr = TheFox::Range::Resolver.new('2{3{4,5},6}')
    assert_equal([234, 235, 26], rr.to_a)
  end

  def test_range_resolver_block_correct_prefix_simple
    rr = TheFox::Range::Resolver.new('1{1,02}')
    assert_equal([11, 102], rr.to_a)
  end

  def test_range_resolver_block_correct_prefix_ranges1
    rr = TheFox::Range::Resolver.new('1{02,03{1-3}}')
    assert_equal([102, 1031, 1032, 1033], rr.to_a)
  end

  def test_range_resolver_block_correct_prefix_multiple
    rr = TheFox::Range::Resolver.new('1{02},3{04}')
    assert_equal([102, 304], rr.to_a)
  end

  def test_range_resolver_block_correct_prefix_ranges2
    rr = TheFox::Range::Resolver.new('1{02,03{1-3}},2{3+}')
    assert_equal([102, 1031, 1032, 1033, 23, 24], rr.to_a)
  end

  def test_range_resolver_block_correct_prefix_ranges3
    rr = TheFox::Range::Resolver.new('1{02,03{1-3}},02{3+}')
    assert_equal([102, 1031, 1032, 1033, 23, 24], rr.to_a)
  end

  def test_range_resolver_block_correct_prefix_ranges3
    rr = TheFox::Range::Resolver.new('1{02,03{1-3},02{3+}}')
    assert_equal([102, 1031, 1032, 1033, 1023, 1024], rr.to_a)
  end

  def test_range_resolver_block_correct_prefix_complex
    rr = TheFox::Range::Resolver.new('1{02,03{1-3,4..6}},2{3+}')
    assert_equal([102, 1031, 1032, 1033, 1034, 1035, 1036, 23, 24], rr.to_a)
  end

  def test_range_resolver_block_correct_prefix_ranges3
    rr = TheFox::Range::Resolver.new('1{0002,2},3')
    assert_equal([10002, 12, 3], rr.to_a)
  end

  def test_range_resolver_block_correct_prefix_ranges4
    rr = TheFox::Range::Resolver.new('98{2-4,020-022}')
    assert_equal([982, 983, 984, 98020, 98021, 98022], rr.to_a)
  end

  def test_range_resolver_block_correct_prefix_ranges5
    rr = TheFox::Range::Resolver.new('12{0{5-7}}')
    assert_equal([1205, 1206, 1207], rr.to_a)
  end

  def test_range_resolver_block_correct_prefix_ranges6
    rr = TheFox::Range::Resolver.new('1{1{0-2}}')
    assert_equal([110, 111, 112], rr.to_a)
  end

  def test_range_resolver_block_correct_prefix_range_inc
    rr = TheFox::Range::Resolver.new('1{0002++},3')
    assert_equal([10002, 10003, 10004, 3], rr.to_a)
  end

  def test_range_resolver_interval_simple1
    rr = TheFox::Range::Resolver.new('3/1')
    assert_equal([3], rr.to_a)
  end

  def test_range_resolver_interval_simple2
    rr = TheFox::Range::Resolver.new('3/2')
    assert_equal([3], rr.to_a)
  end

  def test_range_resolver_interval_simple3
    rr = TheFox::Range::Resolver.new('1-3/1')
    assert_equal([1, 2, 3], rr.to_a)
  end

  def test_range_resolver_interval_simple4
    rr = TheFox::Range::Resolver.new('1-3/2')
    assert_equal([1, 3], rr.to_a)
  end

  def test_range_resolver_interval_simple5
    rr = TheFox::Range::Resolver.new('1-10/2')
    assert_equal([1, 3, 5, 7, 9], rr.to_a)
  end

  def test_range_resolver_interval_simple6
    rr = TheFox::Range::Resolver.new('1000-1100/20')
    assert_equal([1000, 1020, 1040, 1060, 1080, 1100], rr.to_a)
  end

  def test_range_resolver_interval_block1
    rr = TheFox::Range::Resolver.new('1{1-3/2}')
    assert_equal([11, 13], rr.to_a)
  end

  def test_range_resolver_interval_block2
    rr = TheFox::Range::Resolver.new('2{10-20/2}')
    assert_equal([210, 212, 214, 216, 218, 220], rr.to_a)
  end

  def test_range_resolver_interval_empty1
    rr = TheFox::Range::Resolver.new('/20')
    assert_equal([], rr.to_a)
  end

  def test_range_resolver_scope1
    rr = TheFox::Range::Resolver.new(',,,,,,1,2')
    assert_equal([1, 2], rr.to_a)
  end

end
