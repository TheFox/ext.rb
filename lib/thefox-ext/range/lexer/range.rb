
module TheFox
module Range
module Lexer
  # -
  class Range < Base
    def initialize()
      super()
      puts '-> TheFox::Range::Lexer::Range.initialize'
    end
    def resolve()
      puts '-> TheFox::Range::Lexer::Range.resolve -> %s %s' % [@prev_item.class.to_s, @next_item.class.to_s]

      if @prev_item.is_a?(Number) && @next_item.is_a?(Number)
        '%s%s' % [@prev_item.resolve, @next_item.resolve]
      end
    end
  end # Range
end # Lexer
end # Range
end # TheFox
