require "test_helper"

class NonSensorTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Nonsensor::VERSION
  end
end
