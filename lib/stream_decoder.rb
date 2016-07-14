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
      @queue.clear
      sequence = delete_trailing_zeroes(sequence)
      @decoder.decode(sequence)
    end

    def delete_trailing_zeroes(sequence)
      zero_deleted_sequence = sequence
      while end_with_non_space_zeros?(sequence)
        zero_deleted_sequence.chop!
      end
      zero_deleted_sequence
    end

    def end_with_non_space_zeros?(sequence)
      if sequence =~ /10{1,6}\z/
        true
      else
        false
      end
    end
  end
end
