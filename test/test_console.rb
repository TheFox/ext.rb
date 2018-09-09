#!/usr/bin/env ruby

require 'minitest/autorun'
require 'thefox-ext'

class TestConsole < MiniTest::Test

  def test_console
    Console.cursor_up()
    Console.cursor_down()
    Console.cursor_jump_to_top()
    Console.cursor_jump_to_column()
    Console.cursor_right()
    Console.cursor_left()
    Console.line_clear()
    Console.line_clear_right()
    Console.screen_clear_to_bottom()
    Console.scroll_up()
    Console.scroll_down()
  end

end
