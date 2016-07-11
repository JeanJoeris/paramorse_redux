#Iterations 0,1,2,3

module ParaMorse
  Morse = {
    "a" => "10111",
    "b" => "111010101",
    "c" => "11101011101",
    "d" => "1110101",
    "e" => "1",
    "f" => "101011101",
    "g" => "111011101",
    "h" => "1010101",
    "i" => "101",
    "j" => "1011101110111",
    "k" => "111010111",
    "l" => "101110101",
    "m" => "1110111",
    "n" => "11101",
    "o" => "11101110111",
    "p" => "10111011101",
    "q" => "1110111010111",
    "r" => "1011101",
    "s" => "10101",
    "t" => "111",
    "u" => "1010111",
    "v" => "101010111",
    "w" => "101110111",
    "x" => "11101010111",
    "y" => "1110101110111",
    "z" => "11101110101",
    " " => "000000",
    "1" => "10111011101110111",
    "2" => "101011101110111",
    "3" => "1010101110111",
    "4" => "10101010111",
    "5" => "101010101",
    "6" => "11101010101",
    "7" => "1110111010101",
    "8" => "111011101110101",
    "9" => "11101110111011101",
    "0" => "1110111011101110111" }

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
        num_digits = n[0]
        length = @queue.length
        @queue[(length-n[0])..length].reverse
      end
    end

    def peek(*n)
      if n.empty?
        @queue.first
      else
        num_digits = n[0]
        if num_digits == 0
          return []
        end
        @queue[0..(num_digits-1)]
      end
    end

    def count
      @queue.count
    end

    def pop(*n)
      if n.empty
        @queue.pop
      else
        num_digits = n[0]
        @queue.pop(num_digits).reverse
      end
    end

    def clear
      @queue = []
    end
  end

  class LetterEncoder
    def encode(letter)
      letter = letter.downcase
      Morse[letter]
    end
  end

  class LetterDecoder
    def decode(binary_letter)
      Morse.key(binary_letter)
    end
  end

  class Encoder
    def encode(word)
      e = LetterEncoder.new
      letters = word.downcase.split("")
      letters.map{ |letter| e.encode(letter)}.join("000")
    end
  end

  class Decoder
    def decode(binary_word)
      d = LetterDecoder.new
      letters = binary_word.split("000")
      letters.map{ |letter| d.decode(letter)}.join
    end
  end
end
