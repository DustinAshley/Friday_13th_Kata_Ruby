class Day_iterator

  def initialize
    @end_year = 2016
    @year = 1973
    @day = 1
    @first_day_of_month = 1
    @month = 1
    @months = %w( January
                  February
                  March
                  April
                  May
                  June
                  July
                  August
                  September
                  October
                  November
                  December )

    @days = %w( Monday
                Tuesday
                Wednesday
                Thursday
                Friday
                Saturday
                Sunday )

    @days_in_month = {
        'January' => 31,
        'February' => 28,
        'FebruaryLeap' => 29,
        'March' => 31,
        'April' => 30,
        'May' => 31,
        'June' => 30,
        'July' => 31,
        'August' => 31,
        'September' => 30,
        'October' => 31,
        'November' => 30,
        'December' => 30
    }

    @day_counter = {
        'Monday' => 0,
        'Tuesday' => 0,
        'Wednesday' => 0,
        'Thursday' => 0,
        'Friday' => 0,
        'Saturday' => 0,
        'Sunday' => 0
    }
  end

  def convert_month_to_string(month_number)
    @months[month_number-1]
  end

  def convert_day_to_string(day_number)
    @days[day_number-1]
  end

  def get_current_day
    @day
  end

  def get_counts
    @day_counter
  end

  # returns 1 => Mon; 2 => Tues; etc..
  def find_day_of_month(day=@day, first_day_of_month=@first_day_of_month)
    day = ((day - 1) + first_day_of_month) % 7
    return 7 if day == 0
    day
  end

  def find_last_day_of_month(month=@month, first_day_of_month=@first_day_of_month, is_leap_year=@is_leap_year)
    month_string = convert_month_to_string(month)
    month_string = 'FebruaryLeap' if is_leap_year && month == 2
    last_day_val = @days_in_month.fetch(month_string)
    find_day_of_month(last_day_val, first_day_of_month)
  end

  def iterate_through_month(first_day_of_month=@first_day_of_month)
      @day_counter[(convert_day_to_string(find_day_of_month(13, first_day_of_month)))] += 1
  end

  def iterate_though_year(year=@year)
    @is_leap_year = determine_leap_year
    while (@month <= 12)
        iterate_through_month
        @last_day_of_month = find_last_day_of_month
        @first_day_of_month = goto_next_day
        goto_next_month
        break if @month == 1
    end
    @first_day_of_month = goto_next_day(@last_day_of_month) + 1
  end

  def iterate_through_timeline(year=@year,end_year=@end_year)
    puts "Iterating years #{year} - #{end_year}"
    while (year <= end_year)
      iterate_though_year
      @year = year + 1
      year = @year
    end
  end

  def determine_leap_year(year=@year)
    return true if year % 400 == 0
    return false if year % 100 == 0
    return true if year % 4 == 0
    false
  end

  def goto_next_month
    @month = (@month % 12) + 1
  end

  def goto_next_day(day=@day)
    @day = (@last_day_of_month + 1 % 7)
  end

  def display_counts
    (1..7).each do |i|
      convert_day_to_string(i)
    end
    return @day_counter
  end

end