#!/usr/bin/env ruby

require 'minitest/autorun'
require 'thefox-ext'

class TestRangeLexerNumber < MiniTest::Test

  def test_range_lexer_number_resolve1
    n1 = TheFox::Range::Lexer2::Number.new('123')
    assert_equal(123, n1.resolve)
  end

  def test_range_lexer_number_append1
    n1 = TheFox::Range::Lexer2::Number.new('456')
    n1.append('7')
    assert_equal(4567, n1.resolve)
  end

  def test_range_lexer_number_append2
    n1 = TheFox::Range::Lexer2::Number.new('456')
    n2 = TheFox::Range::Lexer2::Number.new('789')
    n1.append(n2)
    assert_equal(456789, n1.resolve)
  end

  def test_range_lexer_number_inc1
    n1 = TheFox::Range::Lexer2::Number.new('9')
    n1.inc
    assert_equal(10, n1.resolve)
  end

  def test_range_lexer_number_inc2
    n1 = TheFox::Range::Lexer2::Number.new('456')
    n1.inc
    assert_equal(457, n1.resolve)
  end

  def test_range_lexer_number_parent1
    n3 = TheFox::Range::Lexer2::Number.new('7')

    n2 = TheFox::Range::Lexer2::Number.new('8')
    n2.parent_item = n3

    n1 = TheFox::Range::Lexer2::Number.new('9')
    n1.parent_item = n2
    assert_equal('789', n1.resolve)
  end

  def test_range_lexer_number_dup1
    n1 = TheFox::Range::Lexer2::Number.new('9')
    n1.nonce = 'abc'
    n2 = n1.dup

    assert_equal('abc', n1.nonce)
    assert('abc' != n2.nonce)
  end

end
