
module TheFox
module Range
module Lexer
  class Base
    def initialize()
      # puts '-> Base.initialize'
      @prev_item = nil
      @next_item = nil

      @parent_item = nil
      # @children = []
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

    def parent_item()
      @parent_item
    end
    def parent_item=(parent_item)
      @parent_item = parent_item
    end

    # def children()
    #   @children
    # end
    # def add_child(child)
    #   @children.push(child)
    # end

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
