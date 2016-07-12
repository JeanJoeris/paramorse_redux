module ParaMorse
  class StreamEncoder
    def initialize
      @encoder = Encoder.new
      @queue = ParaMorse::Queue.new
    end

    def receive(char)
      @queue.push(char)
    end

    def encode
      sequence = @queue.queue.join
      @queue.queue = []
      @encoder.encode(sequence)
    end
  end
end
