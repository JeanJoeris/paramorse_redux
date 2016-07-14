module ParaMorse
  class Queue
    attr_accessor :queue

    def initialize
      @queue = []
    end

    def push(bit)
      @queue << bit
    end

    def tail(*n)
      if n.empty?
        @queue.last
      else
        length = @queue.length
        @queue[(length-n[0])..length].reverse
      end
    end

    def peek(*n)
      if n.empty?
        @queue.first
      else
        num_digits = n[0]
        @queue[0..(num_digits-1)]
      end
    end

    def count
      @queue.count
    end

    def pop(*n)
      if n.empty?
        @queue.pop
      else
        num_digits = n[0]
        @queue.pop(num_digits)
      end
    end

    def clear
      @queue = []
    end
  end
end
