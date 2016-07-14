require './test/test_helper'
class FileDecoder < Minitest::Test
  def test_file_decoder_exits
    fd = ParaMorse::FileDecoder.new
    assert fd
  end

  def test_file_decoder
    fd = ParaMorse::FileDecoder.new
    d = ParaMorse::Decoder.new
    example_string = "11100010101010001000000011101110101110001010111000101000111010111010001110101110000000111010101000101110100011101110111000101110111000111010000000101011101000111011101110001110101011100000001011101110111000101011100011101110001011101110100010001110101000000011101110111000101010111000100010111010000000111000101010100010000000101110101000101110001110111010100011101011101110000000111010100011101110111000111011101"
    assert_equal d.decode(example_string).length, fd.decode("./test/data/encoded_example_copy.txt", "./test/data/decoded_example.txt")
  end

  def test_star_wars_crawl
    fd = ParaMorse::FileDecoder.new
    d = ParaMorse::Decoder.new
    starting_file = './test/data/star_wars.txt'
    input_file = './test/data/star_wars_encoded.txt'
    output_file = './test/data/star_wars_decoded.txt'
    starting_text = File.read(starting_file).downcase.chomp
    starting_text.gsub!(/[!@$#%^&*,.]/, ' ')
    input_code = File.read(input_file)
    fd.decode(input_file, output_file)
    output_code = File.read(output_file)
    assert_equal d.decode(input_code), output_code
    assert_equal starting_text, output_code
  end
end
