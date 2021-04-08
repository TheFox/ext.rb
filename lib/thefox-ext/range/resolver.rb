
require 'pp'

module TheFox
module Range
  # Resolve a range string to an array.
  # A range string can be like '1, 3..5, 9-11, 12+, 14++, 17+++'.
  # Which will be resolved to [1, 3, 4, 5, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20].
  class Resolver
    def initialize(original = nil)
      puts '-> TheFox::Range::Resolver.initialize'
      @original = original
    end

    def to_a
      puts '-> TheFox::Range::Resolver.to_a'

      lexer = Lexer::Lexer.new(@original.split(''))
      lexer.resolve
    end
  end # Resolver
end # Range
end # TheFox
