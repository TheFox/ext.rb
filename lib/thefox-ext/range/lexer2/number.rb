
require 'pp'

module TheFox
module Range
module Lexer2
  # 0123456789
  class Number < Base
    def initialize(char)
      super()
      # puts '-> Number.initialize(%s)' % [char]
      @char = char
    end

    # :nocov:
    def inspect()
      if @parent_item.nil?
        'Number(%s)' % [@char]
      else
        'Number(%s ^%s)' % [@char, @parent_item.inspect]
      end
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
      puts '-> %s.resolve(%d)' % [self.inspect, @char, level]
      if self.has_parent_item
        '%s_%s' % [@parent_item.resolve(level + 1), @char.to_i]
      else
        @char.to_i
      end
      # if @parent_item.nil? && @children.length == 0
      #   @char.to_i
      # elsif @children.length == 0
      #   '%s_%s' % [@parent_item.resolve(level + 1), @char.to_i]
      # elsif @parent_item.nil?
      #   if level > 0
      #     'C{%d}' % [level]
      #   end
      # else
      #   'x'
      # end
    end
  end # Number
end # Lexer
end # Range
end # TheFox
