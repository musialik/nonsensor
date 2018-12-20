module Nonsensor::Series
  def next!
    raise '#next! must be implemented for Nonsensor::Series'
  end

  def to_enum
    Enumerator.new do |yielder|
      loop do
        yielder << self.next!
      end
    end.lazy
  end

  def take(*args)
    to_enum.take(*args)
  end

  def take!(*args)
    take(*args).force
  end
end
