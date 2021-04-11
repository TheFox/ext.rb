
require 'pp'

module TheFox
module Range
module Lexer
  # 0123456789
  class BlockStack
    def initialize()
      puts '-> BlockStack.initialize()'
      @stack = []
    end

    def inspect()
      'BlockStack(%d)' % [@stack.length]
    end

    def push(item)
      @stack.push(item)
    end

    def pop()
      @stack.pop
    end

    def last()
      @stack.last
    end

    def curr()
      @stack.last
    end

    def length()
      @stack.length
    end

    def add_child(item)
      if !@stack.last.nil? && !item.nil?
        @stack.last.add_child(item)
      end
    end
  end # BlockStack
end # Lexer
end # Range
end # TheFox
