
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

    # :nocov:
    def inspect()
      if !@left_item.nil? && !@right_item.nil?
        'Range("%s" %s %s)' % [@symbole, @left_item.inspect, @right_item.inspect]
      else
        'Range(%s)' % [@symbole]
      end
    end
    # :nocov:

    # def left_item()
    #   @left_item
    # end
    def left_item=(left_item)
      @left_item = left_item.dup
    end

    # def right_item()
    #   @right_item
    # end
    def right_item=(right_item)
      @right_item = right_item.dup
    end

    def resolve()
      puts '-> %s.resolve()' % [inspect]
      if @left_item.is_a?(Number) && @right_item.is_a?(Number)
        ::Range.new(@left_item.resolve, @right_item.resolve).to_a
      end
    end
  end # Range
end # Lexer
end # Range
end # TheFox
