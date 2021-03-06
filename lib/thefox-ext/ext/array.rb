
class Array

  # Resolve a range string to an array.
  # A range string can be like '1, 3..5, 9-11'.
  # Which will be resolved to [1, 3, 4, 5, 9, 10, 11].
  def self.resolve_range_str(s)
    a = Array.new
    if !s.is_a?(String)
      return a
    end

    s.split(',').map{ |i|
      ts = i.strip
      if /\.\./.match(ts) # ( . )( . ) <--- BOOBS
        b, e = ts.split('..', 2).map{ |r| r.to_i }
        Range.new(b, e)
      elsif /-/.match(ts)
        b, e = ts.split('-', 2).map{ |r| r.to_i }
        Range.new(b, e)
      else
        ts.to_i
      end
    }.each do |r|
      if r.is_a?(Range)
        a.push(*r.to_a)
      else
        a << r
      end
    end
    a
  end

end
