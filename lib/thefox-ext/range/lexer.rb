
require 'pp'

module TheFox
module Range
module Lexer
  class Lexer
    def initialize(chars)
      puts '-> TheFox::Range::Lexer::Lexer.initialize'
      @chars = chars
    end

    def resolve()
      puts '-> TheFox::Range::Lexer::Lexer.resolve'
      @chars.each do |char|
        puts '-> char: "%s"' % [char]
      end

      pp @chars.map{ |char|
        case char
        when ','
          Lexer::Separator.new
        end
      }

      [123]
    end
  end # Lexer
end # Lexer
end # Range
end # TheFox
