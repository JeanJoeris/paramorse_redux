require "./test/test_helper"
class LetterEncodeTest < Minitest::Test
  def test_encode_letter
    le = ParaMorse::LetterEncoder.new
    assert_equal "1", le.encode("e")
    assert_equal "111", le.encode("t")
    assert_equal "0000000", le.encode(" ")
  end

  def test_returns_empty_string_for_failed_encoding
    le = ParaMorse::LetterEncoder.new
    assert_equal "", le.encode("@")
    assert_equal "", le.encode("foo")
    assert_equal "", le.encode("111")
  end
end
