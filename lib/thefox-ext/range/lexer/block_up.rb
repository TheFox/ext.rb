
module TheFox
module Range
module Lexer
  # }
  class BlockUp < Block
    def initialize(level)
      super()
      puts '-> BlockUp.initialize(%d)' % [level]
      @level = level
    end

    def inspect()
      'BlockUp(%d)' % [@level]
    end
  end # BlockUp
end # Lexer
end # Range
end # TheFox
