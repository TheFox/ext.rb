
module TheFox
module Range
module Lexer
  # }
  class LevelDown < Base
    def initialize(direction)
      super()
      puts '-> TheFox::Range::Lexer::LevelDown.initialize'
    end
    def resolve()
      puts '-> TheFox::Range::Lexer::LevelDown.resolve'
      super()
    end
  end # LevelDown
end # Lexer
end # Range
end # TheFox
