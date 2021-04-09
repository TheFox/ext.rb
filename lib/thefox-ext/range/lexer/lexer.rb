
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
      puts '-> Lexer.resolve L1'
      # @chars.each do |char|
      #   puts '-> char: "%s"' % [char]
      # end

      prev_item = nil
      # curr_number = nil
      # curr_block = nil
      block_level = 0
      items_l1 = []
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
        items_l1.push(curr_item)
        prev_item = curr_item
      end

      puts '-> Lexer.resolve L2'
      items_l2 = []
      prev_item = nil
      items_l1.each do |item|
        # if item.is_a?(Scope)
        #   puts '--> new Scope'
        #   prev_item = nil
        # end

        if item.is_resolved
          puts '-> skip already resolved item'
          next
        end

        case item
        when Number
          puts '-> item is Number'
          curr_item = Number.new(item.resolve)
        else
          curr_item = item.dup
          puts '-> ELSE: %s' % [curr_item.class]
        end

        if !prev_item.nil?
          prev_item.next_item = curr_item
          curr_item.prev_item = prev_item
        end
        items_l2.push(curr_item)
        prev_item = curr_item
      end

      items_l3 = []
      items_l2.each do |item|
        case item
        when Range
          items_l3.push(*item.resolve)
        end
      end

      items_l3
      # pp items_l3.map{ |i| i.inspect }

      # items_l3
      #   .map{ |i| i.resolve }
        # .flatten
        # .map{ |i|
        #   if i.is_a?(String)
        #     i.to_i
        #   end
        # }
    end
  end # Lexer
end # Lexer
end # Range
end # TheFox
