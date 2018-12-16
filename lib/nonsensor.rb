require_relative "nonsensor/version"

module Nonsensor
  class MidpointDisplacement
    attr_reader :start, :batch, :batch_size

    def initialize(start: 0.0, displacement: 50.0, decay_power: 1, batch_size: 100)
      @start = start
      @initial_displacement = displacement
      @decay = (1.0 / 2 ** decay_power)
      @batch_size = batch_size.to_i

      @batch = []
    end

    def next
      make_batch if @batch.empty?
      @batch.shift
    end

    def take(num)
      ary = []

      while num > 0
        num -= 1
        ary << self.next
      end

      ary
    end

    private

    def make_batch
      @batch = Array.new(@batch_size, start)
      @iteration = 1
      @current_iteration = []
      @next_iteration = []
      @displacement = @initial_displacement

      @current_iteration << [0, @batch_size - 1] if segment_length(0, @batch_size - 1) > 2

      while @current_iteration.any? do
        from, to = *(@current_iteration.shift)

        midpoint = displace_midpoint(from, to)

        enqueue_segment(from, midpoint)
        enqueue_segment(midpoint, to)
        next_iteration
      end

      @batch
    end

    def displace_midpoint(from, to)
      midpoint = (from + to) / 2
      @batch[midpoint] = (@batch[from] + @batch[to]) / 2 + rand(displacement_bounds)
      midpoint
    end

    def enqueue_segment(from, to)
      @next_iteration << [from, to] if segment_length(from, to) > 2
    end

    def segment_length(from, to)
      to - from + 1
    end

    def next_iteration
      return if @current_iteration.any?
      return if @next_iteration.empty?

      @current_iteration = @next_iteration
      @next_iteration = []
      @displacement = @displacement * @decay
    end

    def displacement_bounds
      -@displacement..@displacement
    end
  end
end
