
module TheFox
module Range
module Lexer
  # +
  class Operator < Base
    def initialize()
      super()
      # puts '-> Operator.initialize'
    end

    # :nocov:
    def inspect()
      'Operator()'
    end
    # :nocov:
  end # Operator
end # Lexer
end # Range
end # TheFox
