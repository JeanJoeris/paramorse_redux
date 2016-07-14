module ParaMorse
  class ParaEncoder

    def initialize
      @streams = []
    end

    def encode_from_file(input_file_path, stream_num, output_file_path)
      spawn_stream(stream_num)
      input_file = File.read(input_file_path)
      input_file.delete("!@#$%^&*()\/<>?\n")
      distribute_to_streams(input_file.chars)
      encode_and_write_streams(output_file_path)
    end

    def encode_and_write_streams(output_file_path)
      @streams.each_with_index do |stream, stream_num|
        output_file_name = output_file_path.sub("*","0"+stream_num.to_s)
        output_file = File.open(output_file_name, "w")
        encoded_string = stream.encode
        output_file.write(encoded_string)
        output_file.close
      end
    end

    def distribute_to_streams(input_chars)
      while input_chars.count >0 do
        @streams.each do |stream|
          char = input_chars.shift
          stream.receive(char) if char != nil
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
