require './test/test_helper'
class FileDecoder < Minitest::Test
  def test_file_decoder
    # skip
    fd = ParaMorse::FileDecoder.new
    d = ParaMorse::Decoder.new
    example_string = "11100010101010001000000011101110101110001010111000101000111010111010001110101110000000111010101000101110100011101110111000101110111000111010000000101011101000111011101110001110101011100000001011101110111000101011100011101110001011101110100010001110101000000011101110111000101010111000100010111010000000111000101010100010000000101110101000101110001110111010100011101011101110000000111010100011101110111000111011101"
    assert_equal d.decode(example_string).length, fd.decode("./test/encoded_example_copy.txt", "./test/decoded_example.txt")
  end

  def test_on_stream_encoded_files
    fd = ParaMorse::FileDecoder.new
    puts fd.decode('./test/para_output00.txt', 'decoded_para_out00.txt')
    puts fd.decode('./test/para_output01.txt', 'decoded_para_out01.txt')
  end
end
