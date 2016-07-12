class LetterDecoderTest < Minitest::Test
  def test_decode_letter
    ld = ParaMorse::LetterDecoder.new

    assert_equal "q", ld.decode("1110111010111")
    assert_equal "r", ld.decode("1011101")
  end
end
