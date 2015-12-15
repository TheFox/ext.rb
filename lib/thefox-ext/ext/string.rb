
class String
	def is_utf8?
		begin
			self.unpack('U*')
		rescue
			return false
		end
		return true
	end
	
	def titlecase
		self
			.split(/ /)
			.map{ |word| word.capitalize }
			.join(' ')
	end
	
	def to_utf8
		if is_utf8?
			self.force_encoding('UTF-8')
		else
			self.force_encoding('ISO-8859-1').encode('UTF-8')
		end
	end
end
