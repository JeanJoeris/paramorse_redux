require './test/test_helper'
class EncoderTest < Minitest::Test
  def test_encode_multiple_chars
    e = ParaMorse::Encoder.new
    assert_equal "10111000111010101", e.encode("ab")
    assert_equal "11101010100010111000111010100011101110100010001011101", e.encode("badger")
  end
  def test_encode_words
    e = ParaMorse::Encoder.new
    badger_encoded = "11101010100010111000111010100011101110100010001011101"
    expected_string = badger_encoded + "0000000" + badger_encoded
    star_wars_encoded = "10101000111000101110001011101" + "0000000" + "10111011100010111000101110100010101"
    assert_equal "10001000000010001", e.encode("ee ee")
    assert_equal expected_string, e.encode("badger badger")
    assert_equal star_wars_encoded, e.encode("star wars")
  end
end
