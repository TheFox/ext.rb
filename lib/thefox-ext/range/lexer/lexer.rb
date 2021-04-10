
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
            BlockDown.new(block_level)
          when '}'
            org_level = block_level
            block_level -= 1
            BlockUp.new(org_level)
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
        puts '--> L2 item: %s' % [item.inspect]

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
        else
          # puts '--> L2 ELSE'

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
      append_dub_f = nil
      append_prev_f = nil
      prev_item = nil
      block_stack = []
      items3 = []
      items2.each do |item|
        puts '--> L3 item: %20s  bs=%d' % [item.inspect, block_stack.length]

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
        when BlockDown
          block_stack.push(item)
          append_dup = true
        when BlockUp
          block_stack.pop
          append_dup = true
        else
          # puts '--> L3 ELSE'
          append_dup = true
        end

        # Append Dup
        if append_dup
          # Dup
          curr_item = item.dup
          # Function
          if !append_dub_f.nil?
            append_dub_f.call(curr_item)
            append_dub_f = nil
          end
          # Chain
          if !prev_item.nil?
            prev_item.chain(curr_item)
          end
          # Block
          if !item.is_a?(Block)
            curr_item.parent_item = block_stack.last
          end
          # Append
          items3.push(curr_item)
          # Prev Item
          prev_item = curr_item
        end

        # Append Prev
        if append_prev && !prev_item.nil?
          # Dup
          curr_item = prev_item.dup
          # Function
          if !append_prev_f.nil?
            append_prev_f.call(curr_item)
            append_prev_f = nil
          end
          # Chain
          prev_item.chain(curr_item)
          # Block
          if !item.is_a?(Block)
            curr_item.parent_item = block_stack.last
          end
          # Append
          items3.push(curr_item)
          # Prev Item
          prev_item = curr_item
        end

        # Block
        if item.is_a?(Block)
          puts '--> L3 set parent block for block'
          item.parent_item = block_stack.last
        end
      end

      pp items3.map{ |item| item.inspect }

      puts
      puts '-> Lexer.resolve L4 [convert to int]'
      items4 = []
      items3.each do |item|
        puts '--> L4 item: %20s   parent: %s' % [item.inspect, item.parent_item.inspect]

        case item
        when Number
          # TODO handle Block here
          items4.push(item.char.to_i)
        when Range
          # TODO handle Block here
          r_begin = item.left_item.char.to_i
          r_end = item.right_item.char.to_i
          items4.push(*::Range.new(r_begin, r_end).to_a)
        when Separator
          puts '---> skip Separator'
        when Block
          puts '---> skip Block'
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
