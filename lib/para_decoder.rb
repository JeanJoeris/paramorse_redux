module ParaMorse
  class ParaDecoder

    def initialize
      @streams = []
      @decoder = Decoder.new
      @encoded_streams = []
      @decoded_streams = []
    end

    def decode_from_file(input_file_path, stream_num, output_file_path)
      spawn_stream(stream_num)
      read_files_into_streams(input_file_path)
      decode_streams
      result = merge_streams
      write_result(output_file_path, result)
    end

    def spawn_stream(number)
      number.times do
        @streams << StreamDecoder.new
      end
    end

    def read_files_into_streams(input_file_path)
      @streams.each_with_index do |stream, stream_num|
        input_file_name = input_file_path.sub("*", "0"+stream_num.to_s)
        input_file = File.read(input_file_name)
        input_file.delete("")
        @encoded_streams << input_file
      end
    end

    def decode_streams
      @encoded_streams.each do |stream|
        decoded_string = @decoder.decode(stream)
        @decoded_streams << decoded_string
      end
      @decoded_streams.map! do |stream|
        stream.chars
      end
    end

    def merge_streams
      result = ""
      while @decoded_streams.flatten.count >0 do
        @decoded_streams.each do |stream|
          if stream.count >0
            next_stream_char = stream.shift
          else
            next_stream_char = ''
          end
          result +=  next_stream_char
        end
      end
      result
    end

    def write_result(output_file_path, result)
      output_file = File.open(output_file_path, "w")
      output_file.write(result)
      output_file.close
    end
  end
end
