
class Array

  # Resolve a range string to an array.
  # A range string can be like '1, 3..5, 9-11, 12+, 14++, 17+++, 1{98,99}'.
  # Which will be resolved to [1, 3, 4, 5, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 198, 199].
  def self.resolve_range_str(original_str, prefix = '')
    rv = Array.new
    if !original_str.is_a?(String)
      return rv
    end

    original_str.split(',').map{ |item|
      item_striped = item.strip
      if /\.\./.match(item_striped) # ( . )( . ) <--- BOOBS
        Range.new(*item_striped.split('..', 2).map{ |range| range.to_i })
      elsif /-/.match(item_striped)
        Range.new(*item_striped.split('-', 2).map{ |range| range.to_i })
      elsif /\+/.match(item_striped)
        items = item_striped.split('+')
        range_begin = items[0].to_i
        range_end = range_begin + item_striped.count('+')
        Range.new(range_begin, range_end)
      # elsif /\{/.match(item_striped) && /\}/.match(item_striped)
      #   range_match = item_striped.match(/(\d+)\{([\d,]+)\}/)
      #   pp range_match
      #   subranges = resolve_range_str(range_match[1])
      #   pp subranges
      #   []
      else
        item_striped.to_i
      end
    }.each do |range|
      if range.is_a?(Range)
        # pp range.to_a.map{ |i| (prefix + i).to_i }
        rv.push(*range.to_a)
      else
        # pp range
        rv << range
      end
    end

    rv
  end

end
