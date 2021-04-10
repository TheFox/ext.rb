
require 'pp'

module TheFox
module Range
module Lexer
  class Lexer
    def initialize(chars)
      puts '-> Lexer.initialize'
      @chars = chars
    end

    def resolve()
      puts '-> Lexer.resolve L1'

      prev_item = nil
      block_level = 0
      items1 = []
      @chars.each do |char|
        curr_item = case char
        when ','
          Separator.new()
        when '{'
          block_level += 1
          Block.new(block_level)
        when '}'
          block_level -= 1
        when '+'
          Operator.new()
        when '-'
          Range.new()
        when '0'..'9'
          Number.new(char)
        end

        if !prev_item.nil?
          prev_item.next_item = curr_item
          curr_item.prev_item = prev_item
        end
        items1.push(curr_item)
        prev_item = curr_item
      end

      pp items1.map{ |item| item.inspect }
    end
  end # Lexer
end # Lexer
end # Range
end # TheFox
