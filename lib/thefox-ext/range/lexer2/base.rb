
module TheFox
module Range
module Lexer2
  class Base
    def initialize(symbole = nil)
      # puts '-> Base.initialize'

      @symbole = symbole
      @prev_item = nil
      @next_item = nil

      @parent_item = nil
      @children = []
    end

    def chain(prev_item)
      self.prev_item = prev_item
      if !prev_item.nil?
        prev_item.next_item = self
      end
    end

    def symbole()
      @symbole
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
    def has_parent_item()
      !@parent_item.nil?
    end

    def children()
      @children
    end
    def add_child(child)
      @children.push(child)
    end
    def has_children()
      @children.length > 1
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
