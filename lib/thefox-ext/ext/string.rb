
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

  # Resolve a range string to an array.
  # A range string can be like '1, 3..5, 9-11, 12+, 14++, 17+++'.
  # Which will be resolved to [1, 3, 4, 5, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20].
  def resolve_range(prefix = '')
    # puts '-> resolve_range: %s {%s}' % [self, prefix]

    rv = Array.new

    items1 = self.split(',')
    # pp items1

    items2 = []
    is_sub_range = false
    sub_item = []
    items1.each do |item|
      if item.count('{') > 0
        is_sub_range = true
      end
      if is_sub_range
        sub_item.push(item)
      else
        items2.push(item)
      end
      if item.count('}') > 0
        is_sub_range = false
        items2.push(sub_item.join(','))
        sub_item = []
      end
    end

    # pp items2

    items2.map{ |item|
      item_striped = item.strip
      if range_match = item_striped.match(/(\d+)\{([\d\-\+,]+)\}/)
        # puts '-> subrange'
        # pp range_match
        # subranges = range_match[2].resolve_range(range_match[1])
        # # puts "subranges: #{subranges}"
        # subranges
        range_match[2].resolve_range(range_match[1])
      elsif /\.\./.match(item_striped) # ( . )( . ) <--- BOOBS
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
      elsif range.is_a?(Array)
        rv.push(*range)
      else
        # pp range
        rv << range
      end
    }

    if !prefix.empty?
      rv = rv.map { |i|
        # puts '-> map: prefix="%s" i="%d"' % [prefix, i]
        (prefix + i.to_s).to_i
      }
    end

    rv
  end
end
