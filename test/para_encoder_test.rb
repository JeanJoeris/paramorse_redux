require './test/test_helper'

class ParaEncoderTest < Minitest::Test

  def test_para_encoder_exists
    pe = ParaMorse::ParaEncoder.new
    assert pe
  end

  def test_para_encode_one_stream
    # skip
    pe = ParaMorse::ParaEncoder.new
    e = ParaMorse::Encoder.new
    sample_text = "the quick brown fox jumped over the lazy dog"
    encoded_sample = e.encode(sample_text)
    assert_equal encoded_sample.length, pe.encode_to_file("./test/para_input.txt", 1, "./test/simple_para_output*.txt")
  end

  def test_para_encode_two_streams
    pe = ParaMorse::ParaEncoder.new
    e = ParaMorse::Encoder.new

    sample_text = "the quick brown fox jumped over the lazy dog"
    every_other_letter = ""
    every_other_letter_offset = ""
    sample_text.chars.each_with_index do |char, index|
      every_other_letter += char if index % 2 == 0
      every_other_letter_offset += char if index % 2 == 1
    end
    encoded_sample_00 = e.encode(every_other_letter)
    encoded_sample_01 = e.encode(every_other_letter_offset)

    pe.encode_to_file("./test/para_input.txt", 2, "./test/para_output*.txt")
    encoded_file_00 = File.read("./test/para_output00.txt")
    encoded_file_01 = File.read("./test/para_output01.txt")

    assert_equal encoded_sample_00, encoded_file_00
    assert_equal encoded_sample_01, encoded_file_01
  end

  def test_para_encode_many_streams
    pe = ParaMorse::ParaEncoder.new
    e = ParaMorse::Encoder.new
    sample_text = "the quick brown fox jumped over the lazy dog"
    expected_letters = Array.new(8, "")
    sample_text.chars.each_with_index do |char, index|
      expected_letters[0] += char if index % 8 == 0
      expected_letters[7] += char if index % 8 == 7
    end
    pe.encode_to_file("./test/para_input.txt", 8, "./test/many_para_output*.txt")
    para_file_00 = File.read('./test/many_para_output00.txt')
    para_file_07 = File.read('./test/many_para_output07.txt')
    assert_equal e.encode(expected_letters[0]), para_file_00
    assert_equal e.encode(expected_letters[7]), para_file_07
  end


end
