
module TheFox
module Range
module Lexer
  # +
  class Operator < Base
    def initialize()
      super()
      puts '-> Operator.initialize'
    end

    def inspect()
      'Operator()'
    end
  end # Operator
end # Lexer
end # Range
end # TheFox
