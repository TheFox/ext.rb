
module TheFox
module Range
module Lexer2
  # -
  class Range < Base
    def initialize(symbole)
      super(symbole)
      puts '-> Range.initialize(%s)' % [symbole]

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

    # :nocov:
    def inspect()
      if !@left_item.nil? && !@right_item.nil?
        'Range(%s, %s, %s)' % [@symbole, @left_item.inspect, @right_item.inspect]
      else
        'Range(%s)' % [@symbole]
      end
    end
    # :nocov:
  end # Range
end # Lexer
end # Range
end # TheFox
