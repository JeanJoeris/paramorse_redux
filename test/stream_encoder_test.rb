require './test/test_helper'

class StreamEncoderTest < Minitest::Test
  def test_stream_encoder_exits
    se = ParaMorse::StreamEncoder.new

    assert se
  end

  def test_stream_encoder_encodes_1_char
    se = ParaMorse::StreamEncoder.new
    se.receive("e")
    assert_equal "1", se.encode
  end

  def test_stream_encoder_clears_queue_on_encode
    se = ParaMorse::StreamEncoder.new
    se.receive("e")
    assert_equal "1", se.encode
    se.receive("t")
    assert_equal "111", se.encode
    se.receive(" ")
    # assert_equal "0000000", se.encode
  end

  def test_stream_encode_a_word
    se = ParaMorse::StreamEncoder.new
    string = "badger"
    encoded_string = "11101010100010111000111010100011101110100010001011101"
    string.chars.each do |char|
      se.receive(char)
    end
    assert_equal encoded_string, se.encode
  end

  def test_stream_encode_with_space
    # skip
    se = ParaMorse::StreamEncoder.new
    string = "e e"
    string.chars.each do |char|
      se.receive(char)
    end
    encoded_string = "100000001"
    assert_equal encoded_string, se.encode
    string = "star wars"
    star_wars_encoded = "10101000111000101110001011101" + "0000000" + "10111011100010111000101110100010101"
    string.chars.each do |char|
      se.receive(char)
    end
    assert_equal star_wars_encoded, se.encode
  end

  def test_multiple_white_space
    # skip # not even sure if this is the behavior I want, doesn't pass
    se = ParaMorse::StreamEncoder.new
    string = "e  e"
    string.chars.each do |char|
      se.receive(char)
    end
    assert_equal "1000000000000001", se.encode
  end

end
