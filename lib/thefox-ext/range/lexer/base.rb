
module TheFox
module Range
module Lexer
  class Base
    def initialize()
      # puts '-> TheFox::Range::Lexer::Base.initialize'
      @prev_item = nil
      @next_item = nil
      @parent_item = nil

      # @pre_resolvers = [lambda{'pre'}]
      # @resolvers = [lambda{'res'}]
      @pre_resolvers = []
      @resolvers = []
      @is_resolved = false
    end

    def prev_item=(prev_item)
      @prev_item = prev_item
    end
    def next_item=(next_item)
      @next_item = next_item
    end

    def parent_item=(parent_item)
      @parent_item = parent_item
    end

    def clear_pre_resolvers()
      puts '-> Base.clear_pre_resolvers %s' % [self.inspect]
      @pre_resolvers = []
      if !@prev_item.nil?
        @prev_item.clear_pre_resolvers
      end
    end

    def append_pre_resolvers(resolvers)
      @pre_resolvers.push(*resolvers)
    end

    def pre_resolvers()
      @pre_resolvers
    end

    def clear_resolvers()
      @resolvers = []
    end

    def resolvers=(resolvers)
      @resolvers = resolvers
    end

    def resolvers()
      @resolvers
    end

    def is_resolved()
      @is_resolved
    end

    def resolve()
      # puts '-> Base.resolve'
      # resolved = []
      # resolved.push(*@pre_resolvers.map{ |resolver| resolver.call })
      # resolved.push(*@resolvers.map{ |resolver| resolver.call })
      # resolved = @resolvers.map{ |resolver| resolver.call }
      # @resolvers = []
      # resolved
      @is_resolved = true
    end

    def dup()
      puts '-> Base.dup'
      @prev_item = nil
      @next_item = nil
      @parent_item = nil
      super()
    end
  end # Base
end # Lexer
end # Range
end # TheFox
