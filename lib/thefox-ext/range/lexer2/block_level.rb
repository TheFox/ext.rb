
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
      'BlockLevel(%d)' % [@level]
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

    def ==(other)
      if other.is_a?(BlockLevel)
        @level == other.level
      end
    end
  end # BlockLevel
end # Lexer
end # Range
end # TheFox
