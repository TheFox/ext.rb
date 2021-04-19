
module TheFox
  module Range
  module Lexer
    # /n
    class Interval < Base
      def initialize()
        super()
        # puts '-> Interval.initialize()'
        @number = nil
      end

      # :nocov:
      def inspect()
        if @number.nil?
          'Interval()'
        else
          'Interval(%s)' % [@number.inspect]
        end
      end
      # :nocov:

      def number=(number)
        @number = number
      end
      def number()
        @number
      end
    end # Interval
  end # Lexer
  end # Range
  end # TheFox
