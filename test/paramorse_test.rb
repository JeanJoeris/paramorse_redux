require "minitest/autorun"
require "minitest/pride"
require "./lib/paramorse"

class ParaTest < Minitest::Test
  def test_can_make_new_queue
    assert ParaMorse::Queue.new
  end

  def test_can_push_to_queue
    q = ParaMorse::Queue.new
    # puts q.methods - Object.new.methods
    q.push("1")
    assert_equal ["1"], q.queue
  end

  def test_encode_letter
    le = ParaMorse::LetterEncoder.new

    assert_equal "1", le.encode("e")
    assert_equal "111", le.encode("t")
  end

  def test_decode_letter
    ld = ParaMorse::LetterDecoder.new

    assert_equal "q", ld.decode("1110111010111")
    assert_equal "r", ld.decode("1011101")
  end

  def test_encode_multiple_chars
    e = ParaMorse::Encoder.new
    assert_equal "10111000111010101", e.encode("ab")
    assert_equal "11101010100010111000111010100011101110100010001011101", e.encode("badger")
  end

  def test_decode_multiple_chars
    d = ParaMorse::Decoder.new

    assert_equal "ee", d.decode("10001")
    assert_equal "foo", d.decode("1010111010001110111011100011101110111")
    assert_equal "badger", d.decode("11101010100010111000111010100011101110100010001011101")
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

  def test_decode_words
    d = ParaMorse::Decoder.new
    star_wars_encoded = "10101000111000101110001011101" + "0000000" + "10111011100010111000101110100010101"
    assert_equal "ee ee", d.decode("10001000000010001")
    assert_equal "badger badger", d.decode("11101010100010111000111010100011101110100010001011101000000011101010100010111000111010100011101110100010001011101")
    assert_equal "star wars", d.decode(star_wars_encoded)
  end

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

  def test_file_encoder
    fe = ParaMorse::FileEncoder.new
    e = ParaMorse::Encoder.new
    example_string = "the quick brown fox jumped over the lazy dog"
    assert_equal e.encode(example_string).length, fe.encode("./test/example.txt", "./test/encoded_example.txt")
  end

  def test_file_decoder
    # skip
    fd = ParaMorse::FileDecoder.new
    d = ParaMorse::Decoder.new
    example_string = "11100010101010001000000011101110101110001010111000101000111010111010001110101110000000111010101000101110100011101110111000101110111000111010000000101011101000111011101110001110101011100000001011101110111000101011100011101110001011101110100010001110101000000011101110111000101010111000100010111010000000111000101010100010000000101110101000101110001110111010100011101011101110000000111010100011101110111000111011101"
    assert_equal d.decode(example_string).length, fd.decode("./test/encoded_example_copy.txt", "./test/decoded_example.txt")
  end

end
