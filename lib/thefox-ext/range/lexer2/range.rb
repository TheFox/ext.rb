
require 'colorize'

module TheFox
module Range
module Lexer2
  # - ..
  class Range < Base
    def initialize(symbole)
      super(symbole)
      # puts '-> Range.initialize(%s)' % [symbole]

      @left_item = nil
      @right_item = nil
      @interval = nil
    end

    # :nocov:
    def inspect()
      if !@left_item.nil? && !@right_item.nil?
        'Range(#%s s=%s l=%s r=%s i=%s)' % [
          @nonce,
          @symbole,
          @left_item.inspect,
          @right_item.inspect,
          @interval.inspect
        ]
      else
        'Range(#%s %s)' % [@nonce, @symbole]
      end
    end
    # :nocov:

    def left_item=(left_item)
      @left_item = left_item.dup
    end

    def right_item=(right_item)
      @right_item = right_item.dup
    end
    def right_item()
      @right_item
    end

    def interval()
      @interval
    end
    def interval=(interval)
      @interval = interval.dup
    end

    def resolve()
      # puts '-> %s.resolve()'.colorize(:red) % [inspect]
      if @left_item.is_a?(Number) && @right_item.is_a?(Number)
        r = ::Range.new(@left_item.resolve, @right_item.resolve)
        if @interval.is_a?(Interval)
          # puts '--> I=%s'.colorize(:red) % [@interval.inspect]
          r = r.step(@interval.resolve)
        end
        # puts '--> %s'.colorize(:red) % [r.inspect]
        r.to_a
      end
    end
  end # Range
end # Lexer
end # Range
end # TheFox
