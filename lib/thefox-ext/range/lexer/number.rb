
require 'pp'

module TheFox
module Range
module Lexer
  # 0123456789
  class Number < Base
    def initialize(char)
      super()
      puts '-> Number.initialize(%s)' % [char]
      @char = char
    end

    def inspect()
      'Number(%s)' % [@char]
    end

    def char()
      @char
    end

    def append(char)
      @char += char
    end
  end # Range
end # Lexer
end # Range
end # TheFox
