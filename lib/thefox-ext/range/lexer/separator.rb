
module TheFox
module Range
module Lexer
  class Separator < Scope
    def initialize()
      super()
      puts '-> Separator.initialize()'
    end
    def inspect()
      'Separator'
    end
  end # Separator
end # Lexer
end # Range
end # TheFox
