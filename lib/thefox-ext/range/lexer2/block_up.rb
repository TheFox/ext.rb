
module TheFox
module Range
module Lexer2
  # }
  class BlockUp < Block
    def initialize(level)
      super(level)
      level.dec
      # puts '-> BlockUp.initialize(%s)' % [level.inspect]
      # puts '-> BlockUp.initialize()'
    end

    # :nocov:
    def inspect()
      'BlockUp(%s)' % [@level.inspect]
      # 'BlockUp()'
    end
    # :nocov:
  end # BlockUp
end # Lexer
end # Range
end # TheFox
