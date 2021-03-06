
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
end
