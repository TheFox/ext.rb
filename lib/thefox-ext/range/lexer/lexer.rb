
module TheFox
module Range
module Lexer
  class Lexer
    def initialize(chars)
      # puts '-> Lexer2.initialize'
      @chars = chars
    end

    def resolve()
      # puts
      # puts '-> Lexer2.resolve L1 [Create Object for each character]'

      block_level = BlockLevel.new
      item_collection1 = Collection.new
      position = 0
      @chars.each do |char|
        position += 1
        curr_item = case char
          when ' '
            # Skip space
          when "\r"
            # Skip
          when ',', "\n"
            Separator.new()
          when '{'
            BlockDown.new(block_level)
          when '}'
            BlockUp.new(block_level)
          when '+'
            Operator.new()
          when '-', '.'
            Range.new(char)
          when '/'
            Interval.new()
          when '0'..'9'
            Number.new(char)
          else
            raise 'Unknown character at position %d: "%s" (ord=%d)' % [
              position, char, char.ord
            ]
          end

        item_collection1.push(curr_item)
      end

      # puts '-> Lexer2.resolve L1 Items'
      # pp item_collection1.items.map{ |item| item.inspect }

      # puts
      # puts '-> Lexer2.resolve L2 [Append Number]'
      item_collection2 = Collection.new
      item_collection1.items.each do |item|
        # puts '--> L2 item: %s' % [item.inspect]

        case item
        when Number
          if item_collection2.curr.is_a?(Number)
            item_collection2.curr.append(item)
          else
            item_collection2.push(item)
          end
        when Range
          # puts '--> L2 Its Range: %s  %s  %s %s %s' % [
          #   item.inspect,
          #   item_collection2.curr.inspect,
          #   item_collection2.curr.is_a?(Range) ? 'Y' : 'n',
          #   item_collection2.curr.symbole == '.' ? 'Y' : 'n',
          #   item.symbole == '.' ? 'Y' : 'n',
          # ]
          if item_collection2.curr.is_a?(Range) && item_collection2.curr.symbole == '.' && item.symbole == '.'
            # puts '--> L2 Skip'
          else
            item_collection2.push(item)
          end
        else
          # puts '--> L2 ELSE'
          item_collection2.push(item)
        end # case item

      end # item_collection1.items

      # puts '-> Lexer2.resolve L2 Items'
      # pp item_collection2.items.map{ |item| item.inspect }

      # puts
      scope = Scope.new(item_collection2.items)
      scope.resolve
    end
  end # Lexer
end # Lexer
end # Range
end # TheFox
