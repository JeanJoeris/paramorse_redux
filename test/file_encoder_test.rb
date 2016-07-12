require './test/test_helper'
class FileEncoderTest < Minitest::Test
  def test_file_encoder
    fe = ParaMorse::FileEncoder.new
    e = ParaMorse::Encoder.new
    example_string = "the quick brown fox jumped over the lazy dog"
    assert_equal e.encode(example_string).length, fe.encode("./test/example.txt", "./test/encoded_example.txt")
  end
end
