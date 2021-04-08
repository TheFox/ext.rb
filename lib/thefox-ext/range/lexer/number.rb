
require 'pp'

module TheFox
module Range
module Lexer
  # 0123456789
  class Number < Base
    def initialize(char)
      super()
      # puts '-> TheFox::Range::Lexer::Number.initialize(%s)' % [char]
      @char = char
    end

    def char()
      @char
    end

    def lex()
      if @prev_item.is_a?(Number) || @next_item.is_a?(Separator)
        nil
      elsif @next_item.is_a?(Range) || @prev_item.is_a?(Range)
        nil
      else
        self
      end
    end

    def resolve()
      puts '-> TheFox::Range::Lexer::Number.resolve(%s)' % [@char]
      # sleep(0.1)

      if @next_item.is_a?(Range) || @prev_item.is_a?(Range)
        puts '-> next or prev is Range'
        @char
      elsif @next_item.is_a?(Number)
        puts '-> next is Number'
        '%s%s' % [@char, @next_item.resolve]
      elsif @next_item.is_a?(Separator)
        @char
      elsif @next_item.nil?
        @char
      else
        pp self
        # pp @prev_item
        # pp @next_item
        raise 'Number resolve else'
      end
    end
  end # Range
end # Lexer
end # Range
end # TheFox
