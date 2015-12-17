
class Console
	
	CHAR_ESCAPE = "\x1b"
	
	def self.cursor_up(rows = 1)
		print "#{CHAR_ESCAPE}[#{rows}A"
	end
	
	def self.cursor_down(rows = 1)
		print "#{CHAR_ESCAPE}[#{rows}B"
	end
	
	def self.cursor_jump_to_top
		print "#{CHAR_ESCAPE}[1;1f"
	end
	
	def self.cursor_jump_to_column(col = 1)
		print "#{CHAR_ESCAPE}[#{col}G"
	end
	
	def self.cursor_right(offset = 1)
		print "#{CHAR_ESCAPE}[#{offset}C"
	end
	
	def self.cursor_left(offset = 1)
		print "#{CHAR_ESCAPE}[#{offset}D"
	end
	
	def self.line_clear
		print "\r#{CHAR_ESCAPE}[K"
	end
	
	def self.line_clear_right
		print "#{CHAR_ESCAPE}[0K"
	end
	
	def self.screen_clear_to_bottom
		print "#{CHAR_ESCAPE}[J"
	end
	
	def self.scroll_up
		print "#{CHAR_ESCAPE}[S"
	end
	
	def self.scroll_down
		print "#{CHAR_ESCAPE}[T"
	end
	
end
