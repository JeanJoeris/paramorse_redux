module ParaMorse
  class FileEncoder
    def initialize
      @encoder = Encoder.new
    end
    def encode(input_file_path, encoded_file_path)
      input_file = File.read(input_file_path)
      encoded_file = File.open(encoded_file_path, "w")
      count = encoded_file.write(@encoder.encode(input_file))
      encoded_file.close
      count
    end
  end
end
