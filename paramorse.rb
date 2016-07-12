#Iterations 0,1,2,3
require 'pry'
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
    def encode(sentence)
      words = sentence.split(" ")
      encoded_words = words.map do |word|
        encode_word(word)
      end
      encoded_words.join("0000000")
    end

    def encode_word(word)
      e = LetterEncoder.new
      letters = word.downcase.split("")
      letters.map{ |letter| e.encode(letter)}.join("000")
    end
  end

  class Decoder
    def decode(sequence)
      morse_words = sequence.split("0000000")
      decode_words = morse_words.map do |word|
        decode_word(word)
      end
      decode_words.join(" ")
    end

    def decode_word(binary_word)
      d = LetterDecoder.new
      letters = binary_word.split("000")
      letters.map{ |letter| d.decode(letter)}.join
    end
  end

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

  class FileEncoder
    def initialize
      @encoder = Encoder.new
    end
    def encode(input_file_path, encoded_file_path)
      input_file = File.read(input_file_path)
      input_file.gsub!("\n", " ")
      encoded_file = File.open(encoded_file_path, "w")
      encoded_file.write(@encoder.encode(input_file))
    end
  end

  class FileDecoder
    def initialize
      @decoder = Decoder.new
    end
    def decode(encoded_file_path, decoded_file_path)
      input_file = File.read(encoded_file_path)
      encoded_file = File.open(decoded_file_path, "w")
      encoded_file.write(@decoder.decode(input_file))
    end
  end

end
