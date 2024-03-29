
module TheFox
module Range
module Lexer
  class Base
    @@instance_id = 0

    def initialize(symbole = nil)
      # puts '-> Base.initialize'

      @@instance_id += 1
      @instance_id = @@instance_id
      @nonce = Base.generate_nonce()
      @symbole = symbole
      @prev_item = nil
      @org_prev_item = nil
      @next_item = nil

      @parent_item = nil
      #@parent_scope = nil
      @children = []
    end

    # :nocov:
    def inspect()
      'Base'
    end
    # :nocov:

    def instance_id()
      @instance_id
    end
    def instance_id=(instance_id)
      @instance_id = instance_id
    end

    def nonce()
      @nonce
    end
    def nonce=(nonce)
      @nonce = nonce
    end

    def chain(prev_item)
      # puts '%s(%s).chain' % [self.inspect, opts.inspect]
      self.prev_item = prev_item
      if !prev_item.nil?
        prev_item.next_item = self
      end
    end

    def symbole()
      @symbole
    end

    def org_prev_item()
      @org_prev_item
    end
    def org_prev_item=(org_prev_item)
      @org_prev_item = org_prev_item
    end

    def prev_item()
      @prev_item
    end
    def prev_item=(prev_item)
      @prev_item = prev_item
    end

    def next_item()
      @next_item
    end
    def next_item=(next_item)
      @next_item = next_item
    end

    def parent_item()
      @parent_item
    end
    def parent_item=(parent_item)
      @parent_item = parent_item
    end
    def has_parent_item()
      !@parent_item.nil?
    end

    def children()
      @children
    end
    def add_child(child)
      @children.push(child)
    end
    def has_children()
      @children.length > 0
    end

    def dup()
      # puts '-> Base.dup'
      o = super()
      o.nonce = Base.generate_nonce()
      o.prev_item = nil
      o.next_item = nil
      o
    end

    def resolve()
      puts '-> Base.resolve'
    end

    class << self
      def generate_nonce()
        rand(10 ** 3).to_s.rjust(3, '0')
      end
      def keep_nonce_on_dup()
        false
      end
      def keep_instance_id_on_dup()
        false
      end
    end
  end # Base
end # Lexer
end # Range
end # TheFox
