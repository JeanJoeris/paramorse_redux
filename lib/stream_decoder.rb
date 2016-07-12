module ParaMorse
  class StreamDecoder
    def initialize
      @decoder = Decoder.new
      @queue = ParaMorse::Queue.new
    end

    def receive(bit)
        bit = "0" if bit.length >1

      @queue.push(bit)
    end

    def decode
      sequence = @queue.queue.join
      @queue.queue = []
      sequence = delete_trailing_zeroes(sequence)
      @decoder.decode(sequence)
    end

    def delete_trailing_zeroes(sequence)
      zero_deleted_sequence = sequence
      while sequence.end_with?("0")
        zero_deleted_sequence.chop!
      end
      zero_deleted_sequence
    end
  end
end
