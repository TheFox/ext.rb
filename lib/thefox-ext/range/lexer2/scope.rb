
module TheFox
module Range
module Lexer2
  class Scope < Collection
    def initialize(items = nil, level = 0)
      super(items)
      @level = level
      puts '-> %s.initialize()' % [self.name]
    end

    # :nocov:
    def name()
      'Scope(%d)' % [
        @items.length,
      ]
    end
    def inspect()
      'Scope(%d [%s])' % [
        @items.length,
        @items.map{ |item| item.inspect }.join(', '),
      ]
    end
    # :nocov:

    def resolve()
      puts '-> %s.resolve(%d)' % [self.name, @level]

      scopes = [Scope.new(nil, @level + 1)]

      @items.each do |item|
        puts '--> Item: %s' % [item.inspect]

        case item
        when Separator
          puts '--> next scope'
          scopes.push(Scope.new(nil, @level + 1))
        else
          scopes.last.push(item)
        end
      end

      puts '--> Scopes: %d' % [scopes.length]
      # pp scopes

      if scopes.length > 1
        puts '--> resolve sub scopes'
        resolved = []
        scopes.each do |scope|
          puts '--> Scope: %s' % [scope.inspect]
          resolved.push(scope.resolve)
        end
        resolved
      else
        puts
        puts '-> Lexer2.resolve L3'
        item_collection1 = Collection.new
        scopes.last.items.each do |item|
          puts '--> Scope Item: %s' % [item.inspect]

          case item
          when Number
            if item.next_item.is_a?(Range) || item.prev_item.is_a?(Range)
              # Skip Range
              # puts '--> Skip Range'
            elsif item.prev_item.is_a?(Interval)
              # Skip Interval
              # puts '--> Skip Interval'
            elsif item.next_item.is_a?(Operator)
              # Skip
            else
              item_collection1.push(item)
            end
          when Range
            if item.prev_item.is_a?(Number) && item.next_item.is_a?(Number)
              # puts '--> Range normal'
              item_collection1.push(item)
              item_collection1.curr.left_item = item.prev_item
              item_collection1.curr.right_item = item.next_item

              # 1-10/3
              # item.prev_item                       Number
              # item                                 Range
              # item.next_item                       Number
              # item.next_item.next_item             Interval
              # item.next_item.next_item.next_item   Number

              interval_item = item.next_item.next_item
              if interval_item.is_a?(Interval)
                item_collection1.curr.interval = interval_item
                item_collection1.curr.interval.number = item.next_item.next_item.next_item
              end
            else
              raise 'Invalid Range: %s %s' % [
                item.prev_item.inspect,
                item.next_item.inspect,
              ]
            end
          when Interval
            # Skip
          when Operator
            if item_collection1.curr.is_a?(Range)
              puts '--> Operator, Curr Range'
              if item_collection1.curr.right_item.is_a?(Number)
                item_collection1.curr.right_item.inc
              end
            elsif item.prev_item.is_a?(Number)
              item_collection1.push(Range.new(item.symbole))
              item_collection1.curr.left_item = item.prev_item
              item_collection1.curr.right_item = item.prev_item
              item_collection1.curr.right_item.inc
            elsif item.prev_item.is_a?(Operator)
              puts '--> Operator, Prev Operator'
              if item_collection1.curr.is_a?(Range)
                if item_collection1.curr.right_item.is_a?(Number)
                  item_collection1.curr.right_item.inc
                end
              end
            else
              puts '--> Operator ELSE: %s' % [item.prev_item.inspect]
            end
          else
            item_collection1.push(item)
          end # case item
        end # scopes.last.items.each

        puts
        puts '-> Lexer2.resolve L3 Items'
        pp item_collection1.items.map{ |item| item.inspect }

        puts
        puts '-> Lexer2.resolve L4 [convert to int]'
        items2 = []
        item_collection1.items.each do |item|
          items2.push(item.resolve)
        end
        items2
      end
    end
  end # Scope
end # Lexer
end # Range
end # TheFox
