module ParaMorse
  class LetterEncoder
    def encode(letter)
      letter = letter.downcase
      morse_letter = Morse[letter]
      if morse_letter == nil
        morse_letter = ""
      end
      morse_letter
    end
  end
end
