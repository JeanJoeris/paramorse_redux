module ParaMorse
  class LetterDecoder
    def decode(binary_letter)
      letter = Morse.key(binary_letter)
      if letter == nil
        letter = " "
      end
      letter
    end
  end
end
