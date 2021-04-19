
require 'pp'

module TheFox
module Range
module Lexer2
  class BlockLevel
    def initialize()
      puts '-> BlockLevel.initialize()'
      @level = 0
    end

    # :nocov:
    def inspect()
      'BlockLevel()'
    end
    # :nocov:

    def inc()
      @level += 1
    end

    def dec()
      @level -= 1
    end

    def level()
      @level
    end
  end # BlockLevel
end # Lexer
end # Range
end # TheFox