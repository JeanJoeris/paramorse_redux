module ParaMorse
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
end
