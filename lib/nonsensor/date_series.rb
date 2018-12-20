require "date"

class Nonsensor::DateSeries
  include Nonsensor::Series

  def initialize(start: Date.today, step: 1)
    @date = start
    @step = step
  end

  def next!
    date = @date
    @date += @step
    date
  end
end
