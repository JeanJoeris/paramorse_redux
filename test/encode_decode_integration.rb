require './test/test_helper'

class EncodeDecodeIntegrationTest < Minitest::Test

  def test_encode_and_decode_char
    e = ParaMorse::Encoder.new
    d = ParaMorse::Decoder.new
    sample_char = 'a'
    encoded_char = e.encode(sample_char)
    assert_equal sample_char, d.decode(encoded_char)
  end

  def test_decode_and_encode_char
    e = ParaMorse::Encoder.new
    d = ParaMorse::Decoder.new
    sample_morse = "111000111"
    decoded_sequence = d.decode(sample_morse)
    assert_equal sample_morse, e.encode(decoded_sequence)
  end

  def test_encode_and_decode_sentence
    e = ParaMorse::Encoder.new
    d = ParaMorse::Decoder.new
    sample_text = 'the quick brown fox jumped over the lazy dog'
    encoded_text = e.encode(sample_text)
    decoded_text = d.decode(encoded_text)
    assert_equal sample_text, decoded_text
  end

end
