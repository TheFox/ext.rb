
module TheFox
module Range
module Lexer
  class Base
    def initialize()
      # puts '-> Base.initialize'
      @prev_item = nil
      @next_item = nil
    end

    def chain(item)
      self.next_item = item
      item.prev_item = self
    end

    def prev_item()
      @prev_item
    end
    def prev_item=(prev_item)
      @prev_item = prev_item
    end

    def next_item()
      @next_item
    end
    def next_item=(next_item)
      @next_item = next_item
    end

    def dup()
      # puts '-> Base.dup'
      o = super()
      o.prev_item = nil
      o.next_item = nil
      o
    end
  end # Base
end # Lexer
end # Range
end # TheFox
