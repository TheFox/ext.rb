
require 'pp'

module TheFox
module Range
module Lexer2
  class Collection
    def initialize(items = nil)
      # puts '-> Collection.initialize()'
      @items = items.to_a
      @block_level = 0
    end

    # :nocov:
    def inspect()
      'Collection(L=%d %s)' % [
        @items.length,
        @items.map{ |i| i.inspect }
      ]
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

    def length()
      @items.length
    end

    def push(item)
      # puts '-> %s.push(%s)' % [self.inspect, item.inspect]
      if item.nil?
        return
      end

      # Prev
      org_prev_item = item.prev_item
      prev_item = @items.last

      # Dup
      curr_item = item.dup
      @items.push(curr_item)

      # Chain
      curr_item.chain(prev_item)
      curr_item.org_prev_item = org_prev_item

      if curr_item.class.keep_nonce_on_dup
        curr_item.nonce = item.nonce
      end
      if curr_item.class.keep_instance_id_on_dup
        curr_item.instance_id = item.instance_id
      end
    end

    def pop()
      @items.pop
    end
  end # Collection
end # Lexer
end # Range
end # TheFox
