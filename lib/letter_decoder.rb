module ParaMorse
  class LetterDecoder
    def decode(binary_letter)
      Morse.key(binary_letter)
    end
  end
end
