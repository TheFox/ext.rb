
module TheFox
module Range
module Lexer
  # }
  class LevelUp < Base
    def initialize(direction)
      super()
      puts '-> TheFox::Range::Lexer::LevelUp.initialize'
    end
    def resolve()
      puts '-> TheFox::Range::Lexer::LevelUp.resolve'
      super()
    end
  end # LevelUp
end # Lexer
end # Range
end # TheFox
