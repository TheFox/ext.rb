
module TheFox
module Range
module Lexer
  # -
  class Range < Base
    def initialize()
      super()
      puts '-> TheFox::Range::Lexer::Range.initialize'
    end

    # def resolve()
    #   puts '-> TheFox::Range::Lexer::Range.resolve'

    #   if @prev_item.is_a?(Number) && @next_item.is_a?(Number)
    #     r_begin = @prev_item.resolve
    #     r_end = @next_item.resolve
    #     ::Range.new(r_begin, r_end).to_a
    #   end
    # end
  end # Range
end # Lexer
end # Range
end # TheFox
