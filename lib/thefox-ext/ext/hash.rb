
class Hash
	
	def merge_recursive(h2, level = 0, clone = true)
		has_subhashes = false
		
		h1 = self
		if clone
			# We want to modify only the clone.
			h1 = self.clone
		end
		
		# Iterate Hash 1
		h1.each do |k, v|
			if v.is_a?(Hash)
				has_subhashes = true
				
				if h2.has_key?(k) && h2[k].is_a?(Hash)
					# Inception! Go one level deeper.
					h1[k] = v.merge_recursive(h2[k], level + 1)
				else
					h1[k] = h2[k]
				end
			else
				# Value of Hash 1 is no Subhash.
				
				# Only overwrite Hash 1 Value with Hash 2 Value
				# if a Hash 2 Key exist.
				if h2.has_key?(k)
					h1[k] = h2[k]
				end
			end
		end
		
		# Iterate Hash 2
		# Because we also want Key from Hash 2
		# which don't exist in Hash 1.
		h2.each do |k, v|
			if !h1.has_key?(k)
				h1[k] = v
			end
		end
		
		if !has_subhashes
			# If there are no subhashes merge
			# with existing merge function.
			h1.merge!(h2)
		end
		
		# Return h1 modified clone.
		return h1
	end
	
	def merge_recursive!(h2)
		self.merge_recursive(h2, 0, false)
	end
	
end
