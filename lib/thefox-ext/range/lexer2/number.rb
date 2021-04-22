
require 'pp'

module TheFox
module Range
module Lexer2
  # 0123456789
  class Number < Base
    def initialize(char)
      super()
      # puts '-> Number.initialize(%s)' % [char]
      #@nonce = rand(10 ** 3).to_s.rjust(3, '0')
      @char = char
    end

    # :nocov:
    def inspect()
      a = ['#' + @nonce.to_s, 'c' + @char]
      if !@parent_item.nil?
        a.push('^%s' % @parent_item.inspect)
      end
      if @children.length > 0
        a.push('v%d' % @children.length)
      end
      'Number(%s)' % [a.join(' ')]
    end
    # :nocov:

    def char
      @char
    end

    def append(obj)
      if obj.is_a?(Number)
        self.append(obj.char)
      else
        @char += obj
      end
    end

    def inc()
      f = '%%0%dd' % [@char.length]
      @char = f % [@char.to_i + 1]
    end

    def resolve(level = 0)
      # puts '-> %s.resolve(%d)' % [self.inspect, @char, level]
      if self.has_parent_item
        '%s%s' % [@parent_item.resolve(level + 1), @char.to_i]
      else
        @char.to_i
      end
    end
  end # Number
end # Lexer
end # Range
end # TheFox
