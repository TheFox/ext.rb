
module TheFox
module Range
module Lexer
  # -
  class Range < Base
    def initialize()
      super()
      puts '-> Range.initialize'
      # @resolvers = [lambda{
      #   if @prev_item.is_a?(Number) && @next_item.is_a?(Number)
      #     [@prev_item.resolve]
      #   else
      #     raise 'Lexer: Invalid Range Syntax'
      #   end
      # }]
    end

    def inspect()
      'Range(%s)' % [@char]
    end

    def resolve()
      # puts '-> Range.resolve'
      if @prev_item.is_a?(Number) && @next_item.is_a?(Number)
        r_begin = @prev_item.resolve.to_i
        r_end = @next_item.resolve.to_i
        ::Range.new(r_begin, r_end).to_a
      else
        raise 'Lexer: Invalid Range Syntax'
      end
    end
  end # Range
end # Lexer
end # Range
end # TheFox
