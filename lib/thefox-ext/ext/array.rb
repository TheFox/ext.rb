
class Array

  # DEPRECATED: will be removed in v1.10.0.
  def self.resolve_range_str(original_str, prefix = '')
    warn "[DEPRECATION] `Array.resolve_range_str` is deprecated. Please use `String.resolve_range` instead."

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
      else
        item_striped.to_i
      end
    }.each{ |range|
      if range.is_a?(Range)
        rv.push(*range.to_a)
      else
        rv << range
      end
    }

    rv
  end

end
