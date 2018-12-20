require "test_helper"

class Nonsensor::MidpointDisplacementTest < Minitest::Test
  def test_first_and_last_values_are_set
    [1, 2, 3, 5, 7, 9, 10, 10.0, 11, 100, 1000].each do |batch_size|
      gen = Nonsensor::MidpointDisplacement.new(start: batch_size, batch_size: batch_size)
      values = gen.take!(batch_size)

      assert_equal batch_size, values.first
      assert_equal batch_size, values.last
    end
  end

  def test_it_returns_numbers
    gen = Nonsensor::MidpointDisplacement.new(batch_size: 100)
    values = gen.take!(100)

    values.each do |value|
      assert_kind_of Numeric, value
    end
  end

  def test_it_makes_more_batches
    gen = Nonsensor::MidpointDisplacement.new(batch_size: 10)
    values = gen.take!(50)

    assert true
  end
end
