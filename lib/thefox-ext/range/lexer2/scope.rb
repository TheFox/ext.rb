
require 'colorize'

module TheFox
module Range
module Lexer2
  class Scope < Base
    def initialize(items = nil, parent_scope = nil, level = 0)
      super()
      # @nonce = rand(10 ** 3).to_s.rjust(3, '0')
      @item_collection = Collection.new(items)
      @parent_scope = parent_scope
      @level = level
      @ref_item = nil

      puts '%s-> Scope(#%s).initialize(p=%s l=%d)'.colorize(:red) % [' ' * (@level * 2), @nonce, @parent_scope.inspect, @level]
    end

    # :nocov:
    def inspect()
      'Scope(#%s PS=%s RI=%s)' % [@nonce, @parent_scope.inspect, @ref_item.inspect]
    end
    # def dup()
    #   puts '-> dup: %s' % [inspect]
    #   exit(1)
    #   super
    # end
    # :nocov:

    def push(item)
      puts '%s-> %s.push(%s) -> PS=%s PRI=%s'.colorize(:green) % [' ' * (@level * 2),
        inspect,
        item.inspect,
        @parent_scope.inspect,
        @parent_scope.ref_item.inspect,
      ]
      # item.parent_item = @parent_item
      # item.parent_item = @ref_item
      @item_collection.push(item)
    end

    def items()
      @item_collection.items
    end

    def curr()
      @item_collection.curr
    end

    def parent_item=(parent_item)
      # super(parent_item)
      # puts '%s--> Set Parent: %s'.colorize(:green) % [' ' * (@level * 2), @parent_item.inspect]
      exit(1)
    end

    def parent_scope()
      @parent_scope
    end
    def parent_scope=(parent_scope)
      @parent_scope = parent_scope
    end

    def ref_item()
      @ref_item
    end
    def ref_item=(ref_item)
      @ref_item = ref_item
    end

    def resolve()
      # puts '-> %s.resolve(%d)' % [self.inspect, @level]

      puts '%s-> SL1: %s P=%s' % [' ' * (@level * 2), inspect, @parent_item.inspect]

      scopes = Collection.new([Scope.new(nil, self, @level + 1)])
      block_stack = Collection.new()
      parent_item = nil
      @item_collection.items.each do |item|
        puts '%s-> Item: %s' % [' ' * (@level * 2), item.inspect]

        push_to_scope = false

        case item
        when Separator
          if block_stack.length == 0
            # puts '%s-> next scope, Separator' % [' ' * (@level * 2)]
            scopes.push(Scope.new(nil, self, @level + 1))
          else
            # puts '%s-> curr scope, Separator' % [' ' * (@level * 2)]
            push_to_scope = true
          end
        when BlockDown
          # puts '%s-> BlockDown' % [' ' * (@level * 2)]
          if block_stack.length == 0
            scopes.push(Scope.new(nil, self, @level + 1))
            scopes.curr.ref_item = item.prev_item
            # parent_item = item.prev_item
            puts '%s--> Block Down: PI=%s RI=%s'.colorize(:green) % [' ' * (@level * 2),
              scopes.curr.parent_item.inspect,
              scopes.curr.ref_item.inspect,
            ]
          else
            push_to_scope = true
          end

          # Block Stack
          block_stack.push(item)
        when BlockUp
          # puts '%s-> BlockUp' % [' ' * (@level * 2)]

          # Block Stack
          block_stack.pop
        else
          push_to_scope = true
        end # case item

        if push_to_scope
          puts '%s--> Push Item: %s PS=%s PI=%s RI=%s,%s' % [' ' * (@level * 2),
            item.inspect,
            scopes.curr.parent_scope.inspect,
            scopes.curr.parent_item.inspect,
            @ref_item.inspect,
            scopes.curr.ref_item.inspect,
          ]
          scopes.curr.push(item)
          puts '%s--> Pushed Item: %s' % [' ' * (@level * 2),
            item.inspect,
          ]

          # Block Stack
          if !block_stack.curr.nil?
            # puts '%s--> Set Parent: %s'.colorize(:green) % [
            #   ' ' * (@level * 2),
            #   parent_item.inspect,
            # ]

            # scopes               Collection
            # scopes.curr          Scope
            # scopes.curr.curr     Scope.@item_collection.curr

            # scopes.curr.curr.parent_item = block_stack.curr.org_prev_item
            # scopes.curr.curr.parent_item.add_child(item)
          end
        end
      end # @item_collection.items

      # puts
      # puts '%s-> Scopes: %s'.colorize(:blue) % [' ' * (@level * 2), scopes.inspect]
      # scopes.items.each do |scope|
      #   puts scope.inspect.colorize(:blue)
      #   puts scope.items.map{ |i| i.inspect }.to_s.colorize(:blue)
      # end

      if scopes.length > 1
        # puts '--> resolve sub scopes'
        resolved = []
        scopes.items.each do |scope|
          # puts '--> Resolve Scope: %s' % [scope.inspect]
          resolved.push(scope.resolve)
        end
        resolved
      else
        # puts
        # puts '%s-> SL1 Items' % [' ' * (@level * 2)]
        # pp scopes.curr.items.map{ |item| item.inspect }

        puts '%s-> SL2 ' % [' ' * (@level * 2)]
        item_collection1 = Collection.new
        scopes.curr.items.each do |item|
          puts '%s-> %s Item: %s (P=%s)' % [
            ' ' * (@level * 2),
            scopes.curr.inspect,
            item.inspect,
            item.parent_item.inspect,
          ]

          case item
          when Number
            # puts '--> Its %s' % [item.inspect]
            if item.next_item.is_a?(Range) || item.prev_item.is_a?(Range)
              # Skip Range
              # puts '--> Skip Range'
            elsif item.prev_item.is_a?(Interval)
              # Skip Interval
              # puts '--> Skip Interval'
            elsif item.next_item.is_a?(Operator)
              # Skip Operator
              # puts '--> Skip Interval'
            elsif item.has_children
              # Skip
              # puts '--> Skip Has Children'
            else
              # puts '--> Push'
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
              # puts '%s-> Operator, Curr Range' % [' ' * (@level * 2)]
              if item_collection1.curr.right_item.is_a?(Number)
                item_collection1.curr.right_item.inc
              end
            elsif item.prev_item.is_a?(Number)
              item_collection1.push(Range.new(item.symbole))
              item_collection1.curr.left_item = item.prev_item
              item_collection1.curr.right_item = item.prev_item
              item_collection1.curr.right_item.inc
            elsif item.prev_item.is_a?(Operator)
              # puts '%s-> Operator, Prev Operator' % [' ' * (@level * 2)]
              if item_collection1.curr.is_a?(Range)
                if item_collection1.curr.right_item.is_a?(Number)
                  item_collection1.curr.right_item.inc
                end
              end
            # else
            #   puts '%s-> Operator ELSE: %s' % [' ' * (@level * 2), item.prev_item.inspect]
            end
          else
            item_collection1.push(item)
          end # case item
        end # scopes.curr.items.each

        # puts '%s-> L3 Items' % [' ' * (@level * 2)]
        # pp item_collection1.items.map{ |item| item.inspect }

        puts '%s-> L4 [convert to int]'.colorize(:blue) % [' ' * (@level * 2)]
        items2 = []
        item_collection1.items.each do |item|
          items2.push(item.resolve)
        end
        items2
      end
    end

    class << self
      def keep_nonce_on_dup()
        true
      end
    end
  end # Scope
end # Lexer
end # Range
end # TheFox
