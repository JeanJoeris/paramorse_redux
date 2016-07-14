require './test/test_helper'
class LetterDecoderTest < Minitest::Test
  def test_decode_letter
    ld = ParaMorse::LetterDecoder.new

    assert_equal "q", ld.decode("1110111010111")
    assert_equal "r", ld.decode("1011101")
    assert_equal " ", ld.decode("0000000")
  end

  def test_returns_space_for_failed_decoding
    ld = ParaMorse::LetterDecoder.new
    assert_equal " ", ld.decode("aardwolf")
    assert_equal " ", ld.decode("1111")
    assert_equal " ", ld.decode("1110000111")
  end
end
