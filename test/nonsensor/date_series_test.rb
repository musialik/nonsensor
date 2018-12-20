require "test_helper"

class Nonsensor::DateSeriesTest < Minitest::Test
  def test_returns_sequential_dates
    dates = Nonsensor::DateSeries.new.take!(2)

    assert_equal dates.last, dates.first + 1
    dates.each do |date|
      assert_instance_of Date, date
    end
  end

  def test_accepts_start_and_step_arguments
    dates = Nonsensor::DateSeries.new(start: Date.new(2018, 1, 1), step: 3).take!(5)

    assert_equal Date.new(2018, 1, 1), dates[0]
    assert_equal Date.new(2018, 1, 4), dates[1]
    assert_equal Date.new(2018, 1, 7), dates[2]
    assert_equal Date.new(2018, 1, 10), dates[3]
    assert_equal Date.new(2018, 1, 13), dates[4]
  end
end
