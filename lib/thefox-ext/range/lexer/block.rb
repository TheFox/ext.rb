
module TheFox
module Range
module Lexer
  # { }
  class Block < Scope
    def initialize(level)
      super()
      puts '-> Block.initialize(%d)' % [level]
      @level = level
    end

    def inspect()
      'Block(%d)' % [@level]
    end
  end # Block
end # Lexer
end # Range
end # TheFox
