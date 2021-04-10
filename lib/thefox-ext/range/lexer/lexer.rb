
require 'pp'

module TheFox
module Range
module Lexer
  class Lexer
    def initialize(chars)
      puts '-> Lexer.initialize'
      @chars = chars
      pp @chars
    end

    def resolve()
      puts
      puts '-> Lexer.resolve L1'

      position = 0
      prev_item = nil
      block_level = 0
      items1 = []
      @chars.each do |char|
        position += 1

        curr_item = case char
          when ','
            Separator.new()
          when '{'
            block_level += 1
            Block.new(block_level)
          when '}'
            block_level -= 1
            nil
          when '+'
            Operator.new()
          when '-'
            Range.new()
          when '0'..'9'
            Number.new(char)
          else
            raise 'Unknown character at position %d: %s' % [position, char]
          end

        if curr_item.nil?
          next
        end

        if !prev_item.nil?
          prev_item.chain(curr_item)
        end
        items1.push(curr_item)
        prev_item = curr_item
      end

      pp items1.map{ |item| item.inspect }

      puts
      puts '-> Lexer.resolve L2'
      curr_item = nil
      prev_item = nil
      items2 = []
      items1.each do |item|
        puts '--> item: %s' % [item.inspect]

        case item
        when Number
          if curr_item.nil?
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
        else
          puts '--> L2 ELSE'

          curr_item = item.dup
          if !prev_item.nil?
            prev_item.chain(curr_item)
          end
          items2.push(curr_item)
          prev_item = curr_item

          curr_item = nil
        end
      end

      pp items2.map{ |item| item.inspect }

      puts
      puts '-> Lexer.resolve L3'
      # curr_item = nil
      append_dub_f = nil
      append_prev_f = nil
      prev_item = nil
      items3 = []
      items2.each do |item|
        puts '--> item: %s  prev: %s  next: %s' % [item.inspect, item.prev_item.inspect, item.next_item.inspect]

        append_dup = false
        append_prev = false

        case item
        when Number
          if item.next_item.is_a?(Range) || item.prev_item.is_a?(Range)
            # skip
          else
            append_dup = true
          end
        when Range
          if item.prev_item.is_a?(Number) && item.next_item.is_a?(Number)
            # puts '--> Range normal'
            append_dub_f = -> (curr_item){
              curr_item.left_item = item.prev_item.dup
              curr_item.right_item = item.next_item.dup
            }
            append_dup = true
          else
            raise 'Invalid Range: %s %s' % [
              item.prev_item.inspect,
              item.next_item.inspect,
            ]
          end
        when Operator
          if prev_item.is_a?(Number)
            append_prev_f = -> (curr_item){ curr_item.inc }
            append_prev = true
          end
        else
          # puts '--> L3 ELSE'
          append_dup = true
        end

        if append_dup
          curr_item = item.dup
          if !append_dub_f.nil?
            append_dub_f.call(curr_item)
            append_dub_f = nil
          end
          if !prev_item.nil?
            prev_item.chain(curr_item)
          end
          items3.push(curr_item)
          prev_item = curr_item
        end

        if append_prev && !prev_item.nil?
          curr_item = prev_item.dup
          if !append_prev_f.nil?
            append_prev_f.call(curr_item)
            append_prev_f = nil
          end
          prev_item.chain(curr_item)
          items3.push(curr_item)
          prev_item = curr_item
        end
      end

      pp items3.map{ |item| item.inspect }

      puts
      puts '-> Lexer.resolve L4 [convert to int]'
      items4 = []
      items3.each do |item|
        puts '--> item: %s' % [item.inspect]

        case item
        when Number
          items4.push(item.char.to_i)
        when Range
          r_begin = item.left_item.char.to_i
          r_end = item.right_item.char.to_i
          items4.push(*::Range.new(r_begin, r_end).to_a)
        when Separator
        else
          raise 'Implementation missing for: %s' % [item.inspect]
        end
      end

      pp items4

    end
  end # Lexer
end # Lexer
end # Range
end # TheFox
