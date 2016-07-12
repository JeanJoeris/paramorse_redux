module ParaMorse
  class LetterEncoder
    def encode(letter)
      letter = letter.downcase
      Morse[letter]
    end
  end
end
