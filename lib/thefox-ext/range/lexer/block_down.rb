
module TheFox
module Range
module Lexer
  # {
  class BlockDown < Block
    def initialize(level)
      super()
      # puts '-> BlockDown.initialize(%d)' % [level]
      @level = level
    end

    # :nocov:
    def inspect()
      'BlockDown(%d)' % [@level]
    end
    # :nocov:
  end # BlockDown
end # Lexer
end # Range
end # TheFox
