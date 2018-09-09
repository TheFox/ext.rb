
require 'date'

class Date
  def today?
    self == Date.today
  end

  # Get all days (as Date objects) for the current week.
  def week
    cweek = self.cweek
    year = self.year
    month = self.month

    next_year = year + 1
    previous_year = year - 1

    days = Date.new(year)
      .step(Date.new(year, -1, -1))
      .select{ |d| d.cweek == cweek }

    if cweek == 1 && month == 12 ||
      cweek == 1 && month == 1 ||
      cweek >= 52 && month == 12 ||
      cweek >= 52 && month == 1

      days.keep_if{ |d| d.year == year && d.month == month }
    end

    if days.count < 7
      rest = 7 - days.count

      rest_days = nil
      if month == 1
        rest_days = Date.new(previous_year, 12, 31 - rest + 1).step(Date.new(previous_year, 12, 31))
      elsif month == 12
        rest_days = Date.new(next_year).step(Date.new(next_year, 1, rest))
      end

      if !rest_days.nil?
        days += rest_days.to_a
      end
    end

    days.sort[0, 7]
  end
end
