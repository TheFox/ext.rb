
module TheFox
module Range
module Lexer
  # +
  class Operator < Base
    def initialize()
      super()
      puts '-> Operator.initialize'
    end
    def resolve()
      puts '-> Operator.resolve'
      super()
    end
  end # Operator
end # Lexer
end # Range
end # TheFox
