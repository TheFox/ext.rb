
require 'pp'

module TheFox
module Range
module Lexer2
  class Lexer
    def initialize(chars)
      puts '-> Lexer2.initialize'
      @chars = chars
    end

    def resolve()
      puts
      puts '-> Lexer2.resolve L1 [Create Object for each character]'

      position = 0
      prev_item = nil
      block_level = 0
      items1 = []
      @chars.each do |char|
        position += 1

        curr_item = case char
          when ' '
            # Skip space
          when "\r"
            # Skip
          when ',', "\n"
            Separator.new()
          # when '{'
          #   block_level += 1
          #   BlockDown.new(block_level)
          # when '}'
          #   org_level = block_level
          #   block_level -= 1
          #   BlockUp.new(org_level)
          # when '+'
          #   Operator.new()
          when '-', '.'
            Range.new(char)
          # when '/'
          #   Interval.new()
          when '0'..'9'
            Number.new(char)
          else
            raise 'Unknown character at position %d: "%s" (%d)' % [position, char, char.ord]
          end

        if !prev_item.nil?
          prev_item.chain(curr_item)
        end
        items1.push(curr_item)
        prev_item = curr_item
      end

      puts '-> Lexer2.resolve L1 Items'
      pp items1.map{ |item| item.inspect }

      puts
      puts '-> Lexer2.resolve L2 [Append Number]'
      curr_item = nil
      prev_item = nil
      items2 = []
      items1.each do |item|
        # puts '--> L2 item: %s' % [item.inspect]

        append_dup = false

        case item
        when Number
          if curr_item.nil?
            # New Number
            curr_item = item.dup
            if !prev_item.nil?
              prev_item.chain(curr_item)
            end
            items2.push(curr_item)
            prev_item = curr_item
          else
            # Append Number
            if curr_item.is_a?(Number)
              curr_item.append(item.char)
            else
              raise 'Do not know what to do'
            end
          end
        when Range
          if prev_item.is_a?(Range) && prev_item.symbole == '.' && item.symbole == '.'
            # skip
          else
            append_dup = true
          end
        else
          # puts '--> L2 ELSE'

          append_dup = true
        end

        if append_dup
          curr_item = item.dup
          if !prev_item.nil?
            prev_item.chain(curr_item)
          end
          items2.push(curr_item)
          prev_item = curr_item

          curr_item = nil
        end
      end

      puts '-> Lexer2.resolve L2 Items'
      pp items2.map{ |item| item.inspect }

      puts
      scope = Scope.new(items2)
      scope.resolve
    end
  end # Lexer
end # Lexer
end # Range
end # TheFox
