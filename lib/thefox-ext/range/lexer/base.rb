
module TheFox
module Range
module Lexer
  class Base
    def initialize()
      # puts '-> Base.initialize'
      @prev_item = nil
      @next_item = nil
    end

    def prev_item=(prev_item)
      @prev_item = prev_item
    end
    def next_item=(next_item)
      @next_item = next_item
    end
  end # Base
end # Lexer
end # Range
end # TheFox
