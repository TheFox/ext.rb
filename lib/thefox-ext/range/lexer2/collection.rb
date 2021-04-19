
require 'pp'

module TheFox
module Range
module Lexer2
  class Collection
    def initialize(items = nil)
      puts '-> Collection.initialize()'
      @items = items.to_a
      @block_level = 0
    end

    # :nocov:
    def inspect()
      'Collection()'
    end
    # :nocov:

    def items()
      @items
    end

    def curr()
      @items.last
    end

    def prev()
      @items[-2]
    end

    def is_empty()
      @items.length == 0
    end

    def push(item)
      puts '-> Collection.push()'

      # Prev
      prev_item = @items.last

      # Dup
      curr_item = item.dup
      @items.push(curr_item)

      # Chain
      curr_item.chain(prev_item)
    end
  end # Collection
end # Lexer
end # Range
end # TheFox