
require 'pp'

module TheFox
module Range
  # Resolve a range string to an array.
  # A range string can be like '1, 3..5, 9-11, 12+, 14++, 17+++'.
  # Which will be resolved to [1, 3, 4, 5, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20].
  # '1' -> [1]
  # '1,3,99' -> [1, 3, 99]
  # '1-5' -> [1, 2, 3, 4, 5]
  # '1+,5++' -> [1, 2, 5, 6, 7]
  # '1-10/2' -> [1, 3, 5, 7, 9]
  # '1{1}' -> [11]
  # '1{5-7}' -> [15, 16, 17]
  # '1{1,02}' -> [11, 102]
  # '2{3{4,5},6}' -> [234, 235, 26]
  # '1-3/1' -> [1, 2, 3]
  # '1-10/2' -> [1, 3, 5, 7, 9]
  # '2{10-20/2}' -> [210, 212, 214, 216, 218, 220]
  class Resolver2
    def initialize(original = nil)
      puts '-> TheFox::Range::Resolver2.initialize'
      @original = original.to_s
    end

    def to_a
      puts '-> TheFox::Range::Resolver2.to_a'

      lexer = Lexer2::Lexer.new(@original.to_s.split(''))
      lexer.resolve
    end
  end # Resolver
end # Range
end # TheFox
