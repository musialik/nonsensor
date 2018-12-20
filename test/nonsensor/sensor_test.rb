require "test_helper"

class Nonsensor::SensorTest < Minitest::Test
  def test_combines_multiple_series
    sensor = Nonsensor::Sensor.new({
      date: Nonsensor::DateSeries.new(start: Date.new(2018, 10, 10)),
      temp: Nonsensor::MidpointDisplacement.new(start: 10)
    })

    measurement = sensor.next!

    assert_equal Date.new(2018, 10, 10), measurement[:date]
    assert_equal 10, measurement[:temp]
  end
end
