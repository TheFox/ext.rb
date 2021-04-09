
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
    def dup()
      puts '-> Block.dup'
      super()
    end
    # def resolve()
    #   puts '-> TheFox::Range::Lexer::Block.resolve'
    #   super()
    # end
  end # Block
end # Lexer
end # Range
end # TheFox
