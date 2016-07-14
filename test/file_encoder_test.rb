require './test/test_helper'
class FileEncoderTest < Minitest::Test
  def test_file_encoder_exists
    fe = ParaMorse::FileEncoder.new
    assert fe
  end

  def test_file_encoder
    fe = ParaMorse::FileEncoder.new
    e = ParaMorse::Encoder.new
    example_string = "the quick brown fox jumped over the lazy dog"
    encoded_string = e.encode(example_string)
    assert_equal encoded_string.length, fe.encode("./test/data/example.txt", "./test/data/encoded_example.txt")
  end
  def test_encode_star_wars_crawl
    fe = ParaMorse::FileEncoder.new
    e = ParaMorse::Encoder.new
    input_file = './test/data/star_wars.txt'
    output_file = './test/data/star_wars_encoded.txt'
    input = File.read(input_file)
    fe.encode(input_file, output_file)
    encoded_file = File.read(output_file)
    assert_equal e.encode(input), encoded_file
  end
end
