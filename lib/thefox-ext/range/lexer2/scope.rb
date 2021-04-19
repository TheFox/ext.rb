
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
          scopes.last.add_item(item)
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
        puts '--> resolve items'
        item_collection1 = Collection.new
        scopes.last.items.each do |item|
          puts '--> sub Item: %s' % [item.inspect]

          case item
          when Range
            if item.prev_item.is_a?(Number) && item.next_item.is_a?(Number)
              puts '--> Range normal'
            else
              raise 'Invalid Range: %s %s' % [
                item.prev_item.inspect,
                item.next_item.inspect,
              ]
            end
          end # case item
        end # scopes.last.items.each

        # puts '-> Lexer2.resolve L3 Items'
        # pp item_collection1.items.map{ |item| item.inspect }

        nil
      end
    end
  end # Scope
end # Lexer
end # Range
end # TheFox
