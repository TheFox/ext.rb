
module TheFox
module Range
module Lexer2
  class Chain
    def initialize(symbole = nil)
      # puts '-> Chain.initialize'

      @prev_item = nil
      @next_item = nil
    end

    def chain(prev_item)
      self.prev_item = prev_item
      if !prev_item.nil?
        prev_item.next_item = self
      end
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

    def resolve()
      puts '-> Base.resolve'
    end
  end # Base
end # Lexer
end # Range
end # TheFox
