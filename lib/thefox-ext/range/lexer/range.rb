
module TheFox
module Range
module Lexer
  # x to y
  class Range < Base
    def initialize()
      super()
      puts '-> TheFox::Range::Lexer::Range.initialize'
    end
    def resolve()
      puts '-> TheFox::Range::Lexer::Range.resolve'
      super()
      # ::Range.new(1,2).to_a
    end
  end # Range
end # Lexer
end # Range
end # TheFox
