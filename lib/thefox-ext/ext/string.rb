
class String

  # Is a String only made of numbers?
  def is_digit?
    r = '0'..'9'
    self.split('').keep_if{ |c| r.include?(c) }.count == self.length
  end

  # Is a String only made of lower-case charaters.
  def is_lower?
    r = 'a'..'z'
    self.split('').keep_if{ |c| r.include?(c) }.count == self.length
  end

  # Is a String only made of upper-case charaters.
  def is_upper?
    r = 'A'..'Z'
    self.split('').keep_if{ |c| r.include?(c) }.count == self.length
  end

  def is_utf8?
    begin
      self.unpack('U*')
    rescue
      return false
    end
    return true
  end

  # Convert 'hello world' to 'Hello World'.
  def titlecase
    self
      .split(/ /)
      .map{ |word| word.capitalize }
      .join(' ')
  end

  def to_hex
    self.split('').map{ |c| sprintf '%02x', c.ord }.join
  end

  # Convert a String to an Integer 32-bit Array.
  def to_i32a
    len = self.length
    len_w = (len >> 2) + (len & 0x3).to_b.to_i

    out = (0..(len_w - 1)).map{ |n| [n, 0] }.to_h

    i = 0
    self.split('').each do |s|
      out[i >> 2] |= (s.ord << ((3 - (i & 0x3)) << 3))
      i += 1
    end

    out
  end

  def to_utf8
    if is_utf8?
      self.force_encoding('UTF-8')
    else
      self.force_encoding('ISO-8859-1').encode('UTF-8')
    end
  end

  # DEPRECATED: will be removed in v2.0.0.
  def resolve_range(prefix = '')
    # puts '-> resolve_range: %s {%s}' % [self, prefix]
    warn "[DEPRECATION] `String.resolve_range` is deprecated. Please use `TheFox::Range::Resolver` instead."

    rv = Array.new

    items = []
    is_sub_range = false
    sub_item = []
    self.split(',').each do |item|
      if item.count('{') > 0
        is_sub_range = true
      end
      if is_sub_range
        sub_item.push(item)
      else
        items.push(item)
      end
      if item.count('}') > 0
        is_sub_range = false
        items.push(sub_item.join(','))
        sub_item = []
      end
    end

    items.map{ |item|
      item_striped = item.strip
      if range_match = item_striped.match(/(\d+)\{([\d\-\+,]+)\}/)
        range_match[2].resolve_range(range_match[1])
      elsif /\.\./.match(item_striped) # ( . )( . ) <--- BOOBS
        Range.new(*item_striped.split('..', 2).map{ |range| range.to_i })
      elsif /-/.match(item_striped)
        Range.new(*item_striped.split('-', 2).map{ |range| range.to_i })
      elsif /\+/.match(item_striped)
        range_begin = item_striped.split('+').first.to_i
        range_end = range_begin + item_striped.count('+')
        Range.new(range_begin, range_end)
      else
        item_striped.to_i
      end
    }.each{ |range|
      if range.is_a?(Range)
        rv.push(*range.to_a)
      elsif range.is_a?(Array)
        rv.push(*range)
      else
        rv << range
      end
    }

    if !prefix.empty?
      rv = rv.map { |i|
        (prefix + i.to_s).to_i
      }
    end

    rv
  end
end
