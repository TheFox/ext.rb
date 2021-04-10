
module TheFox
module Range
module Lexer
  # -
  class Range < Base
    def initialize()
      super()
      puts '-> Range.initialize'
    end

    def inspect()
      'Range(%s)' % [@char]
    end
  end # Range
end # Lexer
end # Range
end # TheFox
