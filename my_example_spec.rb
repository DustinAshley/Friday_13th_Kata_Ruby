require 'rspec'
require_relative 'Day_iterator'

describe Day_iterator do

  before :each do
    @day_iterator = Day_iterator.new
  end

  it 'should convert the month value of 1 to January' do
    expect(@day_iterator.convert_month_to_string(1)).to eql('January')
  end

  it 'should convert the month value of 2 to February' do
    expect(@day_iterator.convert_month_to_string(2)).to eql('February')
  end

  it 'should convert the month value of 12 to December' do
    expect(@day_iterator.convert_month_to_string(12)).to eql('December')
  end

  it 'should covert the day key of 1 to Monday' do
    expect(@day_iterator.convert_day_to_string(1)).to eql('Monday')
  end

  it 'should covert the day key of 2 to Tuesday' do
    expect(@day_iterator.convert_day_to_string(2)).to eql('Tuesday')
  end

  it 'should covert the day key of 1 to Sunday' do
    expect(@day_iterator.convert_day_to_string(7)).to eql('Sunday')
  end

  it 'should by default return Monday as the current day' do
    day = @day_iterator.get_current_day
    expect(@day_iterator.convert_day_to_string(day)).to eql('Monday')
  end

  it 'should return Tuesday if the first day of the month is a Monday and we are looking for the 2nd day' do
    expect(@day_iterator.find_day_of_month(2, 1)).to be(2)
  end

  it 'should return Monday if the first day of the month is a Monday and we are looking for the 8th day' do
    expect(@day_iterator.find_day_of_month(8, 1)).to be(1)
  end

  it 'should return Sunday if the first day of the month is a Monday and we are looking for the 14th day' do
    expect(@day_iterator.find_day_of_month(14, 1)).to be(7)
  end

  it 'should return Monday if the first day of the month is a Monday and we are looking for the 15th day' do
    expect(@day_iterator.find_day_of_month(15, 1)).to be(1)
  end

  it 'should return Tuesday if the first day of the month is a Monday and we are looking for the 16th day' do
    expect(@day_iterator.find_day_of_month(16, 1)).to be(2)
  end

  it 'should return Wednesday if the first day of the month is a Tuesday and we are looking for the 2nd day' do
    expect(@day_iterator.find_day_of_month(2, 2)).to be(3)
  end

  it 'should return Tuesday if the first day of the month is a Tuesday and we are looking for the 8th day' do
    expect(@day_iterator.find_day_of_month(8, 2)).to be(2)
  end

  it 'should return Monday if the first day of the month is a Tuesday and we are looking for the 14th day' do
    expect(@day_iterator.find_day_of_month(14, 2)).to be(1)
  end

  it 'should return Tuesday if the first day of the month is a Tuesday and we are looking for the 15th day' do
    expect(@day_iterator.find_day_of_month(15, 2)).to be(2)
  end

  it 'should return Wednesday if the first day of the month is a Tuesday and we are looking for the 16th day' do
    expect(@day_iterator.find_day_of_month(16, 2)).to be(3)
  end

  it 'should return Saturday if the first day of the month is a Friday and we are looking for the 30th day' do
    expect(@day_iterator.find_day_of_month(30, 5)).to be(6)
  end

  it 'should iterate through the first month and show Saturday with a count of 1' do
    @day_iterator.iterate_through_month
    counts = @day_iterator.get_counts
    expect(counts.fetch('Saturday')).to be(1)
  end

  it 'should by default (1973, Jan) return Wednesday as the last day of the month' do
    expect(@day_iterator.find_last_day_of_month).to be(3)
  end

  it 'should return Saturday as the last day of the January if the first day of the month is Friday' do
    expect(@day_iterator.find_last_day_of_month(1, 5)).to be(7)
  end

  it 'should return Saturday as the last day of the February if the first day of the month is Sunday' do
    expect(@day_iterator.find_last_day_of_month(2, 7)).to be(6)
  end

  it 'should return Sunday as the last day of the February if the first day of the month is Sunday on a Leap Year' do
    expect(@day_iterator.find_last_day_of_month(2, 7, true)).to be(7)
  end

  it 'should return Sunday as the last day of the March if the first day of the month is Friday' do
    expect(@day_iterator.find_last_day_of_month(3, 5)).to be(7)
  end

  it 'should return Wednesday as the last day of the month if the first day of the month is a Monday' do
    expect(@day_iterator.find_last_day_of_month(1, 1)).to be(3)
  end

  it 'should evaluate 1993 to false in terms of leap year' do
    expect(@day_iterator.determine_leap_year(1993)).to be(false)
  end

  it 'should evaluate 1996 to true in terms of leap year' do
    expect(@day_iterator.determine_leap_year(1996)).to be(true)
  end

  it 'should evaluate 2000 to true in terms of leap year' do
    expect(@day_iterator.determine_leap_year(2000)).to be(true)
  end

  it 'should evaluate 1900 to true in terms of leap year' do
    expect(@day_iterator.determine_leap_year(1900)).to be(false)
  end

  it 'should return correct day counter for 1973' do
    @day_iterator.iterate_through_timeline(1973, 1973)
    counts = @day_iterator.get_counts
    expect(counts.eql?({"Monday"=>1, "Tuesday"=>3, "Wednesday"=>1, "Thursday"=>2, "Friday"=>2, "Saturday"=>2, "Sunday"=>1})).to be(true)
  end

  it 'should return correct day counter for 1973 - 1974' do
    @day_iterator.iterate_through_timeline(1973, 1974)
    counts = @day_iterator.get_counts
    expect(counts.eql?({"Monday"=>2, "Tuesday"=>4, "Wednesday"=>4, "Thursday"=>3, "Friday"=>4, "Saturday"=>4, "Sunday"=>3})).to be(true)
  end

  it 'should return correct day counter for 1973 - 2003' do
    @day_iterator.iterate_through_timeline(1973, 2003)
    counts = @day_iterator.get_counts
    expect(counts.eql?({"Monday"=>52, "Tuesday"=>53, "Wednesday"=>53, "Thursday"=>54, "Friday"=>53, "Saturday"=>54, "Sunday"=>53})).to be(true)
  end

  it 'should have mostly fridays' do
    @day_iterator.iterate_through_timeline(1973, 4000)
    day_counters = @day_iterator.get_counts
    max = 0
    day_counters.each do |kvp|
      max = kvp[1] if kvp[1] > max
    end
    puts "Fridays the 13th's counted: #{day_counters['Friday']}"
    expect(day_counters['Friday']).to eql(max), "The most 13's are not Friday."
  end

end