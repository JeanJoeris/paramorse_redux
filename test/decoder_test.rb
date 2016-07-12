require './test/test_helper'
class DecoderTest < Minitest::Test
  def test_decode_multiple_chars
    d = ParaMorse::Decoder.new

    assert_equal "ee", d.decode("10001")
    assert_equal "foo", d.decode("1010111010001110111011100011101110111")
    assert_equal "badger", d.decode("11101010100010111000111010100011101110100010001011101")
  end



  def test_decode_words
    d = ParaMorse::Decoder.new
    star_wars_encoded = "10101000111000101110001011101" + "0000000" + "10111011100010111000101110100010101"
    assert_equal "ee ee", d.decode("10001000000010001")
    assert_equal "badger badger", d.decode("11101010100010111000111010100011101110100010001011101000000011101010100010111000111010100011101110100010001011101")
    assert_equal "star wars", d.decode(star_wars_encoded)
  end
end
