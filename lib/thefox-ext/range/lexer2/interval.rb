
module TheFox
module Range
module Lexer2
  # x-y/n
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
      @number = number.dup
    end

    def resolve()
      puts '-> %s.resolve()' % [inspect]
      if @number.nil?
        1
      else
        @number.resolve
      end
    end
  end # Interval
end # Lexer
end # Range
end # TheFox
