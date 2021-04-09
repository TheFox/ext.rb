
require 'pp'

module TheFox
module Range
module Lexer
  # 0123456789
  class Number < Base
    def initialize(char)
      super()
      # puts '-> Number.initialize(%s)' % [char]
      @char = char
      # @resolvers = [lambda{@char}]
      # @resolvers = [lambda{
      #   puts '-> Resolve %s' % [self.inspect]
      #   if @next_item.is_a?(Number)
      #     puts '--> has next item'
      #     [@char, @next_item.resolve].flatten.join()
      #   elsif @next_item.is_a?(Range)
      #   else
      #     puts '--> next is not Number'
      #     @char
      #   end
      # }]
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

    def resolve()
      puts '-> Number.resolve(%s)' % [@char]
      super()

      if @next_item.is_a?(Number)
        # puts '--> next is Number'
        '%s%s' % [@char, @next_item.resolve]
      else
        # puts '--> next is ELSE'
        @char
      end
    end
  end # Range
end # Lexer
end # Range
end # TheFox
