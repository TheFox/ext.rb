
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
      'Number(%s,^%s)' % [@char, @parent_item.inspect]
    end

    def char()
      puts '-> %s.char' % [self.inspect]
      if self.has_parent_item
        puts '-> %s.char has parent' % [self.inspect]
        if self.parent_item.is_a?(Block)
          puts '-> %s.char parent is a %s' % [self.inspect, self.parent_item.inspect]
          if self.parent_item.prev_item.is_a?(Number)
            puts '-> %s.char parent Prev is a %s' % [self.inspect, self.parent_item.prev_item.inspect]
            '%s%s' % [self.parent_item.prev_item.char, @char]
          else
            raise 'Parent Prev item for %s is not a Block: %s' % [
              self.inspect,
              self.parent_item.prev_item.inspect,
            ]
          end
        else
          raise 'Parent item for %s is not a Block: %s' % [self.inspect, self.parent_item.inspect]
        end
      else
        puts '-> %s.char char' % [self.inspect]
        @char
      end
    end

    def append(char)
      @char += char
    end

    def inc()
      f = '%%0%dd' % [@char.length]
      @char = f % [@char.to_i + 1]
    end

    def dec()
      f = '%%0%dd' % [@char.length]
      @char = f % [@char.to_i - 1]
    end
  end # Number
end # Lexer
end # Range
end # TheFox
