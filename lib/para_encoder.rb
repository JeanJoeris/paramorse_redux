module ParaMorse
  class ParaEncoder

    def initialize
      @streams = []
      @file_encoder = FileEncoder.new
    end

    def encode_to_file(input_file_path, stream_num, output_file_path)
      spawn_stream(stream_num)
      input_file = File.read(input_file_path).chomp
      distribute_to_streams(input_file.chars)
      encode_and_write_streams(output_file_path)
    end

    def encode_and_write_streams(output_file_path)
      bit_count = 0 # <~~ this is for testing verification
      @streams.each_with_index do |stream, stream_num|
        output_file_name = output_file_path.sub("*","0"+stream_num.to_s)
        output_file = File.open(output_file_name, "w")
        encoded_string = stream.encode
        output_file.write(encoded_string)
        bit_count += encoded_string.length
      end
      bit_count
    end

    def distribute_to_streams(input_chars)
      while input_chars.count >0 do
        @streams.each_with_index do |stream, stream_num|
          char = input_chars.shift
          # p "char is #{char}, stream num is #{stream_num}"
          # puts input_chars.join
          stream.receive(char)
        end
      end
    end

    def spawn_stream(number)
      number.times do
        @streams << StreamEncoder.new
      end
    end

  end
end
