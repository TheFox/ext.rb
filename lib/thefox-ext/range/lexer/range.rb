
module TheFox
module Range
module Lexer
  # -
  class Range < Base
    def initialize()
      super()
      puts '-> Range.initialize'

      @left_item = nil
      @right_item = nil
    end

    def left_item()
      @left_item
    end
    def left_item=(left_item)
      @left_item = left_item
    end

    def right_item()
      @right_item
    end
    def right_item=(right_item)
      @right_item = right_item
    end

    def inspect()
      if !@left_item.nil? && !@right_item.nil?
        'Range(%s, %s)' % [@left_item.inspect, @right_item.inspect]
      else
        'Range()'
      end
    end
  end # Range
end # Lexer
end # Range
end # TheFox
