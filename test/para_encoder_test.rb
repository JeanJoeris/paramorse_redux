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
    pe.encode_from_file("./test/data/para_input.txt", 1, "./test/data/simple_para_output*.txt")
    encoded_file = File.read("./test/data/simple_para_output00.txt")
    assert_equal encoded_sample, encoded_file
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

    pe.encode_from_file("./test/data/para_input.txt", 2, "./test/data/para_output*.txt")
    encoded_file_00 = File.read("./test/data/para_output00.txt")
    encoded_file_01 = File.read("./test/data/para_output01.txt")

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
      expected_letters[1] += char if index % 8 == 1
      expected_letters[7] += char if index % 8 == 7
    end
    pe.encode_from_file("./test/data/para_input.txt", 8, "./test/data/many_para_output*.txt")
    para_file_00 = File.read('./test/data/many_para_output00.txt')
    para_file_01 = File.read('./test/data/many_para_output01.txt')
    para_file_07 = File.read('./test/data/many_para_output07.txt')
    assert_equal e.encode(expected_letters[0]), para_file_00
    assert_equal e.encode(expected_letters[1]), para_file_01
    assert_equal e.encode(expected_letters[7]), para_file_07
  end

  def test_encode_large_file
    pe = ParaMorse::ParaEncoder.new
    e = ParaMorse::Encoder.new
    input_file = File.read('./test/data/obama_speech.txt')
    expected_letters = Array.new(8, "")
    input_file.chars.each_with_index do |char, index|
      expected_letters[0] += char if index % 8 == 0
      expected_letters[1] += char if index % 8 == 1
      expected_letters[7] += char if index % 8 == 7
    end
    pe.encode_from_file('./test/data/obama_speech.txt',8,'./test/data/obama_encoded_output*.txt')
    para_file_00 = File.read('./test/data/obama_encoded_output00.txt')
    para_file_01 = File.read('./test/data/obama_encoded_output01.txt')
    para_file_07 = File.read('./test/data/obama_encoded_output07.txt')
    assert_equal e.encode(expected_letters[0]), para_file_00
    assert_equal e.encode(expected_letters[1]), para_file_01
    assert_equal e.encode(expected_letters[7]), para_file_07
  end


end
