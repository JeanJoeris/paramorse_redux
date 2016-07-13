require './test/test_helper'

class ParaEncoderTest < Minitest::Test

  def test_para_encoder_exists
    pe = ParaMorse::ParaEncoder.new
    assert pe
  end

  def test_para_encode_one_stream
    skip
    pe = ParaMorse::ParaEncoder.new
    e = ParaMorse::Encoder.new
    sample_text = "the quick brown fox jumped over the lazy dog"
    encoded_sample = e.encode(sample_text)
    assert_equal encoded_sample.length, pe.encode_to_file("./test/para_input.txt", 1, "./test/para_output*.txt")
  end

  def test_para_encode_two_streams
    pe = ParaMorse::ParaEncoder.new
    e = ParaMorse::Encoder.new
    sample_text = "the quick brown fox jumped over the lazy dog"
      encoded_sample = e.encode(sample_text)
    sample_length = encoded_sample.length - 3 # <~~ -3 because each additional stream gets rid of one trailing char break (000)
    assert_equal sample_length, pe.encode_to_file("./test/para_input.txt", 2, "./test/para_output*.txt")
  end

  def test_para_encode_many_streams
    pe = ParaMorse::ParaEncoder.new
    e = ParaMorse::Encoder.new
    sample_text = "the quick brown fox jumped over the lazy dog"
    expected_letters = ""
    sample_text.chars.each_with_index do |char, index|
      # p char if index % 8 == 0
      expected_letters += char if index % 8 == 0
    end
    pe.encode_to_file("./test/para_input.txt", 8, "./test/many_para_output*.txt")
    para_file_00 = File.read('./test/many_para_output00.txt')
    assert_equal e.encode(expected_letters), para_file_00
  end


end
