
require 'pp'

module TheFox
module Range
module Lexer
  class Lexer
    def initialize(chars)
      puts '-> TheFox::Range::Lexer::Lexer.initialize'
      @chars = chars
    end

    def resolve()
      puts '-> TheFox::Range::Lexer::Lexer.resolve'
      @chars.each do |char|
        puts '-> char: "%s"' % [char]
      end

      prev_item = nil
      items_l1 = []
      @chars.each do |char|
        curr_item = case char
        when ','
          Separator.new()
        when '{'
          LevelDown.new()
        when '}'
          LevelUp.new()
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
        items_l1.push(curr_item)
        prev_item = curr_item
      end

      puts ''

      # items_l2 = items_l1
      puts '-> lex'
      items_l2 = items_l1.map{ |item|
        puts '-> lex item: %s -> %s' % [item.class.to_s, item.lex.class.to_s]
        item.lex
      }.filter{ |item| !item.nil? }

      puts ''

      puts '-> resolve A'
      items_l2.each do |item|
        puts '-> resolve item: %s' % [item.class.to_s]
        item.resolve
      end

      puts ''
      puts '-> resolve B'
      items_l2
        .map{ |item| item.resolve }
        .map{ |item|
          if item.is_a?(::String)
            item.to_i
          end
        }
    end
  end # Lexer
end # Lexer
end # Range
end # TheFox
