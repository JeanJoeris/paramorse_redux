require "./test/test_helper"
class LetterEncodeTest < Minitest::Test
  def test_encode_letter
    le = ParaMorse::LetterEncoder.new
    assert_equal "1", le.encode("e")
    assert_equal "111", le.encode("t")
    assert_equal "0000000", le.encode(" ")
  end
end
