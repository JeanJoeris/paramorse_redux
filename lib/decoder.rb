module ParaMorse
  class Decoder
    def decode(sequence)
      number_of_ending_spaces = find_ending_spaces(sequence)
      morse_words = sequence.split("0000000")
      decoded_words = morse_words.map do |word|
        decode_word(word)
      end
      decoded_sequence = decoded_words.join(" ")
      decoded_sequence += " " * number_of_ending_spaces
      decoded_sequence
    end

    def decode_word(binary_word)
      d = LetterDecoder.new
      letters = binary_word.split("000")
      letters.map{ |letter| d.decode(letter)}.join
    end

    def find_ending_spaces(sequence)
      # uses a regex that finds a string of zeroes at the end
      start_of_ending_zeroes = sequence =~ /0{0,}\z/
      number_of_ending_zeroes = sequence.length - start_of_ending_zeroes
      number_of_ending_spaces = number_of_ending_zeroes / 7
    end
  end
end
