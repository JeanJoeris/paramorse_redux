module ParaMorse
  class FileDecoder
    def initialize
      @decoder = Decoder.new
    end
    def decode(encoded_file_path, decoded_file_path)
      input_file = File.read(encoded_file_path)
      encoded_file = File.open(decoded_file_path, "w")
      count = encoded_file.write(@decoder.decode(input_file))
      encoded_file.close
      count
    end
  end
end
