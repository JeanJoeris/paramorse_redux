require './test/test_helper'
class LetterDecoderTest < Minitest::Test
  def test_decode_letter
    ld = ParaMorse::LetterDecoder.new

    assert_equal "q", ld.decode("1110111010111")
    assert_equal "r", ld.decode("1011101")
    assert_equal " ", ld.decode("0000000")
  end
end
