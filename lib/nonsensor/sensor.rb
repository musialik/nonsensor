class Nonsensor::Sensor
  include Nonsensor::Series

  def initialize(generators = {})
    @generators = generators
  end

  def next!
    Hash[@generators.map { |key, gen| [key, gen.next!] }]
  end
end
