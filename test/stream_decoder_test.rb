require './test/test_helper'
class StreamDecoderTest < Minitest::Test
  def test_stream_decoder_exists
    s = ParaMorse::StreamDecoder.new

    assert s
  end

  def test_stream_decoder_1_char
    # skip
    s = ParaMorse::StreamDecoder.new
    s.receive("1")

    assert_equal "e", s.decode
  end

  def test_stream_decode_resets_after_each_decode
    s = ParaMorse::StreamDecoder.new
    s.receive("1")
    assert_equal "e", s.decode
    s.receive("1")
    s.receive("1")
    s.receive("1")
    assert_equal "t", s.decode
  end

  def test_stream_decode_a_word
    s = ParaMorse::StreamDecoder.new
    badger_encoded = "11101010100010111000111010100011101110100010001011101"
    badger_encoded.chars.each do |char|
      s.receive(char)
    end

    assert_equal "badger", s.decode
  end

  def test_stream_decode_multiple_words
    s = ParaMorse::StreamDecoder.new
    star_wars_encoded = "10101000111000101110001011101" + "0000000" + "10111011100010111000101110100010101"
    star_wars_encoded.chars.each do |char|
      s.receive(char)
    end

    assert_equal "star wars", s.decode
  end

  def test_deletes_trailing_zeros
    # skip
    s = ParaMorse::StreamDecoder.new
    s.receive("1")
    s.receive("0")
    assert_equal "e", s.decode
    s.receive("1")
    s.receive("1")
    s.receive("1")
    20.times do
      s.receive("0")
    end
    assert_equal "t", s.decode
  end
end
