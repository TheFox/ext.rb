
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
      else
        self
      end
    end

    def resolve()
      puts '-> TheFox::Range::Lexer::Number.resolve'
      sleep(0.1)

      if @next_item.is_a?(Number)
        puts '-> next is Number'
        '%s%s' % [@char, @next_item.resolve]
      else @next_item.is_a?(Separator)
        @char.to_i
      end
    end
  end # Range
end # Lexer
end # Range
end # TheFox
