
module TheFox
module Range
module Lexer
  class Base
    def initialize()
      # puts '-> TheFox::Range::Lexer::Base.initialize'
      @prev_item = nil
      @next_item = nil
      @parent_item = nil
    end

    def prev_item=(prev_item)
      @prev_item = prev_item
    end
    def next_item=(next_item)
      @next_item = next_item
    end

    def parent_item=(parent_item)
      @parent_item = parent_item
    end

    def lex()
      nil
    end

    def resolve()
      # puts '-> TheFox::Range::Lexer::Base.resolve'
      nil
    end
  end # Base
end # Lexer
end # Range
end # TheFox
