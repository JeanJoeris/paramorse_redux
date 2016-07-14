module ParaMorse
  class Decoder
    def decode(sequence)
      morse_words = sequence.split("0000000")
      decode_words = morse_words.map do |word|
        decode_word(word)
      end
      decoded_sequence = decode_words.join(" ")
      decoded_sequence += " " if sequence.end_with?("0"*7)
      decoded_sequence
    end

    def decode_word(binary_word)
      d = LetterDecoder.new
      letters = binary_word.split("000")
      letters.map{ |letter| d.decode(letter)}.join
    end
  end
end
