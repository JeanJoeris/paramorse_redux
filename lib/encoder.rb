module ParaMorse
  class Encoder
    def encode(sentence)
      sentence.chomp!
      words = format_for_encoding(sentence)
      encoded_words = words.map do |word|
        encode_word(word)
      end
      encoded_sequence = encoded_words.join("")
    end

    def encode_word(word)
      e = LetterEncoder.new
      letters = word.downcase.split("")
      encoded_letters = letters.map do |letter|
        e.encode(letter)
      end
      encoded_letters.join("000")
    end

    def format_for_encoding(sentence)
      # there has to be a better way to do this...
      # I want to take "string with spaces" and
      # get back ["string", " ", "with", " ", "spaces"]
      sentence.gsub!(" ", " * ")
      words_and_spaces = sentence.split(" ")
      words_and_spaces.map! do |element|
        if element == "*"
          element = " "
        else
          element
        end
      end
      words_and_spaces
    end

    # def delete_trailing_zeroes
    #   deleter = TrailingZeroDeleter.new
    #   deleter(encoded_sequence)
    # end
  end
end
