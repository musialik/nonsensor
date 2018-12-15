require_relative "nonsensor/version"

module Nonsensor
  class MidpointDisplacement
    attr_reader :start, :batch, :batch_size

    def initialize(start: 0.0, jitter: 50.0, jitter_reduction: 0.5, batch_size: 100)
      @start = start
      @initial_jitter = jitter
      @jitter = jitter
      @jitter_reduction = jitter_reduction
      @batch_size = batch_size
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
      @jitter = @initial_jitter
      @segments = []
      @segments << [0, @batch_size - 1]
      @next_iteration_segments = []

      while @segments.any? do
        from, to = *(@segments.shift)

        midpoint = displace_midpoint(from, to)

        enqueue_segment_conditionally(from, midpoint)
        enqueue_segment_conditionally(midpoint, to)
        start_next_iteration_conditionally
      end

      @segments = []
      @next_iteration_segments = []
      @batch
    end

    def displace_midpoint(from, to)
      midpoint = (from + to) / 2
      @batch[midpoint] = (@batch[from] + @batch[to]) / 2 + rand(-@jitter..@jitter)
      midpoint
    end

    def enqueue_segment_conditionally(from, to)
      @next_iteration_segments << [from, to] if segment_length(from, to) > 2
    end

    def segment_length(from, to)
      to - from + 1
    end

    def start_next_iteration_conditionally
      return if @segments.any?
      return if @next_iteration_segments.empty?

      @segments = @next_iteration_segments
      @next_iteration_segments = []
      @jitter = @jitter * @jitter_reduction
      puts @jitter
    end
  end
end
