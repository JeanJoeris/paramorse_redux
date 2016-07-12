module ParaMorse
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
