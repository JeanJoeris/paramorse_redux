require './test/test_helper'
class LetterDecoderTest < Minitest::Test
  def test_decode_letter
    ld = ParaMorse::LetterDecoder.new

    assert_equal "q", ld.decode("1110111010111")
    assert_equal "r", ld.decode("1011101")
    assert_equal " ", ld.decode("0000000")
  end

  def test_returns_empty_string_for_failed_decoding
    ld = ParaMorse::LetterDecoder.new
    assert_equal "", ld.decode("@")
    assert_equal "", ld.decode("ffasjdfjksdla")
    assert_equal "", ld.decode("1111")
  end
end
