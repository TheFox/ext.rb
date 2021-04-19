
module TheFox
module Range
module Lexer2
  class Scope
    def initialize(items = nil, level = 0)
      @items = items.nil? ? [] : items
      @level = level
      @curr_item = nil
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

    def add_item(item)
      @items.push(item)
      if !@curr_item.nil?
        item.chain(@curr_item)
      end
      @curr_item = item
    end

    def items()
      @items
    end

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
          scopes.last.add_item(item.dup)
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
        puts '--> resolve items'
        items1 = []
        scopes.last.items.each do |item|
          puts '--> sub Item: %s' % [item.inspect]
          case item
          when Range
          end
        end
        items1
      end
    end
  end # Scope
end # Lexer
end # Range
end # TheFox
