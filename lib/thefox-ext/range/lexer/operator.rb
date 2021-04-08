
module TheFox
module Range
module Lexer
  # + -
  class Operator < Base
    def initialize()
      super()
      puts '-> TheFox::Range::Lexer::Operator.initialize'
    end
    def resolve()
      puts '-> TheFox::Range::Lexer::Operator.resolve'
      super()
    end
  end # Operator
end # Lexer
end # Range
end # TheFox
