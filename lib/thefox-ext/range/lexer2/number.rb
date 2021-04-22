
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
      @is_ref_item = false
    end

    # :nocov:
    def inspect()
      a = [
        # '#' + @nonce.to_s,
        # 'c' + @char,
        @char,
      ]
      if !@parent_item.nil?
        a.push('^%s' % @parent_item.inspect)
      end
      a.push('IRI=%d' % [@is_ref_item])
      # if @children.length > 0
      #   a.push('v%d' % @children.length)
      # end
      'Number(%s)' % [a.join(' ')]
    end
    def dup()
      # puts '-> Number.dup(%s) -> %s %s' % [@char, inspect, self.is_ref_item ? 'Y' : 'n']
      # puts '-> %s.dup' % [inspect]
      o = super()
      o.is_ref_item = self.is_ref_item
      # puts '-> Number.dup(%s) -> %s' % [@char, o.inspect]
      o
    end
    # :nocov:

    def char
      @char
    end

    def is_ref_item
      @is_ref_item
    end
    def is_ref_item=(is_ref_item)
      @is_ref_item = is_ref_item
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
      if level >= 5
        raise 'Number level exceed'
      end
      puts '-> %s.resolve(%d)' % [self.inspect, @char, level]
      if self.has_parent_item
        if @parent_item.is_a?(Number)
          # ('%s%s' % [@parent_item.resolve(level + 1), @char]).to_i
          5000
        elsif @parent_item.is_a?(Scope)
          curr_item = @parent_item
          stack = [@char]
          while !curr_item.parent_scope.nil? do
            puts '-----> %s          %s' % [curr_item.inspect, curr_item.ref_item.inspect]

            if !curr_item.ref_item.nil?
              stack.push(curr_item.ref_item.char)
            end
            curr_item = curr_item.parent_scope
          end

          # pp stack.reverse

          stack.reverse.join.to_i

          # if @char == '5'
          #   2102
          # else
          #   9999
          # end
        else
          'Number.resolve ELSE'
        end
      else
        @char.to_i
      end
    end
  end # Number
end # Lexer
end # Range
end # TheFox
