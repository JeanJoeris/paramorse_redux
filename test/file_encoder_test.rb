require './test/test_helper'
class FileEncoderTest < Minitest::Test
  def test_file_encoder
    fe = ParaMorse::FileEncoder.new
    e = ParaMorse::Encoder.new
    example_string = "the quick brown fox jumped over the lazy dog"
    encoded_string = e.encode(example_string)
    assert_equal encoded_string.length, fe.encode("./test/data/example.txt", "./test/data/encoded_example.txt")
  end
end
