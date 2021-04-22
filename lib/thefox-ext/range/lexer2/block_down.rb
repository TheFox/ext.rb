
module TheFox
module Range
module Lexer2
  # {
  class BlockDown < Block
    def initialize(level)
      level.inc
      super(level)
      # puts '-> BlockDown.initialize(%s)' % [level.inspect]
    end

    # :nocov:
    def inspect()
      'BlockDown(%s)' % [@level.level]
      # if @prev_item.nil?
      # else
      #   'BlockDown(%s <%s)' % [@level.inspect, @prev_item.inspect]
      # end
    end
    # :nocov:
  end # BlockDown
end # Lexer
end # Range
end # TheFox
