
module TheFox
module Range
module Lexer2
  # {
  class BlockDown < Block
    def initialize(level)
      level.inc
      super(level)
      puts '-> BlockDown.initialize(%s)' % [level.inspect]
    end

    # :nocov:
    def inspect()
      'BlockDown(%s)' % [@level.inspect]
    end
    # :nocov:
  end # BlockDown
end # Lexer
end # Range
end # TheFox
