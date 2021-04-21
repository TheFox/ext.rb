
module TheFox
module Range
module Lexer2
  # { }
  class Block < Base
    def initialize(level)
      super()
      puts '-> Block.initialize(%s)' % [level.inspect]
      @level = level.dup
    end

    def level()
      @level
    end
  end # Block
end # Lexer
end # Range
end # TheFox
