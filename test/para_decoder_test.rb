require './test/test_helper'
class ParaDecoderTest < Minitest::Test

  def test_para_decoder_exists
    pd = ParaMorse::ParaDecoder.new
    assert pd
  end

  def test_1_stream_para_decoding
    # skip
    pd = ParaMorse::ParaDecoder.new
    d = ParaMorse::Decoder.new
    e = ParaMorse::Encoder.new
    sample_text = "the quick brown fox jumped over the lazy dog"
    encoded_sample = e.encode(sample_text)
    decoded_sample = d.decode(encoded_sample)
    pd.decode_from_file('./test/data/simple_para_output*.txt', 1, './test/data/simple_para_decoded.txt')
    decoded_file = File.read('./test/data/simple_para_decoded.txt')
    assert_equal decoded_sample, decoded_file
  end

  def test_2_stream_para_decoding
    pd = ParaMorse::ParaDecoder.new
    sample_text = "the quick brown fox jumped over the lazy dog"
    pd.decode_from_file('./test/data/para_output*.txt', 2, './test/data/two_stream_para_decoded.txt')
    decoded_file = File.read('./test/data/two_stream_para_decoded.txt')
    assert_equal sample_text, decoded_file
  end

  def test_many_stream_para_decoding
    pd = ParaMorse::ParaDecoder.new
    sample_text = "the quick brown fox jumped over the lazy dog"
    pd.decode_from_file('./test/data/many_para_output*.txt', 8, './test/data/many_para_decoded.txt')
    decoded_file = File.read('./test/data/many_para_decoded.txt')
    assert_equal sample_text, decoded_file
  end

  def test_decode_large_parallel_files
    # skip
    pd = ParaMorse::ParaDecoder.new
    expected_text = File.read('./test/data/obama_speech.txt').downcase
    expected_text.gsub!("\n", "")
    pd.decode_from_file('./test/data/obama_encoded_output*.txt', 8, './test/data/obama_decoded_output.txt')
    output_text = File.read('./test/data/obama_decoded_output.txt')
    assert_equal expected_text, output_text
  end
end
