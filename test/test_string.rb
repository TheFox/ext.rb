#!/usr/bin/env ruby

require 'minitest/autorun'
require 'thefox-ext'

class TestString < MiniTest::Test

  def test_is_digit
    assert_equal(true, '0123456789'.is_digit?)
    assert_equal(true, '1'.is_digit?)
    assert_equal(true, '2'.is_digit?)

    assert_equal(false, 'ABC'.is_digit?)
    assert_equal(false, 'A'.is_digit?)
    assert_equal(false, 'A123'.is_digit?)
    assert_equal(false, '123B'.is_digit?)

    assert_equal(false, 'abc'.is_digit?)
    assert_equal(false, 'a'.is_digit?)
    assert_equal(false, 'a123'.is_digit?)
    assert_equal(false, '123b'.is_digit?)
  end

  def test_is_lower
    assert_equal(false, '0123456789'.is_lower?)
    assert_equal(false, '1'.is_lower?)
    assert_equal(false, '2'.is_lower?)

    assert_equal(false, 'ABC'.is_lower?)
    assert_equal(false, 'A'.is_lower?)
    assert_equal(false, 'A123'.is_lower?)
    assert_equal(false, '123B'.is_lower?)

    assert_equal(true, 'abc'.is_lower?)
    assert_equal(true, 'a'.is_lower?)
    assert_equal(false, 'a123'.is_lower?)
    assert_equal(false, '123b'.is_lower?)
  end

  def test_is_upper
    assert_equal(false, '0123456789'.is_upper?)
    assert_equal(false, '1'.is_upper?)
    assert_equal(false, '2'.is_upper?)

    assert_equal(true, 'ABC'.is_upper?)
    assert_equal(true, 'A'.is_upper?)
    assert_equal(false, 'A123'.is_upper?)
    assert_equal(false, '123B'.is_upper?)

    assert_equal(false, 'abc'.is_upper?)
    assert_equal(false, 'a'.is_upper?)
    assert_equal(false, 'a123'.is_upper?)
    assert_equal(false, '123b'.is_upper?)
  end

  def test_is_utf8
    assert_equal(true, 'ABC'.is_utf8?)
    assert_equal(true, 'üäöß'.is_utf8?)
  end

  def test_titlecase
    assert_equal('Abc Abc', 'ABC ABC'.titlecase)
    assert_equal('Abc Abc', 'ABC abc'.titlecase)
    assert_equal('Abc Abc', 'abc ABC'.titlecase)
    assert_equal('Abc Abc', 'Abc Abc'.titlecase)
    assert_equal('Abc Abc', 'abc abc'.titlecase)
    assert_equal('Abc Abc', 'aBc abc'.titlecase)
    assert_equal('Abc Abc', 'aBc abC'.titlecase)

    assert_equal('Abc1 Abc2', 'ABC1 ABC2'.titlecase)

    assert_equal('(abc Abc)', '(ABC ABC)'.titlecase)
  end

  def test_to_hex
    assert_equal('41424320414243', 'ABC ABC'.to_hex)
  end

  def test_to_i32a
    assert_equal({0 => 1090519040}, 'A'.to_i32a)
  end

  def test_to_utf8
    assert_equal('Abc', 'Abc'.to_utf8)
    assert_equal('AüäößE', 'AüäößE'.to_utf8)
  end
end
